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
local margin = 20
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

local startview_box = wibox({
    width =  screen[mouse.screen].geometry.width - 2*margin,
    height = screen[mouse.screen].geometry.height - 2*margin,
    x = margin,
    y = margin,
    opacity = settings.box_opacity,
    shape = gears.shape.rounded_rect,
    bg = settings.box_bg,
    ontop = true,
    visible = false
})

local starter_widgets = {}
local starterList = {{"test","testIcon"}}
local layout = wibox.layout.fixed.horizontal()

for counter=0,15 do
    starter_widget = wibox({
        width = startview_box.width / 4 - 1.25 * margin,
        height = startview_box.height / 4 - 1.25 * margin,
        bg = "#ff00ff",
        shape = gears.shape.rounded_rect,
        ontop = true,
        visible = false
    })
    local text = wibox.widget.textbox()
    text:set_text("Test")
    local image = wibox.widget.imagebox()
    image:set_image("test.png")
    local layout_starter_widget = wibox.layout.fixed.vertical()
    layout_starter_widget:add(text)
    layout_starter_widget:add(image)
    starter_widget:set_widget(layout_starter_widget)
    starter_widgets[counter] = starter_widget
end

local ycounter = 0
local xcounter = 1

for counter=0, #starter_widgets do
    if counter % 4 == 0 then
        ycounter = ycounter + 1
        xcounter = 1
    end

    starter_widgets[counter].x = xcounter * margin + (xcounter - 1) * starter_widgets[counter].width + margin
    starter_widgets[counter].y = ycounter * margin + (ycounter - 1) * starter_widgets[counter].height + margin
    xcounter = xcounter + 1
end

local function toggle_startview()
    startview_box.visible = not startview_box.visible
    for counter = 0, #starter_widgets do
        starter_widgets[counter].visible = not starter_widgets[counter].visible
    end
end

return {
    toggle_startview = toggle_startview
}
