---@diagnostic disable: undefined-field, assign-type-mismatch

---@type Wezterm
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.color_scheme = 'nord'
-- local kanagawa = require 'themes.kanagawa'
--
-- config.colors = kanagawa.colors

config.font = wezterm.font_with_fallback {
  'CommitMono',
  'Hack',
  'Symbols Nerd Font',
  'Font Awesome 6 Free',
  'Font Awesome 6 Brands',
  'Material Icons',
}
config.font_size = 12
config.max_fps = 144
config.animation_fps = 144
config.freetype_load_target = 'HorizontalLcd'

-- config.window_background_opacity = 0.7
config.window_background_opacity = 1

if wezterm.target_triple == 'x86_64-pc-windows-msvc' or wezterm.target_triple == 'x86_64-pc-windows-gnu' then
  config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }
end
config.leader = { key = 'a', mods = 'ALT', timeout_milliseconds = 3000 }

wezterm.on('update-status', function(window, _)
  local status_generator = require 'wez-status-generator.plugin'
  local status = status_generator.generate_left_status {
    sections = {
      {
        components = {
          function()
            return window:mux_window():get_workspace()
          end,
        },
        foreground = window:leader_is_active() and '#0D0C0C' or '#C5C9C5',
        background = window:leader_is_active() and '#7FB4CA' or '#181616',
      },
    },
    separator = '',
    hide_empty_sections = true,
  }

  window:set_left_status(status)
end)

local keybindings = require 'keybindings'

config.keys = keybindings

config.default_mux_server_domain = 'local'
config.default_domain = 'local'
config.scrollback_lines = 3500

return config
