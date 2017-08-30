local cairo = require("lgi").cairo
local mouse = mouse
local screen = screen
local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")

local surface = cairo.ImageSurface(cairo.Format.RGB24,20,20)
local cr = cairo.Context(surface)
--
local source = string.sub(debug.getinfo(1,'S').source, 2)
local path = string.sub(source, 1, string.find(source, "/[^/]*$"))
local noicon = path .. "testIcon.png"
--]]
local startview_box = wibox({ 
    width =  screen[mouse.screen].geometry.width, 
    height = screen[mouse.screen].geometry.height
})

local settings = {
    box_opacity = 0.6,
    box_bg = "#ff0000",
    starter_font = {"sans","italic","normal"},
    starter_font_size = 0.8,
    starter_font_color = "#ffffff"
}

local starter_widgets = {}
local starterList = {{"test","testIcon"}}
startview_box.opacity = settings.box_opacity
startview_box.bg = settings.box_bg 
startview_box.ontop = true
startview_box.visible = false

local function debug(val) 
    naughty.notify({
        text= val .. ""
    })
end

local function toggle_startview() 
    for i = 1, #starter_widgets do
        starter_widgets[i].draw(starter_widget, startview_box, cr, 200,200)
    end
    startview_box.visible = not startview_box.visible
end

local function setup()

    --cr:set_source(gears.color("#ffffff"))
    for i = 1, 15 do

        starter_widgets[i] = wibox.widget.base.make_widget()

        starter_widgets[i].fit = function(starter_widget, width, height)
            return 0, 0
        end

        starter_widgets[i].draw = function(starter_widget, startview_box, cr, width, height) 
            icon = gears.surface(gears.surface.load(noicon))
            cr:set_source_surface(icon,0,0)
            cr:paint()
            --]]
            cr:scale(10,10)
            cr:set_source_rgba(unpack(settings.starter_font_color))
            cr:move_to(2,2)
            cr:show_text("test")
            cr:stroke() 
        end
           
    end

    local widget_container = wibox.widget {
        forced_num_cols = 5,
        horizontal_homogeneous = true,
        spacing = 20,
        expand = false,
        layout = wibox.layout.grid
    }

    for i = 1, 15 do
        widget_container:add(starter_widgets[i])
    end

    startview_box:set_widget(widget_container)
end

return {
    toggle_startview = toggle_startview,
    setup = setup
}
