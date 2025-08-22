local go = require("go")

local function format_on_save(client, bufnr)
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
end

go.setup({
  lsp_inlay_hints = {
    enable = false,
  },
  lsp_cfg = {
    on_attach = format_on_save,
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
})

vim.api.nvim_create_user_command("GoInlayForceToggle", function()
  local current = vim.lsp.inlay_hint.is_enabled()

  if current then
    vim.lsp.inlay_hint.enable(false)
  else
    vim.lsp.inlay_hint.enable(true)
  end
end, {})
