---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir() .. "themes/"
local theme = {}

----- User -----

-- theme.pfp = themes_path .. "pfp.png"
-- theme.user = "Neko"
-- theme.hostname = "@Neptune"

----- Font -----

theme.font = "iosevka bold 14"
theme.font_name = "iosevka"
theme.font_size = "bold 14"

----- General/default Settings -----

theme.bg_normal     = "#1e1e2e"
theme.bg_focus      = "#6c7086"
theme.bg_urgent     = "#eba0ac"
theme.bg_minimize   = "#313244"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#cdd6f4"
theme.fg_focus      = "#737994"
theme.fg_urgent     = "#ea999c"
theme.fg_minimize   = "#99d1db"

theme.useless_gap   = dpi(10)
theme.border_width  = dpi(1)
theme.border_normal = "#303446"
theme.border_focus  = "#babbf1"
theme.border_marked = "#A54242"

----- Menu -----
theme.wallpaper = themes_path .. "wallpaper.png"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

--Signals
client.connect_signal("focus", function(c)
    c.border_color = theme.border_focus end)
client.connect_signal("unfocus", function(c)
    c.border_color = theme.border_normal end)

-- Icon theme
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
