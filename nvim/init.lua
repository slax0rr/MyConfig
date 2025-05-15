vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

-- Load and install the plugin manager (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins using lazy.nvim
require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "NvimTree", "packer" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
  {
    "Saghen/blink.cmp",
    version = "1.*", -- Use the latest stable version
    dependencies = { "rafamadriz/friendly-snippets" }, -- Optional: for snippet support
    opts = {
      keymap = { preset = "default" }, -- Preset key mappings
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = false },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig").gopls.setup({
        capabilities = capabilities,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "go", "lua", "gomod", "gowork", "gosum" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
    -- The correct way to trigger :TSUpdate without breaking sync
    init = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          layout_config = { horizontal = { preview_width = 0.6 } },
          mappings = { i = { ["<C-u>"] = false } },
        },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable("make") == 1,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 45,
          side = "left",
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              folder = true,
              file = true,
              git = true,
            },
          },
        },
        update_focused_file = {
          enable = true,
        },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "│" },
          change       = { text = "│" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
          untracked    = { text = "┆" },
        },
        current_line_blame = false,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local opts = { buffer = bufnr, noremap = true, silent = true }
        end,
      })
    end,
  },
  {
    "f-person/git-blame.nvim",
    config = function()
      require("gitblame").setup({
        enabled = true,
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- enables smarter behavior with Treesitter
      })
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    config = function()
      require("go").setup()
    end,
    ft = { "go", "gomod" },
  },
})

--------------------------
-- Color scheme settings -
--------------------------

-- Term GUI colors
vim.opt.termguicolors = true

-- status line
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#494d64" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#181825" })

-- set color for listchars
vim.api.nvim_set_hl(0, "NonText", {
  bg = "NONE",
  fg = "#363a4f",
})

vim.api.nvim_set_hl(0, "SpecialKey", {
  bg = "NONE",
  fg = "#363a4f",
})

-- Cursor line and column colors
vim.api.nvim_set_hl(0, "CursorLine", {
  underline = true,
  bg = "NONE",
})

vim.api.nvim_set_hl(0, "CursorColumn", {
  bg = "#313244",
})

-- Highlight 80 and 120 columns
vim.opt.colorcolumn = { 80, unpack(vim.fn.range(120, 129)) }

-- Add cursorline and cursorcolumn
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

--------------------
-- Editor settings -
--------------------

-- Filetype plugin and indent
vim.cmd("filetype plugin indent on")

-- Fast update time for CursorHold, etc.
vim.opt.updatetime = 50

-- Tab and indent settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Directories for swap, undo, backup
vim.opt.backupdir = vim.fn.expand("~/tmp")
vim.opt.undodir = vim.fn.expand("~/tmp/un")
vim.opt.directory = vim.fn.expand("~/tmp/sw")
vim.opt.undofile = true

-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true -- add absolute numbers too

-- Backspace behavior
vim.opt.backspace = { "indent", "eol", "start" }

-- Command-line completion menu
vim.opt.wildmenu = true

-- Custom ctags
vim.opt.tags = ".tags;"

-- Disable mouse
vim.opt.mouse = ""

-- Visualize whitespace
vim.opt.listchars = {
  eol = "¬",
  tab = ">·",
  trail = "~",
  extends = ">",
  precedes = "<",
}
vim.opt.list = true

-- Visual bell
vim.opt.visualbell = false

-- Reopen file on same line as it was closed
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.fn.line([['"]])
    if mark > 1 and mark <= vim.fn.line("$") then
      vim.cmd('normal! g\'"')
    end
  end,
})

-- set sql ft for *.pgsql files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.pgsql",
  command = "set filetype=sql",
})

-- re-enter insert mode on terminal
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  callback = function()
    if vim.fn.mode() ~= "i" then
      vim.cmd("startinsert")
    end
  end,
})

------------------
-- Plugin config -
------------------
package.loaded["plugin"] = nil
require("plugin")

------------
-- Keymaps -
------------
package.loaded["keymaps"] = nil
require("keymaps")
