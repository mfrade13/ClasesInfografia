-----------------------------------------------------------------------------------------
--
-- 
-- importar paquetes	
local character = require('character')



-- Constantes de dimension de pantalla
local _W = display.contentWidth
local _H = display.contentHeight



local params = {
	name= "magina",
	x = _W/2,
	y = _H/2 
}

--fondo por defecto para adicionar un evento
local background = display.newRect(0,0,_W,_H)
background.anchorX=0
background.anchorY=0
background:setFillColor( 0.44 )

--iniciacion de personaje
local magina = character.new_character(params)

--funcino touch para el objeto background
function background:touch( event )
	if event.phase == "began" then

	elseif event.phase == "moved" then

	elseif event.phase == "cancelled" or event.phase == "ended" then
		print( 'Blinking object' )
		magina:blink(event)
	end
	return true
end

--adicionar evento touch a un objeto
background:addEventListener( "touch", background )
