return {
  "firetech/sudo.nvim",
  cond = not vim.g.vscode, -- Not needed in VS Code context
  cmd = { "SudoRead", "SudoWrite", "SudoEdit" },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    -- optional configuration
    -- commands = true,
  },
}
