local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- esc remap
keymap("i", "jj", "<Esc>", opts)
keymap("v", "jj", "<Esc>", opts)

-- Hide search highlights for current search
keymap("n", "<Space>", ":nohlsearch<Bar>:echo<CR>", opts)

-- Horizontal split to vertical split
keymap("n", "<leader>h", "<C-w>H", opts)
keymap("n", "<leader>k", "<C-w>K", opts)

-- split navigations
keymap("n", "<C-j>", "<C-w><C-j>", opts)
keymap("n", "<C-k>", "<C-w><C-k>", opts)
keymap("n", "<C-l>", "<C-w><C-l>", opts)
keymap("n", "<C-h>", "<C-w><C-h>", opts)
-- split navigations in terminal
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

-- open a file in the same dir as the current one (borrowed from mgedmin)
keymap("n", "<leader>E", function()
  return ":e " .. vim.fn.expand("%:h") .. "/"
end, { expr = true, noremap = true })

-- open terminal
vim.keymap.set("n", "<leader>x", function()
  vim.cmd("split")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, opts)
keymap("n", "<leader>X", "<C-\\><C-n>:stop<CR>", opts)

-- Base64 encode from system clipboard and insert
keymap("n", "<leader>64", function()
  local encoded = vim.fn.system("base64 -w 0", vim.fn.getreg('"'))
  return "a" .. encoded
end, { expr = true, noremap = true, silent = true })

-- Base64 decode from system clipboard and insert
keymap("n", "<leader>64d", function()
  local decoded = vim.fn.system("base64 --decode -w 0", vim.fn.getreg('"'))
  return "a" .. decoded
end, { expr = true, noremap = true, silent = true })

-- Left arrow block
keymap("n", "<Left>", ':echo "No left for you!"<CR>', opts)
keymap("v", "<Left>", ':<C-u>echo "No left for you!"<CR>', opts)
keymap("i", "<Left>", '<C-o>:echo "No left for you!"<CR>', opts)

-- Right arrow block
keymap("n", "<Right>", ':echo "No right for you!"<CR>', opts)
keymap("v", "<Right>", ':<C-u>echo "No right for you!"<CR>', opts)
keymap("i", "<Right>", '<C-o>:echo "No right for you!"<CR>', opts)

-- Up arrow block
keymap("n", "<Up>", ':echo "No up for you!"<CR>', opts)
keymap("v", "<Up>", ':<C-u>echo "No up for you!"<CR>', opts)
keymap("i", "<Up>", '<C-o>:echo "No up for you!"<CR>', opts)

-- Down arrow block
keymap("n", "<Down>", ':echo "No down for you!"<CR>', opts)
keymap("v", "<Down>", ':<C-u>echo "No down for you!"<CR>', opts)
keymap("i", "<Down>", '<C-o>:echo "No down for you!"<CR>', opts)

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

-- Telescope remaps
-- open find files
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
-- open find buffers
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
-- open live grep
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
-- references
keymap("n", "<leader>gr", require("telescope.builtin").lsp_references, opts)
-- document symbols - functions
keymap("n", "<leader>dd", ":Telescope lsp_document_symbols<CR>", opts)
-- git conflicts
vim.keymap.set("n", "<leader>gc", function()
  require("telescope.builtin").git_status({
    prompt_title = "Git Conflicts",
    git_command = { "git", "diff", "--name-only", "--diff-filter=U" },
  })
end)

-- Nvim Tree
keymap("n", "<C-n>", ":NvimTreeFocus<CR>", opts)
keymap("n", "<C-c>", ":NvimTreeClose<CR>", opts)

-- Go mappings
keymap("n", "<leader>t", ":GoTest<CR>", opts)
keymap("n", "<leader>tf", ":GoTestFunc<CR>", opts)
keymap("n", "<leader>ie", ":GoIfErr<CR>", opts)

keymap("n", "<leader>gi", function()
  local line = vim.fn.getline(".")
  local match = vim.fn.matchlist(line, [[\vvar\s+(\w+)\s*=\s*(\w+)\{\}]])
  if #match >= 3 then
    local name, iface = match[2], match[1]
    vim.cmd("GoImpl _ " .. name .. " " .. iface)
  else
    print("No match for GoImpl pattern.")
  end
end, opts)
