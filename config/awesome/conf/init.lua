local beautiful = require "beautiful"
local gfs = require "gears.filesystem"
local awful = require "awful"

beautiful.init(gfs.get_configuration_dir() .. "themes/theme.lua")

require "conf.layout"
require "conf.keybind"
require "conf.rules"
require "conf.client"

terminal = "kitty"
browser = "firefox"
fileManager = "thunar"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

local startup_script = [[
picom --config $HOME/.config/picom/picom.conf --experimental-backends
]]

awful.spawn.with_shell(
	startup_script
)
-- awful.spawn.with_shell(
-- 	"xrandr --output DisplayPort-1 --auto --output eDP --off --right-of DisplayPort-1"
-- )
awful.spawn.with_shell(
	"xrandr --setmonitor DisplayPort auto DisplayPort-1,eDP; xrandr --output DisplayPort-1 --auto --output eDP --auto --right-of DisplayPort-1"
)
