local cairo = require("lgi").cairo
local mouse = mouse
local screen = screen
local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")


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

local starterList = {{"test","testIcon"}}
startview_box.opacity = settings.box_opacity
startview_box.bg = settings.box_bg 
startview_box.ontop = true
startview_box.visible = false
local widget_container = wibox.widget {
    forced_num_cols = 5,
    horizontal_homogeneous = true,
    spacing = 5,
    expand = false,
    layout = wibox.layout.grid
}

local function debug(val) 
    naughty.notify({
        text= val .. ""
    })
end

local function toggle_startview() 
    startview_box.visible = not startview_box.visible
end

local function setup()

    surface = cairo.ImageSurface(cairo.Format.RGB24,100,100)
    cr = cairo.Context(surface)
    for i = 1, 3 do
        --cr:set_source_surface(gears.surface.load("~/pictures/VennPurpose.VennPurpose.jpg"),0,0)
        --cr:show_text("test")
        cr:set_source(gears.color("#ffffff"))
        cr:move_to(2,2)
        cr:show_text("test")
        cr:stroke()
        --cr:paint()
            
        starter_widget = wibox.widget.imagebox(surface,false)
        --starter_widget.forced_height =100
        --starter_widget.forced_width = 100
        -- add widget to the main container
        widget_container:add(starter_widget)
    end

    startview_box:set_widget(widget_container)
end

return {
    toggle_startview = toggle_startview,
    setup = setup
}
