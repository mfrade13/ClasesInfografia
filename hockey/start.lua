-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"
local physics = require "physics"
--------------------------------------------

-- forward declarations and other locals

-- local variables for game objects
local puck
local paddle1
local paddle2

local wall1
local wall2
local ground
local ceil

local goal1
local goal2

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist.
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

    -- display a background image
    local background = display.newImageRect( "board.jpg", display.actualContentWidth, display.actualContentHeight )

    background.anchorX = 0
    background.anchorY = 0
    background.x = 0 + display.screenOriginX 
    background.y = 0 + display.screenOriginY
    score1= widget.newButton{
        label="0",
        labelColor = { default={0}, over={0} },
        width=0, height=0, x=display.contentWidth / 2, y = display.contentHeight / 2 - 130
    }
    score2= widget.newButton{
        label="0",
        labelColor = { default={0}, over={0} },
        width=0, height=0, x=display.contentWidth / 2, y = display.contentHeight / 2 + 130
    }
    score1.rotation = 180
    physics.start()
    physics.setGravity( 0, 0 )
    --display.setDrawMode( "hybrid")

    puck = display.newCircle( display.contentWidth / 2, display.contentHeight / 2, 20 )
    -- all display objects must be inserted into group
    paddle1 = display.newCircle( display.contentWidth / 2, display.contentHeight / 2 - 130, 30 )
    paddle2 = display.newCircle( display.contentWidth / 2, display.contentHeight / 2 + 130, 30 )
    
    wall1 = display.newRect( 0, display.contentHeight/2, 20, display.contentHeight + 100 )
    wall2 = display.newRect( display.contentWidth, display.contentHeight/2, 20, display.contentHeight + 100)
    
    ground1 = display.newRect( 0, display.contentHeight + 40, 3 * display.contentWidth / 4, 20 )
    ground2 = display.newRect( display.contentWidth, display.contentHeight + 40, 3 * display.contentWidth / 4, 20 )
    
    ceil1 = display.newRect( 0, -40, 3 * display.contentWidth/4, 20 )
    ceil2 = display.newRect( display.contentWidth, -40, 3 * display.contentWidth/4, 20 )

    goal1 = display.newRect( display.contentWidth / 2, -80, display.contentWidth, 20 )
    goal2 = display.newRect( display.contentWidth / 2, display.contentHeight + 80, display.contentWidth, 20 )

    goal1:setFillColor(0, 1, 0)
    goal2:setFillColor(0, 1, 0)

    puck:setFillColor(0.3, 0.7, 0.3)

    paddle1:setFillColor( 0.9, 0.6, 0.9 )
    paddle2:setFillColor( 0.9, 0.9, 0.3 )

    paddle1.score = 0
    paddle2.score = 0
    paddle1.name = "paddle1"
    paddle2.name = "paddle2"
    goal1.name = "goal1"
    goal2.name = "goal2"
    sceneGroup:insert( background )
    sceneGroup:insert( puck )
    sceneGroup:insert( paddle1 )
    sceneGroup:insert( paddle2 )
    sceneGroup:insert(wall1)
    sceneGroup:insert(wall2)
    sceneGroup:insert(ceil1)
    sceneGroup:insert(ceil2)
    sceneGroup:insert(ground1)
    sceneGroup:insert(ground2)
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
        physics.addBody( puck, "dynamic", { density=1.0, friction=0.5, bounce=0.9, radius=20 } )
        physics.addBody( paddle1, "dynamic", { density=1.0, friction=0.5, bounce=0.9, radius=30 } )
        physics.addBody( paddle2, "dynamic", { density=1.0, friction=0.5, bounce=0.9, radius=30 } )

        physics.addBody( ground1, "static", { friction=0.5, bounce=0.3 } )
        physics.addBody( ground2, "static", { friction=0.5, bounce=0.3 } )
        physics.addBody( wall1, "static", { friction=0.5, bounce=0.3 } )
        physics.addBody( wall2, "static", { friction=0.5, bounce=0.3 } )
        physics.addBody( ceil1, "static", { friction=0.5, bounce=0.3 } )
        physics.addBody( ceil2, "static", { friction=0.5, bounce=0.3 } )

        physics.addBody( goal1, "static", { friction=0.5, bounce=0.3 } )
        physics.addBody( goal2, "static", { friction=0.5, bounce=0.3 } )

        function paddle1:touch(event)
            local phase = event.phase
            if phase == "began" then
                if(event.y >= display.contentHeight / 2 - 1) then
                    self.y = display.contentHeight / 2
                    self:setLinearVelocity( 0, 0 )
                    self.angularVelocity = 0
                end
            elseif phase == "moved" then
                if(event.y >= display.contentHeight / 2 - 1) then
                    self.y = display.contentHeight / 2
                else
                    self.y = event.y
                end
                self.x = event.x
                self:setLinearVelocity( 0, 0 )
                self.angularVelocity = 0
            end
        end
        function paddle2:touch(event)
            local phase = event.phase
            if phase == "began" then
                if(event.y <= display.contentHeight / 2 + 1) then
                    self.y = display.contentHeight / 2
                    self:setLinearVelocity( 0, 0 )
                    self.angularVelocity = 0
                end
            elseif phase == "moved" then
                if(event.y <= display.contentHeight / 2 + 1) then
                    self.y = display.contentHeight / 2
                else
                    self.y = event.y
                end
                self.x = event.x
                self:setLinearVelocity( 0, 0 )
                self.angularVelocity = 0
            end
        end
        function updateScore()
            score1:setLabel( "" .. paddle1.score )
            score2:setLabel( "" .. paddle2.score )
            puck.x = display.contentWidth / 2
            puck.y = display.contentHeight / 2
            paddle1.x = display.contentWidth / 2
            paddle1.y = display.contentHeight / 2 - 130
            paddle2.x = display.contentWidth / 2
            paddle2.y = display.contentHeight / 2 + 130
            puck:setLinearVelocity(0, 0)
        end
        function puck:collision( event )
            local phase = event.phase
            if phase == "began" then
                if event.other.name then
                    self:applyLinearImpulse( -(event.other.x - self.x)/5, -(event.other.y - self.y)/5, self.x, self.y )
                end
            elseif phase == "ended" then
                if event.other.name == "goal1" then
                    paddle2.score = paddle2.score + 1
                    timer.performWithDelay( 20, updateScore )
                elseif event.other.name == "goal2" then
                    paddle1.score = paddle1.score + 1
                    timer.performWithDelay( 20, updateScore )
                end
            end
        end

        paddle1:addEventListener( "touch", paddle1 )
        paddle2:addEventListener( "touch", paddle2 )
        puck:addEventListener( "collision", puck )
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
    elseif phase == "did" then
        -- Called when the scene is now off screen
    end 
end

function scene:destroy( event )
    local sceneGroup = self.view
    
    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc.
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene