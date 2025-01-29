---@diagnostic disable: undefined-field, assign-type-mismatch, missing-parameter, param-type-mismatch

---@type Wezterm
local wezterm = require 'wezterm'
local act = wezterm.action

local split_nav = require('pane-managment').split_nav
local sessionizer = require 'sessionizer'

---@return Key[]
return {
  {
    key = 'LeftArrow',
    mods = 'SHIFT',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = 'RightArrow',
    mods = 'SHIFT',
    action = act.ActivateTabRelative(1),
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = act.CloseCurrentTab { confirm = true },
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for session',
      action = wezterm.action_callback(function(window, _, line)
        if line then
          wezterm.mux.rename_workspace(window:mux_window():get_workspace(), line)
        end
      end),
    },
  },
  {
    key = '|',
    mods = 'LEADER|SHIFT',
    action = act.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
  {
    mods = 'LEADER',
    key = 'x',
    action = act.CloseCurrentPane { confirm = true },
  },
  {
    mods = 'LEADER',
    key = 'z',
    action = act.TogglePaneZoomState,
  },
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',

      ---@param win Window
      ---@param _ Pane
      ---@param line string?
      action = wezterm.action_callback(function(win, _, line)
        if line then
          win:active_tab():set_title(line)
        end
      end),
    },
  },
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action_callback(sessionizer.toggle),
  },
  { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },

  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),
  -- resize panes
  split_nav('resize', 'h'),
  split_nav('resize', 'j'),
  split_nav('resize', 'k'),
  split_nav('resize', 'l'),
}
