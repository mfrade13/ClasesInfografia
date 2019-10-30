local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

function scene:create(event)
	local sceneGroup = self.view
	
    system.activate("multitouch")

	local modo = event.params.game_mode

	--[[local maxWidth = display.contentWidth
    local maxHeight = display.safeActualContentHeight]]

    local physics = require("physics")
    physics.start()
    physics.setGravity(0, 0)

    display.setDefault("background", 0, 0, 0)

    
    local top_wall = display.newRoundedRect(display.contentCenterX, 10, display.safeActualContentWidth-55, 10, 15)
    physics.addBody(top_wall, "static")
    top_wall:setFillColor(math.random(),math.random(),math.random())
    local bottom_wall = display.newRoundedRect(display.contentCenterX, display.contentHeight-10, display.safeActualContentWidth-55, 10, 15)
    physics.addBody(bottom_wall, "static")
    bottom_wall:setFillColor(math.random(),math.random(),math.random())
    local middle_wall = display.newRect(display.contentCenterX, display.contentCenterY, 8, display.contentHeight-80)
    middle_wall.alpha = 0.7

	local left_player = display.newRoundedRect(-35, display.contentCenterY, 15, 60, 15)
	physics.addBody(left_player, "static")
	left_player.anchorX = 0
	--top_racket:setFillColor(0)
	local right_player = display.newRoundedRect(display.contentWidth+35, display.contentCenterY, 15, 60, 15)
	physics.addBody(right_player, "static")
	right_player.anchorX = 1
	--bottom_racket:setFillColor(0)

    local ball = display.newCircle(display.contentCenterX, display.contentCenterY, 10)
    --ball:setFillColor(1, 0, 0)
    physics.addBody(ball, "dynamic", {density=1, friction=0, bounce = 1})

    
	local left_score = 0
	local left_score_text = display.newText {
		text = left_score,
		x = display.contentCenterX*0.7,
		y = display.contentCenterY*0.5,
		font = "Inversionz.ttf",
		fontSize = 135
	}
	left_score_text.alpha = 0.6
	--left_score_text:setFillColor(0)
	--top_score_text.anchorX = 0

	local right_score = 0
	local right_score_text = display.newText {
		text = right_score,
		x = display.contentCenterX*1.3,
		y = display.contentCenterY*0.5,
		font = "Inversionz.ttf",
		fontSize = 135
	}
	right_score_text.alpha = 0.6
	--bottom_score_text:setFillColor(0)
	--bottom_score_text.anchorX = 1
	local function handleButtonEvent( event )
	if event.phase == "ended" or event.phase == "cancelled" then
		
		composer.gotoScene( "player" )
		resetgame()
		display.remove(winningText)
        display.remove(losingText)
        left_score = 0
		left_score_text.text = left_score
		right_score = 0
		right_score_text.text = right_score
		--composer.removeScene( "scene" )
		--modo = nil
		--local reset_timer = timer.performWithDelay(1000, resetgame(), 1)
		return true	
	end
	end
	local button = widget.newButton (
    {
        x = display.contentWidth * 0.5,
        y = display.contentHeight * 0.92,
        id = "button",
        label = "VOLVER",
        font = "Inversionz.ttf",
        fontSize = 40,
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        onEvent = handleButtonEvent
    }
    )
    button.alpha = 0.6

    --[[function ball:onCollision( wall )

    	if self.y > wall.y + wall.width/2 + 10 or wall.y > self.x + 10 + wall.width/2 then
    		return false
    	else
			return true
		end
	end]]

	local function onCollision( self, event )
    	print("true")
    	x=math.random()
		y=math.random()
		z=math.random
		top_wall:setFillColor(x,y,z)
		bottom_wall:setFillColor(x,y,z)
	end

	local function onCollision2( self, event )
    	print("true")
    	x=math.random()
		y=math.random()
		z=math.random
		bottom_wall:setFillColor(x,y,z)
	end

	--top_wall.collision = onCollision
	top_wall:addEventListener( "collision", onCollision )
	bottom_wall:addEventListener("collision", onCollision2)
	--onCollision2(bottom_wall, "collision")

    local function move_ball()
        physics.start()
        display.remove(winningText)
        display.remove(losingText)
        if ball.x == display.contentCenterX and ball.y == display.contentCenterY then
            local direction = math.random(4)
            if direction == 1 then
                ball:setLinearVelocity(-display.contentWidth/2, -display.contentWidth/2)
            elseif direction == 2 then
                ball:setLinearVelocity(display.contentWidth/2, -display.contentWidth/2)
            elseif direction == 3 then
                ball:setLinearVelocity(-display.contentWidth/2, display.contentWidth/2)
            elseif direction == 4 then
                ball:setLinearVelocity(display.contentWidth/2, display.contentWidth/2)
            end
        end
    end
    ball:addEventListener("tap", move_ball)

	local function move_player(event)
	    local player = event.target
	    local phase = event.phase

	    if phase == "began" then
			display.getCurrentStage():setFocus(racket, event.id)
	        dif = event.y - player.y
	    
	    elseif phase == "moved" then
	        player.y = event.y - dif
	       
		elseif phase == "ended" or phase == "cancelled" then
	        display.getCurrentStage():setFocus(player, nil)
	    end
	    return true
	end

	right_player:addEventListener("touch", move_player)
	if modo == "multiplayer" then
    	left_player:addEventListener("touch", move_player)
	end

	function resetgame()

		left_player.x = -35
			left_player.y = display.contentCenterY
			right_player.x = display.contentWidth+35
			right_player.y = display.contentCenterY

            
            ball.x = display.contentCenterX
            ball.y = display.contentCenterY

            --move_ball()

            physics.pause()
	end

    local function game_loop()
    	--move_ball()
		if modo == "singleplayer" then
			left_player.y = ball.y
		end

		--[[if ball:onCollision(top_wall) then
			x=math.random()
			y=math.random()
			z=math.random
			top_wall:setFillColor(x,y,z)
		end

		if ball:onCollision(bottom_wall) then
			x=math.random()
			y=math.random()
			z=math.random
			bottom_wall:setFillColor(x,y,z)
		end]]

        if ball.x < -35 or ball.x > display.contentWidth+35 then
            
			if ball.x < -35 then
				right_score = right_score + 1
				right_score_text.text = right_score
			else
				left_score = left_score + 1
				left_score_text.text = left_score
			end

			if left_score == 2 then
				left_score = 0
				left_score_text.text = left_score
				winningText = display.newText( "WIN", display.contentCenterX*0.5, display.contentCenterY, "Digital.otf" , 40 )
        		winningText:setFillColor( 95/255, 191/255, 250/255 )
        		losingText = display.newText( "LOSE", display.contentCenterX*1.5, display.contentCenterY, "Digital.otf" , 40 )
        		losingText:setFillColor( 95/255, 191/255, 250/255 )
			elseif right_score == 2 then
				right_score = 0
				right_score_text.text = right_score
				winningText = display.newText( "WIN", display.contentCenterX*1.5, display.contentCenterY, "Digital.otf" , 40 )
        		winningText:setFillColor( 95/255, 191/255, 250/255 )
        		losingText = display.newText( "LOSE", display.contentCenterX*0.5, display.contentCenterY, "Digital.otf" , 40 )
        		losingText:setFillColor( 95/255, 191/255, 250/255 )
			end
            
            resetgame()
			
        end
    end
    local game_loop_timer = timer.performWithDelay(20, game_loop, 0)

    sceneGroup:insert( top_wall )
	sceneGroup:insert( bottom_wall )
	sceneGroup:insert( middle_wall )
	sceneGroup:insert( left_player )
	sceneGroup:insert( left_score_text )
	sceneGroup:insert( right_player )
	sceneGroup:insert( right_score_text )
	sceneGroup:insert( ball )
	sceneGroup:insert( button )
	--sceneGroup:insert( winningText )
	--sceneGroup:insert( losingText )

end

function scene:show( event )
    local sceneGroup = self.view
    

end


function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	if ( phase == "will" ) then
		timer.performWithDelay( 1000, function() physics.stop();end )
		--slideOffSensor:removeEventListener( "touch", handleSlideOff )
		composer.removeScene("juego")
	elseif ( phase == "did" ) then

	end
end

--[[function scene:destroy( event )

	local sceneGroup = self.view
	local camera = self.view
	package.loaded[physics] = nil
	physics = nil

end]]

scene:addEventListener("create", scene)
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
--scene:addEventListener("destroy", scene)

return scene
