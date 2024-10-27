return {
  force_reverse_video_cursor = true,
  colors = {
    foreground = '#C5C9C5',
    background = '#181616',

    cursor_bg = '#C8C093',
    cursor_fg = '#C8C093',
    cursor_border = '#C8C093',

    selection_fg = '#C8C093',
    selection_bg = '#2D4F67',

    scrollbar_thumb = '#16161D',
    split = '#16161D',

    ansi = { '#0D0C0C', '#C4746E', '#8A9A7B', '#C4B28A', '#8BA4B0', '#A292A3', '#8EA4A2', '#C8C093' },
    brights = { '#A6A69C', '#E46876', '#87A987', '#E6C384', '#7FB4CA', '#938AA9', '#7AA89F', '#C5C9C5' },
    indexed = { [16] = '#FFA066', [17] = '#FF5D62' },

    compose_cursor = '#C8C093',

    -- Colors for copy_mode and quick_select
    -- available since: 20220807-113146-c2fee766
    -- In copy_mode, the color of the active text is:
    -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
    -- 2. selection_* otherwise
    copy_mode_active_highlight_bg = { Color = '#000000' },
    -- use `AnsiColor` to specify one of the ansi color palette values
    -- (index 0-15) using one of the names "Black", "Maroon", "Green",
    --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
    -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
    copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
    copy_mode_inactive_highlight_bg = { Color = '#87A987' },
    copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

    quick_select_label_bg = { Color = '#FFA066' },
    quick_select_label_fg = { Color = '#C5C9C5' },
    quick_select_match_bg = { AnsiColor = 'Navy' },
    quick_select_match_fg = { Color = '#C5C9C5' },
    visual_bell = '#FF5D62',

    tab_bar = {
      --
      background = '#181616',

      active_tab = {
        bg_color = '#393836',
        fg_color = '#C5C9C5',
      },

      inactive_tab = {
        bg_color = '#181616',
        fg_color = '#C5C9C5',
      },

      inactive_tab_hover = {
        bg_color = '#9fb5c9',
        fg_color = '#43436c',
        italic = true,
      },

      new_tab = {
        bg_color = '#181616',
        fg_color = '#181616',
      },

      new_tab_hover = {
        bg_color = '#181616',
        fg_color = '#181616',
        italic = true,
      },
    },
  },
}
