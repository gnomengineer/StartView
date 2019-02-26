local cairo = require("lgi").cairo
local awful = require("awful")
local mouse = mouse
local screen = screen
local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")
local filesystem = require("gears.filesystem")
local image_path = filesystem.get_configuration_dir() .. "startview/"

local surface = cairo.ImageSurface(cairo.Format.RGB24,20,20)
local cr = cairo.Context(surface)
--
local source = string.sub(debug.getinfo(1,'S').source, 2)
local path = string.sub(source, 1, string.find(source, "/[^/]*$"))
local noicon = path .. "testIcon.png"
local margin = 20
local starter_width = 150
local starter_height = 180
--]]
local settings = {
    box_opacity = 0.6,
    box_bg = "#444444",
    starter_font = {"sans","italic","normal"},
    starter_font_size = 0.8,
    starter_font_color = "#ffffff"
}

local function printDebugInfo(val)
    naughty.notify({
        text= val .. ""
    })
end


local starter_widgets = {}
local starterList = {
    {"evince","/usr/share/icons/hicolor/256x256/apps/evince.png"}
}
local layout = wibox.layout.fixed.horizontal()

for index=1,#starterList do
    starter_widget = wibox({
        width = starter_width,
        height = starter_height,
        bg = "#44444400",
        shape = gears.shape.rounded_rect,
        ontop = true,
        visible = false
    })
    local text = wibox.widget.textbox()
    text:set_text(starterList[index][1])
    text:set_valign("bottom")
    text:set_align("center")
    text:set_font("sans 14")

    local image = wibox.widget.imagebox()
    image:set_image(starterList[index][2])
    image:set_forced_height(150)
    image:set_forced_width(150)
    local container = wibox.container.margin(image, 10, 10)

    local layout_starter_widget = wibox.layout.fixed.vertical()
    layout_starter_widget:add(container)
    layout_starter_widget:add(text)
    starter_widget:set_widget(layout_starter_widget)

    starter_widget:buttons(
        awful.button({}, 1,
            function()
                awful.spawn(starterList[index][1])
            end
        )
    )

    starter_widgets[index] = starter_widget
end

local count,rest = math.modf(#starter_widgets / 5)
if rest > 0 then
    rest = 1
end

local startview_box_width =  (5*margin + starter_width) * 5 + 5*margin
local startview_box_height = (2*margin + starter_height) * (count + rest) + 2*margin

local startview_box = wibox({
    width = startview_box_width,
    height = startview_box_height,
    y = (screen[mouse.screen].geometry.height - startview_box_height) / 2,
    x = (screen[mouse.screen].geometry.width - startview_box_width) / 2,
    opacity = settings.box_opacity,
    shape = gears.shape.rounded_rect,
    bg = settings.box_bg,
    ontop = true,
    visible = false
})


local ycounter = 0
local xcounter = 1

for index=1, #starter_widgets do
    if (index-1) % 5 == 0 then
        ycounter = ycounter + 1
        xcounter = 1
    end

    starter_widgets[index].x = xcounter * (5 * margin) + (xcounter - 1) * starter_width + startview_box.x
    starter_widgets[index].y = ycounter * (2 * margin) + (ycounter - 1) * starter_height + startview_box.y
    xcounter = xcounter + 1
end
    
local function toggle_startview()
    startview_box.visible = not startview_box.visible
    for index = 1, #starter_widgets do
        starter_widgets[index].visible = not starter_widgets[index].visible
    end
end

return {
    toggle_startview = toggle_startview
}
