return {
  'mcauley-penney/visual-whitespace.nvim',
  cond = not vim.g.vscode,
  event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
  opts = {
    list_chars = {
      tab = "→"
    }
  }
}
