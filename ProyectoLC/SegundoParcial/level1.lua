-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
local ball,player1,player2,Tscore1,Tscore2 
local score1,score2=0,0
--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

function scene:create( event )
	system.activate( "multitouch" )
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- We need physics started to add bodies, but we don't want the simulaton
	-- running until the scene is on the screen.
	physics.start()
	physics.pause()


	-- create a grey rectangle as the backdrop
	-- the physical screen will likely be a different shape than our defined content area
	-- since we are going to position the background from it's top, left corner, draw the
	-- background at the real top, left corner.
	local background = display.newRect( display.screenOriginX, display.screenOriginY, screenW, screenH )
	background.anchorX = 0 
	background.anchorY = 0
	background:setFillColor( .8 )
	
	Tscore1 = display.newText( 0, 250, 100 ,native.systemFontBold,40)
	
	 Tscore2 = display.newText( 0, 350, 100 ,native.systemFontBold,40)
	
	
	-- make a crate (off-screen), position it, and rotate slightly
	local crate = display.newImageRect( "crate.png", 90, 90 )
	crate.x, crate.y = 160, -100
	crate.rotation = 15
	
	-- add physics to the crate
	physics.addBody( crate, { density=1.0, friction=0.3, bounce=0.3 } )
	
	local middle=display.newLine(300,0,300,800)
	middle.strokeWidth = 8
	-- create a grass object and add physics (with custom shape)
	local bottomMargin = display.newImageRect( "brickWall.jpg", screenW, 40 )
	bottomMargin.anchorX = 0
	bottomMargin.anchorY = 1
	--  draw the grass at the very bottom of the screen
	bottomMargin.x, bottomMargin.y = display.screenOriginX, display.actualContentHeight + display.screenOriginY
	
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	local marginShape = { -halfW,-20, halfW,-20, halfW,20, -halfW,20 }
	
	physics.addBody(bottomMargin, "static", { friction=0.3, shape=marginShape} )

	
	local topMargin = display.newImageRect( "brickWall.jpg", screenW, 40 )
	topMargin.anchorX = 0
	topMargin.anchorY = 1
	--  draw the grass at the very bottom of the screen
	topMargin.x, topMargin.y = 0, 30
	
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	local marginShape = { -halfW,-20, halfW,-20, halfW,20, -halfW,20 }
	physics.addBody(topMargin, "static", { friction=0.3, shape=marginShape} )
	
	--MARGIN

	local rightMarginT = display.newImageRect( "brickWall.jpg", 40, 300 )
	rightMarginT.anchorX = 0
	rightMarginT.anchorY = 1
	--  draw the grass at the very bottom of the screen
	rightMarginT.x, rightMarginT.y =570, 250
	
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	local marginShape = { -25,-150, -25,150, 25, 150,25,-150 }
	physics.addBody(rightMarginT, "static", { friction=0.3, shape=marginShape} )
	
	local rightMarginB = display.newImageRect( "brickWall.jpg", 40, 300 )
	rightMarginB.anchorX = 0
	rightMarginB.anchorY = 1
	--  draw the grass at the very bottom of the screen
	rightMarginB.x, rightMarginB.y =570, 850
	
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	local marginShape = { -25,-150, -25,150, 25, 150,25,-150 }
	physics.addBody(rightMarginB, "static", { friction=0.3, shape=marginShape} )
	
	local leftMarginT = display.newImageRect( "brickWall.jpg", 30, 300 )
	leftMarginT.anchorX = 0
	leftMarginT.anchorY = 1
	--  draw the grass at the very bottom of the screen
	leftMarginT.x, leftMarginT.y =0, 250
	
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	local marginShape = { -25,-150, -25,150, 25, 150,25,-150 }
	physics.addBody(leftMarginT, "static", { friction=0.3, shape=marginShape} )
	
	local leftMarginB = display.newImageRect( "brickWall.jpg", 30, 300 )
	leftMarginB.anchorX = 0
	leftMarginB.anchorY = 1
	--  draw the grass at the very bottom of the screen
	leftMarginB.x, leftMarginB.y =0, 850
	
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	local marginShape = { -25,-150, -25,150, 25, 150,25,-150 }
	physics.addBody(leftMarginB, "static", { friction=0.3, shape=marginShape} )
	
	--Ball
	ball = display.newImageRect( "Disc.png", 20, 20 )
	ball.anchorX = 0
	ball.anchorY = 1
	ball.x, ball.y =300, 400
	
	local marginShape = { -10,-10, -10,10, 10, 10,10,-10 }
	physics.addBody(ball, { friction=3, radius=10, bounce=0.5 } )


	--Player 1
	player1 = display.newImageRect( "Barra.png", 100, 250 )
	player1.name="player1"
	player1.anchorX = 0
	player1.anchorY = 1
	player1.x, player1.y =500, 300
	
	local marginShape = { -10,-50, -10,75, 5, 75,5,-50 }
	physics.addBody(player1, "static", { friction=0.3, shape=marginShape} )

	--Player 2
	 player2 = display.newImageRect( "Barra.png", 100, 250 )
	player2.name="player2"
	player2.anchorX = 0
	player2.anchorY = 1
	player2.x, player2.y =0, 500
	
	local marginShape = { -10,-50, -10,75, 5, 75,5,-50 }
	physics.addBody(player2, "static", { friction=0.3, shape=marginShape} )


	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( middle)
	
	sceneGroup:insert( Tscore1)
	sceneGroup:insert( Tscore2 )
	sceneGroup:insert( bottomMargin)
	sceneGroup:insert( topMargin)
	sceneGroup:insert( player1)
	sceneGroup:insert( player2)
	sceneGroup:insert( ball)
	sceneGroup:insert( rightMarginT)
	sceneGroup:insert( rightMarginB)
	sceneGroup:insert( leftMarginT)
	sceneGroup:insert( leftMarginB)
	sceneGroup:insert( crate )
