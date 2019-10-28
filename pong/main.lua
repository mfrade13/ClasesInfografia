local widget = require('widget')
width  = display.contentWidth
height = display.contentHeight
local paddle_width = 100
local player1
local player2
local ball 


player1 = { x0 = 0, score = 0 }
player2 = { x0 = 0, score = 0 }

local physics = require('physics')
physics.start( )
physics.setScale( 10 )
physics.setGravity( 0, 0 )

system.activate( "multitouch" )

-- Limites

local endzone1 = display.newRect( display.contentWidth/2, display.contentHeight-100, display.contentWidth, 200 )
endzone1:setFillColor(250,0,0)
endzone1.alpha = 0.5

local endzone2 = display.newRect( display.contentWidth/2, 100, display.contentWidth, 200 )
endzone2:setFillColor(250,0,0)
endzone2.alpha = 0.5

local goal1 = display.newRect( display.contentWidth, 2.5+200, 10000, 5 )
physics.addBody( goal1, "static", {density = 1, friction = 0, bounce = 1, isSensor = false})
goal1:setFillColor( 0, 0, 0 )


local goal2 = display.newRect( display.contentWidth, display.contentHeight-2.5-200, 10000, 5)
physics.addBody( goal2, "static", {density = 1, friction = 0, bounce = 1, isSensor = false})
goal2:setFillColor( 0, 0, 0 )

local wall_left = display.newRect( 2.5, display.contentHeight/2, 5, display.contentHeight, {density = 1, friction = 0, bounce = 1, isSensor = false} )
physics.addBody( wall_left, "static")

local wall_right = display.newRect( display.contentWidth-2.5, display.contentHeight/2, 5, display.contentHeight, {density = 1, friction = 0, bounce = 1, isSensor = false} )
physics.addBody( wall_right, "static")

local player1score = display.newText( player1.score, display.contentWidth/2, display.contentHeight/2 - 25, native.systemfont, 40)


local player2score = display.newText( player2.score, display.contentWidth/2, display.contentHeight/2 + 25, native.systemfont, 40)

local paddle1 = display.newRect( display.contentWidth/2, display.contentHeight-25-200, paddle_width, 10 )
physics.addBody( paddle1, "static", {friction=0} )

local paddle2 = display.newRect( display.contentWidth/2, 25+200, paddle_width, 10 )
physics.addBody( paddle2, "static", {friction=0} )


function sacarBola()
  ball = display.newCircle( display.contentWidth/2, display.contentHeight/2, 15, 15)
  physics.addBody( ball, "dynamic", {density = 1, friction = 0, radius = 7.5, isSensor = false, bounce = 1} )



  local launchx = math.random(90,110)
  local launchy = math.random(90,110)

  if (math.random(0,1)==0) then
    launchx = -launchx
  end

  if (math.random(0,1)==0) then
    launchy = -launchy
  end

  ball:applyLinearImpulse(launchx, launchy)
end


-- Funciones

function refreshScore()
  player1score.text = player1.score
  player2score.text = player2.score
end

-- Listeners


function goal1struck( event )
  if event.phase=="began" then
    player2.score = player2.score + 1
    refreshScore()
    ball:removeSelf()
    timer.performWithDelay( 1000, sacarBola )
  end
end

goal1:addEventListener( "collision", goal1struck )

function goal2struck( event )
  if event.phase=="began" then
    player1.score = player1.score + 1
    refreshScore()
    ball:removeSelf()
    timer.performWithDelay( 1000, sacarBola )
  end
end

goal2:addEventListener( "collision", goal2struck )


controlTrayectoria = function( object )
  if object.x < object.width/2 then
    object.x = object.width/2
  end
  if object.x > display.viewableContentWidth - object.width/2 then
    object.x = display.viewableContentWidth - object.width/2
  end
end


function paddle1touch (event)
  if "began" == event.phase then
    player1.x0 = event.x - paddle1.x

  elseif "moved" == event.phase then
    paddle1.x = event.x - player1.x0
    controlTrayectoria( paddle1 )

  elseif "ended" == phase or "cancelled" == phase then
  end
  return true
end

endzone1:addEventListener("touch", paddle1touch)

function paddle2touch (event)
  if "began" == event.phase then
    player2.x0 = event.x - paddle2.x

  elseif "moved" == event.phase then
    paddle2.x = event.x - player2.x0
    controlTrayectoria( paddle2 )

  elseif "ended" == phase or "cancelled" == phase then
  end
  return true
end

endzone2:addEventListener("touch", paddle2touch)

-- Reset

function reset()
  player1.score = 0
  player2.score = 0
  refreshScore()
 if( ball.removeSelf ~= nil ) then    -- Check if it's still added to the display...
        ball:removeSelf()
        timer.performWithDelay( 1000, sacarBola )
  end
end


local reset = widget.newButton(
    {
        left = width/4,
        top = height/2,
        label = "Reset",
        labelColor = { default={ 250, 0, 0 }, over={ 250, 250, 0, 0.5 } },
        onRelease = reset
    })


-- Start Game
sacarBola()

