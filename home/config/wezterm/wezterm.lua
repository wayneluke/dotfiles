-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 16

config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.show_tab_index_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

config.window_decorations = 'RESIZE'

config.window_background_opacity = 0.8
config.macos_window_background_blur = 10
config.window_close_confirmation = 'NeverPrompt'

config.color_scheme = 'nordfox'

-- and finally, return the configuration to wezterm
return config