---@diagnostic disable: undefined-field, assign-type-mismatch, missing-parameter, param-type-mismatch

---@type Wezterm
local wezterm = require 'wezterm'

---Checks if the current pane is neovim
---@param pane Pane
---@return bool
local function is_vim(pane)
  -- this is set by the plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
  Left = 'h',
  Down = 'j',
  Up = 'k',
  Right = 'l',
  -- reverse lookup
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}
local M = {}

---Add keybindings for moving through and resizing panes
---@param resize_or_move string
---@param key string
---@return Key[]
M.split_nav = function(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'ALT' or 'CTRL',
    ---@param win Window
    ---@param pane Pane
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'ALT' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

return M
