--robbinsr

theme = {}

theme.font          = "sans 8"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

theme.awesome_icon = "/home/robbinsr/.config/awesome/theme/awesome-icon.png"
theme.taglist_squares_unsel = "/home/robbinsr/.config/awesome/theme/taglist/squarew.png"
theme.taglist_squares_sel   = "/home/robbinsr/.config/awesome/theme/taglist/squarefw.png"

theme.wallpaper_cmd = {"feh --bg-scale /home/robbinsr/.config/awesome/theme/background.png"}

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/robbinsr/.config/awesome/theme/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

return theme
