-- Telescope configuration
require("telescope").setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!**/.git/*",
      "--ignore-file", ".gitignore",
    },
    file_ignore_patterns = { ".git/", "node_modules/", "%.lock" },
    path_display = { "truncate" },
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
      },
    },
  },
})
