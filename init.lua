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
startview_box.ontop = true
startview_box.visible = false
local widget_container = wibox.widget {
    forced_num_cols = 5,
    horizontal_homogeneous = true,
    expand = false,
    layout = wibox.layout.grid
}

local function toggle_startview() 
    for i = 1, #starterList do
        starter_widget = wibox.widget.base.make_widget()
        
        starter_widget.draw = function(starter_widget, startview_box, cr, width, height)
            --Icon
            local icon = gears.surface(gears.surface.load(starterList[i].icon))

            local tx, ty, sx, sy = 2,2,0.5,0.5
            cr:translate(tx,ty)
            cr:scale(sx,sy)
            cr:set_source_surface(icon, 0, 0)
            cr:paint()
            cr:scale(1/sx,1/sy)
            cr:translate(-tx,-ty)

            --Titles
            cr:select_font_face(unpack(settings.starter_font))
            cr:set_font_face(cr:get_font_face())
            cr:set_font_size(settings.starter_font_size)

            text = starterList[i].text
            text_width = cr:text_extents(text).width
            text_height = cr:text_extents(text).height

            cr:move_to(0,12)
            cr:show_text(text)
            cr:stroke()
        end
        
        -- add widget to the main container
        widget_container:add(starter_widget)
    end

    startview_box:set_widget(widget_container)
   startview_box.visible = not startview_box.visible
end

local function setup()
    naughty.notify({
        preset = naughty.config.presets.normal,
        text = os.date("%H:%M \n %a, %d. %b %Y"),
        position = "top_middle",
    })
 
    for i = 1, #starterList do
        starter_widget = wibox.widget.base.make_widget()
        
        starter_widget.draw = function(starter_widget, startview_box, cr, width, height)
            --Icon
            local icon = gears.surface(gears.surface.load(starterList[i].icon))

            local tx, ty, sx, sy = 2,2,0.5,0.5
            cr:translate(tx,ty)
            cr:scale(sx,sy)
            cr:set_source_surface(icon, 0, 0)
            cr:paint()
            cr:scale(1/sx,1/sy)
            cr:translate(-tx,-ty)

            --Titles
            cr:select_font_face(unpack(settings.starter_font))
            cr:set_font_face(cr:get_font_face())
            cr:set_font_size(settings.starter_font_size)

            text = starterList[i].text
            text_width = cr:text_extents(text).width
            text_height = cr:text_extents(text).height

            cr:move_to(0,12)
            cr:show_text(text)
            cr:stroke()
        end
        
        -- add widget to the main container
        widget_container:add(starter_widget)
    end

    startview_box:set_widget(widget_container)
end



return {
    toggle_startview = toggle_startview,
    setup = setup
}
