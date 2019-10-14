-----------------------------------------------------------------------------------------
local widget = require( "widget" )


--Constantes de dimension de pantalla
local _W = display.contentWidth
local _H = display.contentHeight
x = display.actualContentHeight
y = display.actualContentWidth
--local rectangulo = display.newRect( _W/2, _H/2, 50, 50 )
--rectangulo.anchorX = 0
--rectangulo.anchorY = 0


--fondo por defecto para adicionar un nuevo evento 

local background = display.newRect(0,0,_W,_H)
background.anchorX=0
background.anchorY=0
background:setFillColor( 1 )

-- Function to handle button events
local function handleButtonEvent( event )
 
    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
    end
end

-- Create the widget 
local props = {
        label = "button",
        onEvent = handleButtonEvent,
        --emboss = false,
        shape = "roundedRect",
        cornerRadius = 10,
        fillColor = { default = {0,0,0,1}, over = {0,0,0,0.9}},
        strokeColor = { default = {0,1,0,1}, over = {0,1,0,1}},
        strokeWidth = 4,
        fontSize = 25,
        labelColor = { default = { 0, 1, 0 }, over = { 0, 1, 0} }
    }

button1 = widget.newButton( props )
 
button1.width = 50
button1.height = 50
-- Change the button's label text
button1:setLabel( "1" )
-- Center the button
button1.x = 30
button1.y = 30
