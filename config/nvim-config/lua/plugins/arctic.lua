return {
  "rockyzhang24/arctic.nvim",
  cond = not vim.g.vscode, -- Not needed in VS Code context
  branch = "v2",
  name = "arctic",
  dependencies = { "rktjmp/lush.nvim" },
  priority = 1000,
  lazy = false,
  config = function()
    local function apply_colorscheme()
      if vim.o.termguicolors then
        vim.cmd.colorscheme("arctic")
      else
        vim.cmd.colorscheme("habamax")
      end
      for _, group in ipairs({
        "Normal",
        "NormalNC",
        "NormalFloat",
        "SignColumn",
        "EndOfBuffer",
      }) do
        vim.api.nvim_set_hl(0, group, { bg = "#000000" })
      end
      vim.cmd.RainbowToggleOn() -- colorscheme changes reset Rainbow
    end

    if vim.v.vim_did_enter == 1 then
      apply_colorscheme()
    else
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = apply_colorscheme,
      })
    end
  end,
}
