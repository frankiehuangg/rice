--[[
 ______     __     __     ______     ______     ______     __    __     ______     __     __     __    __    
/\  __ \   /\ \  _ \ \   /\  ___\   /\  ___\   /\  __ \   /\ "-./  \   /\  ___\   /\ \  _ \ \   /\ "-./  \   
\ \  __ \  \ \ \/ ".\ \  \ \  __\   \ \___  \  \ \ \/\ \  \ \ \-./\ \  \ \  __\   \ \ \/ ".\ \  \ \ \-./\ \  
 \ \_\ \_\  \ \__/".~\_\  \ \_____\  \/\_____\  \ \_____\  \ \_\ \ \_\  \ \_____\  \ \__/".~\_\  \ \_\ \ \_\ 
  \/_/\/_/   \/_/   \/_/   \/_____/   \/_____/   \/_____/   \/_/  \/_/   \/_____/   \/_/   \/_/   \/_/  \/_/ 
                                                                                                             
  --]]

pcall(require, "luarocks.loader")

local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"

require "main.error_handling"

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

-- init config
require "main.wallpaper"
require "main.layout"
require "main.rules"
require "main.bindings.bindings"
require "main.bindings.custom_bindings"
require "main.tags"
require "main.menu"

require "awful.autofocus"

-- init widget
require "misc"
require "signals"

-- Autorun at startup
awful.spawn.with_shell("bash ~/.config/awesome/main/autorun.sh")

local get_monitors = [[ xrandr | grep "DP-2 disconnected" ]]
awful.spawn.easy_async_with_shell(get_monitors, function(stdout)
    if stdout == nil then
        awful.spawn.with_shell("xrandr --output DP-2 --primary --left-of eDP-1")
    else
        awful.spawn.with_shell("xrandr --output DP-2 --off --output eDP-1 --primary")
    end 
end)
