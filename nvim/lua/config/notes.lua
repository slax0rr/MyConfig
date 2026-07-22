local M = {}
local state = {
  buf = nil,
  win = nil,
}

M.path = vim.fn.expand("~/Documents/notes.md")

local function ensure_notes_file()
  local dir = vim.fn.fnamemodify(M.path, ":h")

  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end

  if vim.fn.filereadable(M.path) == 0 then
    vim.fn.writefile({ "# Notes", "" }, M.path)
  end
end

local function float_config()
  local max_width = math.max(vim.o.columns - 4, 1)
  local max_height = math.max(vim.o.lines - 4, 1)
  local width = math.min(math.max(math.floor(vim.o.columns * 0.75), 80), max_width)
  local height = math.min(math.max(math.floor(vim.o.lines * 0.75), 20), max_height)
  local row = math.max(math.floor((vim.o.lines - height) / 2) - 1, 0)
  local col = math.max(math.floor((vim.o.columns - width) / 2), 0)

  return {
    relative = "editor",
    style = "minimal",
    border = "rounded",
    title = " Notes ",
    title_pos = "center",
    width = width,
    height = height,
    row = row,
    col = col,
  }
end

local function apply_window_settings(win)
  vim.wo[win].foldmethod = "expr"
  vim.wo[win].foldexpr = "v:lua.notes_markdown_foldexpr(v:lnum)"
  vim.wo[win].foldenable = true
  vim.wo[win].foldlevel = 0
end

local function close_current_float()
  local win = vim.api.nvim_get_current_win()
  if not vim.api.nvim_win_is_valid(win) then
    return false
  end

  local config = vim.api.nvim_win_get_config(win)
  if config.relative == "" then
    return false
  end

  local buf = vim.api.nvim_win_get_buf(win)
  if vim.bo[buf].modified then
    local ok, err = pcall(vim.api.nvim_buf_call, buf, function()
      vim.cmd("silent write")
    end)

    if not ok then
      vim.notify("Could not save notes: " .. tostring(err), vim.log.levels.ERROR)
      return false
    end
  end

  if vim.api.nvim_get_mode().mode:sub(1, 1) == "i" then
    vim.cmd("stopinsert")
  end

  vim.api.nvim_win_close(win, false)
  return true
end

function M.open()
  ensure_notes_file()

  if state.buf == nil or not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = vim.fn.bufadd(M.path)
  end

  vim.fn.bufload(state.buf)
  vim.bo[state.buf].bufhidden = "wipe"

  if not vim.b[state.buf].notes_q_mapped then
    vim.keymap.set("n", "q", function()
      close_current_float()
    end, { buffer = state.buf, noremap = true, silent = true, desc = "Close notes window" })

    vim.keymap.set("n", "<Esc>", function()
      close_current_float()
    end, { buffer = state.buf, noremap = true, silent = true, desc = "Close notes window" })

    vim.keymap.set("n", "<Tab>", function()
      vim.cmd("normal! za")
    end, { buffer = state.buf, noremap = true, silent = true, desc = "Toggle fold" })

    vim.b[state.buf].notes_q_mapped = true
  end

  local config = float_config()

  if state.win ~= nil and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_set_buf(state.win, state.buf)
    vim.api.nvim_win_set_config(state.win, config)
    apply_window_settings(state.win)
    vim.api.nvim_set_current_win(state.win)
    return
  end

  state.win = vim.api.nvim_open_win(state.buf, true, config)
  apply_window_settings(state.win)
end

function M.markdown_foldexpr(lnum)
  local line = vim.fn.getline(lnum)
  local hashes = line:match("^(#+)%s+")

  if hashes then
    return ">" .. #hashes
  end

  return "="
end

function M.setup()
  local augroup = vim.api.nvim_create_augroup("notes_markdown_settings", { clear = true })

  _G.notes_markdown_foldexpr = M.markdown_foldexpr

  pcall(vim.api.nvim_del_user_command, "Notes")
  vim.api.nvim_create_user_command("Notes", M.open, {
    desc = "Open the notes markdown file",
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "markdown",
    callback = function()
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "v:lua.notes_markdown_foldexpr(v:lnum)"
      vim.opt_local.foldlevel = 99
    end,
  })

  vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    callback = function()
      if state.win == nil or not vim.api.nvim_win_is_valid(state.win) then
        return
      end

      vim.api.nvim_win_set_config(state.win, float_config())
    end,
  })

  vim.api.nvim_create_autocmd("WinClosed", {
    group = augroup,
    callback = function(args)
      if tonumber(args.match) == state.win then
        state.win = nil
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufWipeout", {
    group = augroup,
    callback = function(args)
      if args.buf == state.buf then
        state.buf = nil
      end
    end,
  })
end

return M
