local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

function scene:create(event)
	local sceneGroup = self.view
	
    system.activate("multitouch")

	local game_mode = event.params.game_mode

	--[[local maxWidth = display.contentWidth
    local maxHeight = display.safeActualContentHeight]]

    local physics = require("physics")
    physics.start()
    physics.setGravity(0, 0)

    display.setDefault("background", 0, 0, 0)

    
    local top_wall = display.newRoundedRect(display.contentCenterX, 10, display.safeActualContentWidth, 10, 15)
    physics.addBody(top_wall, "static")
    local bottom_wall = display.newRoundedRect(display.contentCenterX, display.contentHeight-10, display.safeActualContentWidth, 10, 15)
    physics.addBody(bottom_wall, "static")
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

	local button = widget.newButton (
    {
        x = display.contentWidth * 0.5,
        y = display.contentHeight * 0.92,
        id = "button",
        label = "VOLVER",
        font = "Inversionz.ttf",
        fontSize = 40,
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        onEvent = handleButtonEvent2
    }
    )
    button.alpha = 0.6

    local function move_ball()
        physics.start()
        if ball.x == display.contentCenterX and ball.y == display.contentCenterY then
            local direction = math.random(4)
            if direction == 1 then
                ball:setLinearVelocity(-200, -200)
            elseif direction == 2 then
                ball:setLinearVelocity(200, -200)
            elseif direction == 3 then
                ball:setLinearVelocity(-200, 200)
            elseif direction == 4 then
                ball:setLinearVelocity(200, 200)
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
	if game_mode == "multiplayer" then
    	left_player:addEventListener("touch", move_player)
	end

    local function game_loop()
    	--move_ball()
		if game_mode == "singleplayer" then
			left_player.y = ball.y
		end

        if ball.x < -35 or ball.x > display.contentWidth+35 then
            
			if ball.y < 0 then
				right_score = right_score + 1
				right_score_text.text = right_score
			else
				left_score = left_score + 1
				left_score_text.text = left_score
			end

            
			left_player.x = -35
			left_player.y = display.contentCenterY
			right_player.x = display.contentWidth+35
			right_player.y = display.contentCenterY

            
            ball.x = display.contentCenterX
            ball.y = display.contentCenterY

            --move_ball()

            physics.pause()
        end
    end
    local game_loop_timer = timer.performWithDelay(20, game_loop, 0)
end

scene:addEventListener("create", scene)

return scene
