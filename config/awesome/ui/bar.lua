local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

----- Bar -----

awful.screen.connect_for_each_screen(function(s)
	-- Tag table
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

    -- Wibox canvas
    s.bar = awful.wibar { 
		position = "top", 
		screen = s,
		width = dpi(330),
		height = dpi(60),
		margins = { top = dpi(20) },
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
		bg = beautiful.bar,
	}

	s.bar.x = dpi(20+(s.index-1)*1920)

	s.bar:struts { top = dpi(90), left = dpi(20), right = dpi(20)}

	-- Taglist
	local btn_tag = awful.button( { }, 1, function(t) t:view_only() end)

	local taglist = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			spacing = dpi(20),
			layout = wibox.layout.fixed.horizontal,
		},
		buttons = btn_tag,
		widget_template = {
			{
				{
					id = 'text_role',
					widget = wibox.widget.textbox,
				},
				margins = dpi(0),
				widget = wibox.container.margin,
			},
			widget = wibox.container.background,
		}
	}

	-- Clock
	local time = wibox.widget.textbox()

	gears.timer {
		timeout = 60,
		call_now = true,
		autostart = true,
		callback = function()
			tmp = os.date("%I:%M %p")
			time.markup = "󱑂 " .. tmp
		end
	}

	local bar_widget = wibox.widget {
		{ 
			{
				taglist,
				time,
				spacing = dpi(40),
				layout = wibox.layout.fixed.horizontal,
			},
			margins = {top = dpi(10), bottom = dpi(10), left = dpi(20), right = dpi(20)},
			widget = wibox.container.margin, 
		},
		bg = beautiful.bar,
		widget = wibox.container.background,
	}

	s.bar : setup {
		nil,
		{
			bar_widget,
			nil,
			nil,
			layout = wibox.layout.align.horizontal,
		},
		expand = 'none',
		layout = wibox.layout.align.horizontal,
	}

end)
