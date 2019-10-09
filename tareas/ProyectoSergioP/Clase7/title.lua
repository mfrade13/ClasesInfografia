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
local background,rect
local _W = display.contentWidth
local _H = display.contentHeight

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

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	background = display.newImageRect( sceneGroup, "space.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0

	background.touch = onBackgroundTouch
	background:addEventListener( "touch", background )



	-- Add more text
	local pageText = display.newText( "[ Touch screen to continue ]", 0, 0, native.systemFont, 18 )
	pageText.x = display.contentWidth * 0.5
	pageText.y = display.contentHeight - (display.contentHeight*0.1)	
	
	local myButton = widget.newButton{
		id = 'myButton',
		x = _W/2,
		y = _H/2,
		onRelease = cambiarPagina,	
		defaultFile="button.png",
		overFile="button-over.png",
		width = 100,
		height = 100,
		label = 'PLAY!',
		fontSize = 50,
		labelColor = {default = {1,0,0}, over = {0,1,0}   }
		}

		myButton.x = 100
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( pageText )
	sceneGroup:insert( myButton)

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


	elseif phase == "did" then


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