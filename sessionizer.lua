---@diagnostic disable: undefined-field, assign-type-mismatch

---@type Wezterm
local wezterm = require 'wezterm'

local sessionizer = wezterm.plugin.require 'https://github.com/mikkasendke/sessionizer.wezterm'

sessionizer.config = {
  command = {
    -- this is populated based on command_options it (Note that if you set this command_options will be ignored)
    -- effectively looks like the following
    'fd',
    '.',
    '-Hs',
    '^.git$',
    '-td',
    '--max-depth=1',
    '--prune',
    -- command_options.format,
    -- Here any number of excludes for example
    '-E node_modules',
    -- -E another_directory_to_exclude
  },
  paths = {
    '/home/bozzkoo/Documents/uni',
    '/home/bozzkoo/Documents/personal',
    '/home/bozzkoo/.config',
    'D:\\K-IMS.GangwayForecast.Worker',
    'D:\\K-IMS.GangwayForecast',
    'D:\\K-IMS.DPOperationalForecast',
    'D:\\DPOperationalForecastWorker',
    'D:\\',
    'C:\\Users\\BozhidarVidenov\\.config',
    'C:\\Users\\BozhidarVidenov\\AppData\\Local',
  },
}

return sessionizer
