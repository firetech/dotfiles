-- load .vimrc and vim plugins
vim.cmd.source(vim.fn.expand('~/.vimrc'))
vim.cmd.packloadall()

-- fix Yaifa loading too late for BufReadPost to trigger on initial file
vim.cmd.Yaifa()

-- load lazy.nvim
require("config.lazy")

-- copied from https://github.com/Wansmer/nvim-config/blob/977a97c/lua/modules/key_listener.lua
---------8<---------8<---------8<---------8<---------8<---------
local listener_ls = vim.api.nvim_create_namespace("key_listener")

---Deleting hlsearch when it already no needed
local function toggle_hlsearch(char)
  local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
  local new_hlsearch = vim.tbl_contains(keys, char) and 1 or 0

  if vim.api.nvim_get_vvar("hlsearch") ~= new_hlsearch then
    vim.api.nvim_set_vvar("hlsearch", new_hlsearch)
  end
end

---Handler for pressing keys. Added listeners for modes
---@param char string
local function key_listener(char)
  local key = vim.fn.keytrans(char)
  local mode = vim.fn.mode()
  if mode == "n" then
    toggle_hlsearch(key)
  end
end

vim.on_key(key_listener, listener_ls)
---------8<---------8<---------8<---------8<---------8<---------

-- add g<Tab> keybinding for VS Code
-- (the implementation in .vimrc doesn't work in VS Code)
if vim.g.vscode then
  vim.keymap.set("n", "g<Tab>", function()
    require("vscode").call("runCommands", {
      args = {
        commands = {
          "workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup",
          "workbench.action.acceptSelectedQuickOpenItem",
        }
      }
    })
  end, { desc = "Previous recently used editor" })
end
