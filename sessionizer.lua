---@type Wezterm
---@diagnostic disable-next-line: assign-type-mismatch
local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

M.toggle = function(window, pane)
  local projects = {}

  local success, stdout, stderr = wezterm.run_child_process {
    'fd',
    '--min-depth',
    '1',
    '--max-depth',
    '3',
    '--type',
    'd',
    '.',
    'D:\\',
    'C:\\Users\\BozhidarVidenov\\AppData',
    'C:\\Users\\BozhidarVidenov\\.config',
    '/home/bozzkoo/.config/',
    '/home/bozzkoo/dotfiles/.config/',
    '/home/bozzkoo/Documents/personal/',
    '/home/bozzkoo/Documents/work/',
    '/home/bozzkoo/Documents/uni/',
  }

  if not success then
    wezterm.log_error('Failed to run fd: ' .. stderr)
    return
  end

  for line in stdout:gmatch '([^\n]+)' do
    local project = line:gsub('/.git.*$', '')
    local label = project:sub(1, -2)
    wezterm.log_info(label)
    local id = label:gsub('.*\\', '')
    wezterm.log_info(id)
    table.insert(projects, { label = tostring(label), id = tostring(id) })
  end

  window:perform_action(
    act.InputSelector {
      action = wezterm.action_callback(function(win, _, id, label)
        if not id and not label then
          wezterm.log_info 'Cancelled'
        else
          wezterm.log_info('Selected ' .. label)
          win:perform_action(act.SwitchToWorkspace { name = id, spawn = { cwd = label } }, pane)
        end
      end),
      fuzzy = true,
      title = 'Select project',
      choices = projects,
    },
    pane
  )
end

return M
