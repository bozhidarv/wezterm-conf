---@type Wezterm
---@diagnostic disable-next-line: assign-type-mismatch
local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

M.toggle = function(window, pane)
  local projects = {}

  --- D:\\',
  -- 'C:\\Users\\BozhidarVidenov\\AppData',
  -- 'C:\\Users\\BozhidarVidenov\\.config',

  ---@type string[]
  local program = {
    'sh',
    '-c',
    wezterm.config_dir .. '/scripts/sessionizer.sh',
  }

  if wezterm.target_triple == 'x86_64-pc-windows-msvc' or wezterm.target_triple == 'x86_64-pc-windows-gnu' then
    program = {}
  end

  local success, stdout, stderr = wezterm.run_child_process(program)

  if not success then
    wezterm.log_error('Failed to run fd: ' .. stderr)
    wezterm.log_error(wezterm.config_dir)
    return
  end

  for line in stdout:gmatch '([^\n]+)' do
    local project = line:gsub('/.git.*$', '')
    local label = project:sub(1, -2)
    wezterm.log_info(label)

    local id = ''
    if wezterm.target_triple == 'x86_64-pc-windows-msvc' or wezterm.target_triple == 'x86_64-pc-windows-gnu' then
      id = label:gsub('.*\\', '')
    else
      id = label:gsub('.*/', '')
    end
    table.insert(projects, { label = tostring(label), id = tostring(id) })
  end

  window:perform_action(
    act.InputSelector {
      ---@diagnostic disable-next-line: param-type-mismatch, missing-parameter
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
