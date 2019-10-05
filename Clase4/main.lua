-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local _W = display.contentWidth
local _H = display.contentHeight

	
local character = require('character')


local params = {
	name= "magina",
	x = _W/2,
	y = _H/2 
}

local background = display.newRect(0,0,_W,_H)
background.anchorX=0
background.anchorY=0
background:setFillColor( 0.44 )

local magina = character.new_character(params)


function background:touch( event )
	print( event )
	magina:blink(event)
end


background:addEventListener( "touch", background )
