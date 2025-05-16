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

require("lspconfig").gopls.setup({
  on_attach = function(client, bufnr)
    -- Format + organize imports on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
        vim.lsp.buf.code_action({
          context = { only = { "source.organizeImports" } },
          apply = true,
        })
      end,
    })
  end,
})
