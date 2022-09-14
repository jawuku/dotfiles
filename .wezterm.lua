local wezterm = require("wezterm")

return {
  font = wezterm.font {
    family = "FiraCode Nerd Font",
    -- harfbuzz_features = {"ss02", "ss03", "ss05", "cv16"},
  },
  
  enable_scroll_bar = false,
    
  color_scheme = "Doom Peacock",
  
  scrollback_lines = 8192,
  
  font_size = 14,
    
  enable_tab_bar = true,
    
  hide_tab_bar_if_only_one_tab = true,
    
  automatically_reload_config = true,
    
  default_cursor_style = "BlinkingBar",
  
  initial_cols = 80,
  
  initial_rows = 25,
}
