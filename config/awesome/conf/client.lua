local gears = require "gears"

--- Rounded Border/s
client.connect_signal("manage", function(c)
	c.shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end
end)