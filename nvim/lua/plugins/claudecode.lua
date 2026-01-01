return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      {
        "<C-,>",
        "<cmd>ClaudeCodeFocus<cr>",
        mode = { "n", "x" },
        desc = "Toggle Claude Code",
      },
    },
    opts = {
      focus_after_send = false,
      track_selection = true,

      terminal = {
        split_side = "right",
        split_width_percentage = 0.35,
        provider = "auto", -- "auto", "toggleterm", or "snacks"

        snacks_win_opts = {
          position = "float",
          width = 0.9,
          height = 0.9,
          keys = {
            claude_hide = {
              "<C-,>",
              function(self)
                self:hide()
              end,
              mode = "t",
              desc = "Hide Claude Code",
            },
          },
        },
      },

      log_level = "info", -- "trace", "debug", "info", "warn", "error"
    },
  },
}