end



function start()
	ball:applyLinearImpulse( 1, 8, ball.x, ball.y )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
		physics.setGravity(0,0)
		--physics.setDrawMode("hybrid")


		start()

		function moverPlayer1( newx,newy)
			player1.x = newx
			player1.y = newy
		end

		function moverPlayer2( newx,newy)
			player2.x = newx
			player2.y = newy
		end

		function sceneGroup:touch( event )
			local phase = event.phase
			if phase == "began" then
				--print ("barra tocada")
			elseif phase == "moved" then
				--print(event.y .. "   ,   ".. player1.y)
				if(event.x>300) then
					moverPlayer1(event.x,event.y)
				else 
					moverPlayer2(event.x,event.y)
				end
			elseif phase == "ended" or phase == "cancelled" then
				--print ("end m8")
			end
		end


		function choque( self, event )
			local phase = event.phase
		--	print("collision can jump state", crate.canJump)

			if phase == "began" then
		--		print("Yo " .. self.name  ..  " Te estas chocando con " .. event.other.name )
			elseif phase == "ended" then
				if event.other.name == "player1" then
		--			event.other.bodyType = "dynamic"
					ball:applyLinearImpulse( -1, 2, ball.x, ball.y )

				end
--				timer.performWithDelay( 1000, cambiarCuerpoFisico,1 )
				if event.other.name == "player2" then
					ball:applyLinearImpulse( 1, 3, ball.x, ball.y )

		--			crate.canJump = true	--habilita al objeto a saltar
				end
		--		event.other:setFillColor( math.random(0,255)/255, math.random(0,255)/255,math.random(0,255)/255  )
			end
		end

		function respawn( )
			if(ball.x>600)then
				score1 =score1 +1
				Tscore1.text=score1
				ball.x=300
			elseif (ball.x<0)then
				score2 = score2+1
				Tscore2.text=score2
				ball.x=300
			end
		end

		function wall(  )
			if player1.x<270 then
				player1.x=300
			end
			if player2.x>230 then
				player2.x=200
			end
		end

		ball.collision=choque
		ball:addEventListener( "collision", ball )

		Runtime:addEventListener("enterFrame", wall)
		Runtime:addEventListener( "enterFrame", respawn  )
		sceneGroup:addEventListener( "touch", sceneGroup)
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