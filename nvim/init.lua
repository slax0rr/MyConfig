vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

-- load and install the plugin manager (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function open_codex(cmd)
  local codex = require("codex")
  local state = require("codex.state")

  -- If a Codex job is already running, reopen/focus it instead of starting a second one.
  if state.job then
    codex.open()
    return
  end

  codex.setup({
    autoinstall = false,
    panel = true,
    use_buffer = false,
    cmd = cmd,
  })
  codex.open()
end

-- load plugins using lazy.nvim
require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    commit = "426dbebe06b5c69fd846ceb17b42e12f890aedf1",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
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
          lualine_c = {
            { "filename", path = 1 }
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            { "filename", path = 1 }
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
  {
    "Saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = {
        preset = "enter",
        ['<Tab>'] = {
          function(cmp)
            if cmp.is_visible() then return cmp.select_next() end
          end,
          'snippet_forward',
          'fallback'
        },
        ['<S-Tab>'] = {
          function(cmp)
            if cmp.is_visible() then return cmp.select_prev() end
          end,
          'snippet_backward',
          'fallback'
        },
        ['<C-o>'] = { 'show' },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true },
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "Saghen/blink.cmp", "hashivim/vim-terraform" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.gopls.setup({ capabilities = capabilities })
      lspconfig.terraformls.setup({ capabilities = capabilities })
    end,
  },
  {
    "hashivim/vim-terraform",
    ft = { "terraform" },
    init = function()
      vim.g.terraform_fmt_on_save = 0
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        lua = { "stylua" },
      },
      format_on_save = function(bufnr)
        -- Go is handled by gopls in lua/config/go.lua; skip here to avoid double-format.
        if vim.bo[bufnr].filetype == "go" then return end
        return { timeout_ms = 1000, lsp_fallback = false }
      end,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "go", "lua", "gomod", "gowork", "gosum", "hcl", "terraform" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = { "<leader>ff", "<leader>fb", "<leader>fg", "<leader>gr", "<leader>dd", "<leader>gc", "<leader>gh", "<leader>fd" },
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
    cmd = { "NvimTreeFocus", "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeFindFile" },
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
    cmd = { "GitBlameToggle", "GitBlameEnable", "GitBlameOpenCommitURL", "GitBlameCopySHA" },
    keys = {
      { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle git blame virtual text" },
    },
    config = function()
      require("gitblame").setup({
        enabled = false,
        highlight_group = "GitBlameVirtualText",
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    ft = { "go", "gomod" },
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        mappings = {
          basic = true,
          extra = false,
        },
      })
    end,
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_auto_start = 0
    end,
  },
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>a", group = "AI" },
        { "<leader>c", group = "Comment / Code" },
        { "<leader>f", group = "Find (Telescope)" },
        { "<leader>g", group = "Git / Go" },
        { "<leader>r", group = "Refactor" },
        { "<leader>t", group = "Test" },
      },
    },
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      {
        "<C-,>",
        "<cmd>ClaudeCodeFocus --continue<cr>",
        mode = { "n", "x" },
        desc = "Toggle Claude Code with continue",
      },
      {
        "<leader>an",
        "<cmd>ClaudeCode<cr>",
        desc = "New Claude session",
      },
      {
        "<leader>ar",
        "<cmd>ClaudeCode --resume<cr>",
        desc = "Resume Claude session",
      },
    },
    opts = {
      focus_after_send = false,
      track_selection = true,
      terminal = {
        split_side = "right",
        split_width_percentage = 0.35,
        provider = "auto", -- "auto", "toggleterm", or "snacks"
      },
      log_level = "info", -- "trace", "debug", "info", "warn", "error"
    },
  },
  {
    "johnseth97/codex.nvim",
    cmd = { "Codex", "CodexToggle" },
    keys = {
      {
        "<leader>ax",
        function()
          open_codex({ "codex", "resume", "--last" })
        end,
        desc = "Resume last Codex session",
        mode = "n",
      },
      {
        "<leader>aX",
        function()
          open_codex({ "codex" })
        end,
        desc = "New Codex session",
        mode = "n",
      },
    },
    opts = {
      autoinstall = false,
      panel = true,
      use_buffer = false,
    },
  },
  {
    "suiramdev/cursorcli.nvim",
    dependencies = { "folke/snacks.nvim" },
    cmd = {
      "CursorCliOpen",
      "CursorCliOpenWithLayout",
      "CursorCliClose",
      "CursorCliToggle",
      "CursorCliNew",
      "CursorCliSelect",
      "CursorCliResume",
    },
    keys = {
      {
        "<leader>ac",
        "<cmd>CursorCliToggle<cr>",
        desc = "Toggle Cursor CLI (right split)",
        mode = "n",
      },
      {
        "<leader>aC",
        "<cmd>CursorCliNew<cr>",
        desc = "New Cursor CLI chat",
        mode = "n",
      },
    },
    config = function()
      require("cursorcli").setup({
        position = "right",
        split_size = 0.35,
        command = { "cursor-agent" },
      })
    end,
  },
})

--------------------------
-- Color scheme settings -
--------------------------

-- term GUI colors
vim.opt.termguicolors = true

-- diagnostic display
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  float = { border = "rounded", source = "if_many" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.INFO]  = "",
      [vim.diagnostic.severity.HINT]  = "",
    },
  },
})

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

-- cursor line and column colors
vim.api.nvim_set_hl(0, "CursorLine", {
  underline = true,
  bg = "NONE",
})

vim.api.nvim_set_hl(0, "CursorColumn", {
  bg = "#313244",
})

vim.api.nvim_set_hl(0, "GitBlameVirtualText", {
  fg = "#363a4f",
  bg = "NONE",
  italic = true,
})

-- inlays
vim.api.nvim_set_hl(0, "LspInlayHint", {
  fg = "#6c7086",
  bg = "NONE",
  italic = true,
  underline = true,
})

-- highlight 80 and 120 columns
vim.opt.colorcolumn = { 80, unpack(vim.fn.range(120, 129)) }

-- add cursorline and cursorcolumn
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

--------------------
-- Editor settings -
--------------------

-- filetype plugin and indent
vim.cmd("filetype plugin indent on")

-- fast update time for CursorHold, etc.
vim.opt.updatetime = 50

-- tab and indent settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- directories for swap, undo, backup
vim.opt.backupdir = vim.fn.expand("~/tmp")
vim.opt.undodir = vim.fn.expand("~/tmp/un")
vim.opt.directory = vim.fn.expand("~/tmp/sw")
vim.opt.undofile = true

-- line numbers
vim.opt.relativenumber = true
vim.opt.number = true -- add absolute numbers too

-- backspace behavior
vim.opt.backspace = { "indent", "eol", "start" }

-- command-line completion menu
vim.opt.wildmenu = true

-- custom ctags
vim.opt.tags = ".tags;"

-- disable mouse
vim.opt.mouse = ""

-- visualize whitespace
vim.opt.listchars = {
  eol = "¬",
  tab = ">·",
  trail = "~",
  extends = ">",
  precedes = "<",
}
vim.opt.list = true

-- visual bell
vim.opt.visualbell = false

-- reopen file on same line as it was closed
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
require("plugin")
require("config.org")
require("config.notes").setup()

-- Defer config.go until a Go file is actually opened. require("config.go")
-- eagerly loads go.nvim, which on setup() runs `go install` for its tooling;
-- that errors out if `go` isn't on PATH in nvim's spawn environment.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gosum" },
  once = true,
  callback = function() require("config.go") end,
})

------------
-- Keymaps -
------------
require("keymaps")
