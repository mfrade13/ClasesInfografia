
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

--------------------------------------------

local background


local function handleButtonEvent( event )
	if event.phase == "ended" or event.phase == "cancelled" then
		
		composer.gotoScene( "player", "fade" )
		
		return true	
	end
end

function scene:create( event )
	local sceneGroup = self.view

	
	background = display.newImageRect( sceneGroup, "arcade2.jpg", display.contentWidth+100, display.contentHeight )
	--background.anchorX = 0.5
	--background.anchorY = 0.5
	background.x, background.y = display.screenOriginX+display.contentCenterX+50, display.contentCenterY
	background.alpha = 0.6
	--display.setDefault("background", 2, 2, 2/255)
	
	local pageTitle = display.newText( "PONG", 0, 0, "Digital.otf", 50 )
	pageTitle.x = display.contentCenterX
	pageTitle.y = display.contentCenterY
	--pageTitle:setFillColor(250/255, 250/255, 80/255)

    local button1 = widget.newButton (
    {
        x = display.contentWidth * 0.5,
        y = display.contentHeight * 0.8,
        --width = 170,
        --height = 80,
        id = "button",
        --shape = "roundedRect",
        --emboss = true,
        label = "PLAY",
        --labelAlign = "right",
        font = "Inversionz.ttf",
        fontSize = 40,
        --strokeWidth = 5,
        --cornerRadius = 30,
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        --fillColor = { default={ 66/255, 170/255, 245/255, 0.3 }, over={ 66/255, 170/255, 245/255, 0,7 } },
        --strokeColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
        onEvent = handleButtonEvent
    }
)

	sceneGroup:insert( background )
	sceneGroup:insert( pageTitle )
	sceneGroup:insert( button1 )
end

---------------------------------------------------------------------------------

scene:addEventListener( "create", scene )

return scene