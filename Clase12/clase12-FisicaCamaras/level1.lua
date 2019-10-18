-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
local crate,background, wallB,wallT,wallL,wallR
--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

local function cambiarAMenu()
	
	-- go to level1.lua scene
	composer.gotoScene( "menu", "fade", 500 )
	
	return true	-- indicates successful touch
end
local group, sceneGroup, caja2, wallL

function moverCamara()
	if crate.x >= screenW/2 then
		sceneGroup.x = -crate.x + (halfW)
	end
	--sceneGroup.y = -crate.y + (screenH/2)
	--print(crate.x, sceneGroup.x)
end

function cambiarCuerpoFisico(  )
	caja2.bodyType = "dynamic"
	--wallB.bodyType = "dynamic"
end


function scene:create( event )


	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	sceneGroup = self.view
 	group = display.newGroup( )
	-- We need physics started to add bodies, but we don't want the simulaton
	-- running until the scene is on the screen.
	physics.start()
	physics.pause()


	-- create a grey rectangle as the backdrop
	-- the physical screen will likely be a different shape than our defined content area
	-- since we are going to position the background from it's top, left corner, draw the
	-- background at the real top, left corner.
	background = display.newRect( display.screenOriginX, display.screenOriginY, screenW, screenH )
	background.anchorX = 0 
	background.anchorY = 0
	background:setFillColor( .5 )
	
	background2 = display.newRect(sceneGroup, screenW*2, display.screenOriginY, screenW, screenH )
	background2.anchorX = 1 
	background2.anchorY = 0
	background2:setFillColor( 1,0,0 )


	-- make a crate (off-screen), position it, and rotate slightly
--	crate = display.newImageRect( "crate.png", 90, 90 )
	crate = display.newCircle( 160, -100, 45 )
	crate.x, crate.y = 160, -100
	crate.rotation = 15
	crate.name = "Crate"
	


	caja2 = display.newRect( 130, display.contentHeight-80, 40, 40 )
	caja2.name = "Caja"

	function background:touch(event)
		if event.phase == "ended" then
			cambiarAMenu()
		end
	end


	-- add physics to the crate
	
	-- create a wallB object and add physics (with custom shape)
	wallB = display.newImageRect( "grass.png", screenW, 82 )
	wallB.anchorX = 0
	wallB.anchorY = 1
	wallB.name = "piso"

	wallL = display.newRect(sceneGroup, screenW*1.5, screenH/2, 30,screenH )
	wallL.name = "Pared"

	--  draw the wallB at the very bottom of the screen
	wallB.x, wallB.y = display.screenOriginX, display.actualContentHeight + display.screenOriginY
	
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	local wallBShape = { -halfW,-34, screenW*3,-34, screenW*3,34, -halfW,34 }
	physics.addBody( wallB, "static", { friction=0.0, bounce=0, shape = wallBShape } )
	
	physics.addBody( wallL, "static", { friction=0.0, bounce=0 } )
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( wallB)
	sceneGroup:insert( group )
	group:insert( crate )
	sceneGroup:insert( caja2 )
end


function scene:show( event )
	sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		crate.y=  100
		crate.x = 160
		crate.rotation=0

	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 

		function choque( self, event )
			local phase = event.phase
				print("collision")

			if phase == "began" then
				print("Yo " .. self.name  ..  " Te estas chocando con " .. event.other.name )
			elseif phase == "ended" then
				if event.other.name == "Caja" then
					event.other.bodyType = "dynamic"
					print('Cambio')
				end
--				timer.performWithDelay( 1000, cambiarCuerpoFisico,1 )

				event.other:setFillColor( math.random(0,255)/255, math.random(0,255)/255,math.random(0,255)/255  )
			end
		end
		physics.addBody(caja2, "kinematic",{bounce=0 } )

		crate.collision = choque
		crate:addEventListener( "collision", crate )

		physics.setDrawMode( "hybrid" )
		print(crate.x, crate.y)
		print(physics.getGravity() )
		physics.setGravity( 0, 4.8 )
		physics.start()
		physics.addBody( crate, 'dynamic', { density=1.0, friction=0.0, bounce=0.5, radius =35 } )


		








		Runtime:addEventListener( 'enterFrame', moverCamara )


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
		physics.stop()
		background:removeEventListener('touch', background)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene