local cairo = require("lgi").cairo
local mouse = mouse
local screen = screen
local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")

local surface = cairo.ImageSurface(cairo.Format.RGB24,20,20)
local cr = cairo.Context(surface)

local startview_box = wibox({ 
    width =  screen[mouse.screen].geometry.width, 
    height = screen[mouse.screen].geometry.height
})

local settings = {
    box_opacity = 0.6,
    box_bg = "#000000",
    starter_font = {"sans","italic","normal"},
    starter_font_size = 0.8,
    starter_font_color = "#ffffff"
}

local starterList = {{"test","testIcon"}}
startview_box.opacity = settings.box_opacity
startview_box.ontop = true
startview_box.visible = false
local widget_container = wibox.widget {
    forced_num_cols = 5,
    horizontal_homogeneous = true,
    expand = false,
    layout = wibox.layout.grid
}

local function toggle_startview() 

    startview_box.visible = not startview_box.visible
end

local function setup()
    for i = 1, #starterList do
        naughty.notify({
            text= i .. "in list"
        })
        starter_widget = wibox.widget.textclock()
        
        -- add widget to the main container
        widget_container:add(starter_widget)
    end

    startview_box:set_widget(widget_container)
end



return {
    toggle_startview = toggle_startview,
    setup = setup
}
