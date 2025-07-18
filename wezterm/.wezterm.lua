-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
-- This will hold the configuration.
local config = wezterm.config_builder()
-- WSL domain setup
config.wsl_domains = wezterm.default_wsl_domains()
config.default_domain = "WSL:Ubuntu"

-- Appearance & fonts
config.front_end = "OpenGL"
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color" -- Set the terminal type
config.font = wezterm.font("CommitMono Nerd Font")
config.cell_width = 0.9
-- Window appearance
config.window_background_opacity = 0.75
config.prefer_egl = true
config.font_size = 11
config.window_padding = {
  left   = 1,
  right  = 1,
  top    = 1,
  bottom = 1,
}

-- Scrolling & mouse
config.scrollback_lines      = 1000

-- tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
-- config.tab_bar_at_bottom = true

-- config.inactive_pane_hsb = {
-- 	saturation = 0.0,
-- 	brightness = 1.0,
-- }


-- Keybindings (with Ctrl+Shift modifiers)
config.keys = {
  -- split panes in WSL
  { key = 'Enter', mods = 'CTRL|SHIFT', action = act.SplitVertical   { domain = 'CurrentPaneDomain' } },
  { key = 'Space', mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  -- pane navigation
  { key = '[', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Left'  },
  { key = ']', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Right' },
  -- close pane
  { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentPane   { confirm = false } },
  -- new tab in WSL
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab           "CurrentPaneDomain" },
}

config.window_frame = {
	font = wezterm.font({ family = "Iosevka Custom", weight = "Regular" }),
	active_titlebar_bg = "#0c0b0f",
	-- active_titlebar_bg = "#181616",
}

config.window_decorations = "NONE | RESIZE"
config.initial_cols = 80
-- config.window_background_image = "C:/dev/misc/berk.png"
-- config.window_background_image_hsb = {
-- 	brightness = 0.1,
-- }

-- On launch: size to half screen width, full height, then split right 50%
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():set_inner_size(1722, 1440)
end)

return config