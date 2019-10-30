local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
--------------------------------------------

local background


local function handleButtonEvent( event )
	if event.phase == "ended" or event.phase == "cancelled" then
		options = {
        	params = { game_mode = "singleplayer" }
        	--effect = "fade"
    	}
		composer.gotoScene( "juego", options)
		
		return true	
	end
end

local function handleButtonEvent2( event )
	if event.phase == "ended" or event.phase == "cancelled" then
		options = {
        	params = { game_mode = "multiplayer" }
    	}
		composer.gotoScene( "juego", options)
		
		return true	
	end
end

function scene:create( event )
	local sceneGroup = self.view

	-- display a background image
	background = display.newImageRect( sceneGroup, "arcade2.jpg", display.contentWidth+100, display.contentHeight )
	--background.anchorX = 0.5
	--background.anchorY = 0.5
	background.x, background.y = display.screenOriginX+display.contentCenterX+50, display.contentCenterY
	background.alpha = 0.6

	local pageTitle = display.newText( "PONG", 0, 0, "Digital.otf", 60 )
	pageTitle.x = display.contentWidth * 0.5
	pageTitle.y = display.contentHeight - (display.contentHeight*0.78)	
	--local fadeTween1 = transition.to( pageTitle, { time=2000, transition=easing.inOutExpo} )	

    local button1 = widget.newButton (
    {
        x = display.contentWidth * 0.5,
        y = display.contentHeight * 0.58,
        --width = 360,
        --height = 70,
        id = "button1",
        --shape = "roundedRect",
        --emboss = true,
        label = "1 JUGADOR",
        --labelAlign = "center",
        font = "Inversionz.ttf",
        fontSize = 40,
        --strokeWidth = 5,
        --cornerRadius = 30,
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        --fillColor = { default={ 66/255, 170/255, 245/255, 0.2 }, over={ 66/255, 170/255, 245/255, 0,7 } },
        --strokeColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
        onEvent = handleButtonEvent
    }
)

    local button2 = widget.newButton (
    {
        x = display.contentWidth * 0.5,
        y = display.contentHeight * 0.78,
        --width = 360,
        --height = 70,
        id = "button2",
        --shape = "roundedRect",
        --emboss = true,
        label = "2 JUGADORES",
        --labelAlign = "right",
        font = "Inversionz.ttf",
        fontSize = 40,
        --strokeWidth = 5,
        --cornerRadius = 30,
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        --fillColor = { default={ 66/255, 170/255, 245/255, 0.2 }, over={ 66/255, 170/255, 245/255, 0,7 } },
        --strokeColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
        onEvent = handleButtonEvent2
    }
)

	sceneGroup:insert( background )
	sceneGroup:insert( pageTitle )
	sceneGroup:insert( button1 )
	sceneGroup:insert( button2 )
end


---------------------------------------------------------------------------------

scene:addEventListener( "create", scene )

return scene