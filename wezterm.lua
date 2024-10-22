---@diagnostic disable: undefined-field, assign-type-mismatch

---@type Wezterm
local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on('gui-startup', function()
  ---@type MuxTabObj, Pane, MuxWindow
  local _, _, window = mux.spawn_window {}
  window:gui_window():maximize()
end)

local config = wezterm.config_builder()

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.color_scheme = 'tokyonight_night'
config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Symbols Nerd Font',
  'Font Awesome 6 Free',
  'Font Awesome 6 Brands',
  'Material Icons',
}
config.font_size = 11
config.max_fps = 144
config.window_background_opacity = 1

if wezterm.target_triple == 'x86_64-pc-windows-msvc' or wezterm.target_triple == 'x86_64-pc-windows-gnu' then
  config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }
end
config.leader = { key = 'a', mods = 'ALT', timeout_milliseconds = 3000 }

local bar_config = require 'bar-config'

bar_config.bar.apply_to_config(config, bar_config.config)

local sessionizer = require 'sessionizer'
sessionizer.apply_to_config(config)

local keybindings = require 'keybindings'

config.keys = keybindings

config.default_mux_server_domain = 'local'
config.default_domain = 'local'
config.scrollback_lines = 3500

return config
