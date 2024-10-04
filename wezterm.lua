---@diagnostic disable: undefined-field, assign-type-mismatch

---@type Wezterm
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.color_scheme = 'tokyonight_night'
config.font = wezterm.font_with_fallback {
  'CommitMono',
  'Symbols Nerd Font',
}
config.font_size = 11
config.max_fps = 140
config.scrollback_lines = 3500

if wezterm.target_triple == 'x86_64-pc-windows-msvc' or wezterm.target_triple == 'x86_64-pc-windows-gnu' then
  config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }
end
config.leader = { key = 'a', mods = 'ALT', timeout_milliseconds = 1000 }

local bar_config = require 'bar-config'

bar_config.bar.apply_to_config(config, bar_config.config)

local keybindings = require 'keybindings'

config.keys = keybindings

config.unix_domains = {
  {
    name = 'unix',
  },
}

config.default_gui_startup_args = { 'connect', 'unix' }

return config
