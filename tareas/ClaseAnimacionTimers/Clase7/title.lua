------------------------------newScene-----------------------------------------------------------
--
-- title.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require('widget')
--------------------------------------------
local angulo = 0
-- forward declaration
local background,rect, pageText, myTimer, sequence
local _W = display.contentWidth
local _H = display.contentHeight

local mySpriteSheet, spriteDisplay

local tiempoTexto = 60

local batGroup = {}
local bat1,bat2, batTimer
-- Touch listener function for background object
local function onBackgroundTouch( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		-- go to page1.lua scene
		composer.gotoScene( "page1", "slideLeft", 800 )
		
		return true	-- indicates successful touch
	end
end

function moverEnY(  )
	transition.to( rect, {y = math.random(0, _H), time=5000 } )
	rect:setFillColor( math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255   )
end

function cambiarPagina( )
	composer.gotoScene( "page1", "slideLeft", 800 )
end

function animar ()

	local function changeframe1()
		bat1.isVisible ,bat2.isVisible = true,false
		transition.to( batGroup, {time=200, onComplete =changeframe2 } )
	end 

	local function changeframe2()
		bat1.isVisible ,bat2.isVisible = false, true
	end 
	changeframe2()
	transition.to( batGroup, {time = 200, onComplete = changeframe1} )

end


function descontar( event )
	
	tiempoTexto = tiempoTexto -1
	pageText.text = "" .. tiempoTexto
end

function detenerCronometro()
	local puase = timer.pause( myTimer )
	spriteDisplay:setSequence( "quieto" )
	spriteDisplay:play()
	print( puase)
end

function resumirCronometro()
	print("boton oprimido")
	timer.resume( myTimer )
end


function mostrar(event)

	local function mostrar2 ()
		bat2.isVisible = false
		bat1.isVisible = true
	end

	local function mostrar1 ()
		bat2.isVisible = true
		bat1.isVisible = false
		transition.to( batGroup, {time=200, onComplete=mostrar2 } )
	end

	transition.to( batGroup, {time = 200, onComplete= mostrar1 } )

end



function scene:create( event )
	local sceneGroup = self.view
	batGroup = display.newGroup()
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	background = display.newImageRect( sceneGroup, "space.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0

	-- background.touch = onBackgroundTouch
	-- background:addEventListener( "touch", background )
	pageText = display.newText( ""..tiempoTexto, 0, 0, native.systemFont, 62 )
	pageText.x = display.contentWidth * 0.5
	pageText.y = (display.contentHeight*0.2)	
	pageText:setFillColor( 0,0,1 )

	local myButton = widget.newButton{
		id = 'myButton',
		x = _W/2,
		y = _H/2,
		onRelease = resumirCronometro,	
		defaultFile="button.png",
		overFile="button-over.png",
		width = 100,
		height = 100,
		label = 'PLAY!',
		fontSize = 50,
		labelColor = {default = {1,0,0}, over = {0,1,0}   }
		}
		myButton.x = 100


	bat1 = display.newImageRect( batGroup, "murcielago0.png", 256, 156)
	bat2 = display.newImageRect( batGroup, "murcielago1.png", 256, 156)


	sceneGroup:insert( background )
	sceneGroup:insert( pageText )
	sceneGroup:insert( myButton)
	sceneGroup:insert( batGroup )
	local options = {
		width = 300,
		height = 300,
		numFrames = 8
	}
	mySpriteSheet = graphics.newImageSheet("avanzaD.png", options )
	sequence={

          {name="rigth",sheet=mySpriteSheet, frames={1,2,3,4,5,6,7,8}, time=750,  loopCount = 100},
          {name = "quieto", sheet = mySpriteSheet, frames={1}, time= 200, loopCount=1   }
   }
	spriteDisplay = display.newSprite( sceneGroup,  mySpriteSheet, sequence )
	spriteDisplay.x = _W/2
	spriteDisplay.y = _H/2


	batGroup.x = _W/2
	batGroup.y = _H/2
	batGroup.isVisible = false


	rect = display.newRect( _W/2, _H*0.10, 50, 100 )
	rect.isVisible= true
	rect.anchorY=0.2
	sceneGroup:insert( rect  )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	bat2.isVisible=false

	spriteDisplay:play()
	elseif phase == "did" then

	batTimer = timer.performWithDelay( 400, mostrar, 5  )


	function rect:touch( event)
		if event.phase == "ended" or event.phase == "cancelled" then 
			detenerCronometro()
		end
	end

	rect:addEventListener( "touch", rect )

	function mover(  )

		angulo = angulo + 1 
		rect.rotation = angulo
		-- rect.x = rect.x +5
		-- rect.y = rect.y +5
		if rect.x >= _W then
			rect.x = 0
		end	
		if rect.y >= _H then
			rect.y = 0
		end
	end

 	myTimer = timer.performWithDelay( 1000, descontar, 60 )

	Runtime:addEventListener( "enterFrame", mover )
		-- Called when the scene is now on screen
		-- 

		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		

	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		-- remove event listener from background
--		background:removeEventListener( "touch", background )
--		Runtime:removeEventListener( "enterFrame", mover )
	elseif phase == "did" then
		-- Called when the scene is now off screen

	-- rect.isVisible=false		

	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	display.remove( rect )
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene