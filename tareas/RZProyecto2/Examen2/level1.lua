-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene()

-- include Corona's library
local physics = require "physics"
local widget = require("widget")

--------------------------------------------

-- paredes externas
local alto = {249, 525, 525, 525, 525}
local bajo = {237, 513, 237, 237, 513}
local derecha = {320, 195, 7, 320, 320}
local izquierda = {1, 1, 1, 313, 219}

local s1 = {1, -249, 320, -249,320, -237,1, -237}
local shapes = {
    {
        izquierda[1], -alto[1], derecha[1], -alto[1], derecha[1], -bajo[1],
        izquierda[1], -bajo[1]
    }, {
        izquierda[2], -alto[2], derecha[2], -alto[2], derecha[2], -bajo[2],
        izquierda[2], -bajo[2]
    }, {
        izquierda[3], -alto[3], derecha[3], -alto[3], derecha[3], -bajo[3],
        izquierda[3], -bajo[3]
    }, {
        izquierda[4], -alto[4], derecha[4], -alto[4], derecha[4], -bajo[4],
        izquierda[4], -bajo[4]
    }, {
        izquierda[5], -alto[5], derecha[5], -alto[5], derecha[5], -bajo[5],
        izquierda[5], -bajo[5]
    }
}

-- bloques
local blockHeights = {
    489, 489, 441, 441, 393, 296, 297, 297, 297, 297, 297, 346, 393, 525,
    525
}
local blockDowns = {
    465, 465, 417, 417, 369, 273, 273, 273, 273, 273, 273, 321, 321, 417,
    417
}
local blockLefts = {
    31, 78, 31, 78, 78, 31, 78, 125, 172, 219, 266, 219, 125, 125, 219
}
local blocksRights = {
    55, 101, 55, 101, 101, 55, 101, 148, 195, 242, 289, 242, 195, 195, 289
}

-- eles
local barsHeights = {393, 345, 393, 393}
local barsDowns = {321, 321, 369, 321}
local barsLefts = {31, 31, 219, 266}
local barsRights = {55, 102, 289, 289}

local blocks = {}
local bars = {}

for i = 1, 15 do
    blocks[i] = {
        blockLefts[i], -blockHeights[i], blocksRights[i], -blockHeights[i],
        blocksRights[i], -blockDowns[i], blockLefts[i], -blockDowns[i]
    }
end

for i = 1, 4 do
    bars[i] = {
        barsLefts[i], -barsHeights[i], barsRights[i], -barsHeights[i],
        barsRights[i], -barsDowns[i], barsLefts[i], -barsDowns[i]
    }
end

-- 'onRelease' event listener for btnGanar
local function onbtnGanarRelease()

    composer.gotoScene("level2", "fade", 500)

    return true -- indicates successful touch
end

local ganar = display.newCircle(207, 30, 10)

local bomberman = display.newImageRect("bomberman_front_1.png", 18, 20)
bomberman.x, bomberman.y = 20, 25

local enemy1Radio = 10
local enemy1Side = true -- true -> down; false -> up
local enemy1 = display.newCircle(113, 25, enemy1Radio)
enemy1.fill = {type = "image", filename = "enemy1_1.png"}

local enemy2Side = true -- true -> right; false -> left
local enemy2 = display.newImageRect("enemy1_2_d.png", 30, 15)
enemy2.x, enemy2.y = 145, 264

local pressingR = false
local pressingL = false
local pressingU = false
local pressingD = false

local frameR = 1
local frameL = 1
local frameU = 1
local frameD = 1

function moveEnemy1()
    local y = enemy1.y
    local move = 1
    if enemy1Side then
        if y + move < 264 then
            enemy1.y = y + move
        else
            enemy1Side = false
            enemy1.y = y - move
        end
    else
        if y - move > 25 then
            enemy1.y = y - move
        else
            enemy1Side = true
            enemy1.y = y + move
        end
    end
end

function moveEnemy2()
    local x = enemy2.x
    local move = 1
    if enemy2Side then
        if x + move < 293 then
            enemy2.x = x + move
        else
            enemy2Side = false
            enemy2.fill = {type = "image", filename = "enemy1_2_i.png"}
            enemy2.x = x - move
        end
    else
        if x - move > 145 then
            enemy2.x = x - move
        else
            enemy2Side = true
            enemy2.fill = {type = "image", filename = "enemy1_2_d.png"}
            enemy2.x = x + move
        end
    end
end

function moveControlRight()
    -- print("derecha")
    local x = bomberman.x
    local move = 1
    if pressingR then
        bomberman.x = x + move
        -- control de la animacion
        if frameR == 1 then
            bomberman.fill = {
                type = "image",
                filename = "bomberman_right_2.png"
            }
            frameR = 2
        elseif frameR == 2 then
            frameR = 1
            bomberman.fill = {
                type = "image",
                filename = "bomberman_right_3.png"
            }
        else
            bomberman.fill = {
                type = "image",
                filename = "bomberman_right_1.png"
            }
        end
    end
end

function moveControlLeft()
    -- print("izquierda")
    local x = bomberman.x
    local move = 1
    if pressingL then
        bomberman.x = x - move
        -- control de la animacion
        if frameL == 1 then
            bomberman.fill = {type = "image", filename = "bomberman_left_2.png"}
            frameL = 2
        elseif frameL == 2 then
            frameL = 1
            bomberman.fill = {type = "image", filename = "bomberman_left_3.png"}
        else
            bomberman.fill = {type = "image", filename = "bomberman_left_1.png"}
        end
    end
end

function moveControlUp()
    -- print("arriba")
    local y = bomberman.y
    local move = 1
    if pressingU then
        bomberman.y = y - move
        -- control de la animacion
        if frameU == 1 then
            bomberman.fill = {type = "image", filename = "bomberman_back_2.png"}
            frameU = 2
        elseif frameU == 2 then
            frameU = 1
            bomberman.fill = {type = "image", filename = "bomberman_back_3.png"}
        else
            bomberman.fill = {type = "image", filename = "bomberman_back_1.png"}
        end
    end
end

function moveControlDown()
    -- print("abajo")
    local y = bomberman.y
    local move = 1
    if pressingD then
        bomberman.y = y + move
        -- control de la animacion
        if frameD == 1 then
            bomberman.fill = {
                type = "image",
                filename = "bomberman_front_2.png"
            }
            frameD = 2
        elseif frameD == 2 then
            frameD = 1
            bomberman.fill = {
                type = "image",
                filename = "bomberman_front_3.png"
            }
        else
            bomberman.fill = {
                type = "image",
                filename = "bomberman_front_1.png"
            }
        end
    end
end

function scene:create(event)

    local sceneGroup = self.view

    physics.stop()
    physics.start()
    physics.pause()

    local background = display.newImageRect("clear_map_1.png", 320, 288)
    background.anchorX = 0
    background.anchorY = 0

    local grass = display.newImageRect("grass.png", 0, 0)
    grass.anchorX = 0
    grass.anchorY = 1
    grass.x, grass.y = display.screenOriginX,
                       display.actualContentHeight + display.screenOriginY

    local backgroundControl = display.newImageRect("controller_3.png", 320, 220)
    backgroundControl.anchorX = 0
    backgroundControl.anchorY = 0
    backgroundControl.x, backgroundControl.y = 0, 300

    -- controles
    function pressL()
        pressingL = true
        frameL = math.random(1, 2)
    end
    function releaseL()
        pressingL = false
        frameL = 3
    end
    local buttonLeft = widget.newButton({
        width = 40,
        height = 40,
        label = "  ",
        fontSize = 30,
        onPress = pressL,
        onRelease = releaseL,
        x = 45,
        y = 415
    })
    local buttonLeft2 = widget.newButton({
        width = 40,
        height = 40,
        label = "  ",
        fontSize = 30,
        onPress = pressL,
        onRelease = releaseL,
        x = 200,
        y = 415
    })
    
    function pressR()
        pressingR = true
        frameR = math.random(1, 2)
    end
    function releaseR()
        pressingR = false
        frameR = 3
    end
    local buttonRight = widget.newButton(
                            {
            width = 40,
            height = 40,
            label = "  ",
            fontSize = 30,
            onPress = pressR,
            onRelease = releaseR,
            x = 115,
            y = 415
        })
    local buttonRight2 = widget.newButton(
                            {
        width = 40,
        height = 40,
        label = "  ",
        fontSize = 30,
        onPress = pressR,
        onRelease = releaseR,
        x = 270,
        y = 415
    })
    
    function pressU()
        pressingU = true
        frameU = math.random(1, 2)
    end
    function releaseU()
        pressingU = false
        frameU = 3
    end
    local buttonUp = widget.newButton({
        width = 40,
        height = 40,
        label = "  ",
        fontSize = 30,
        onPress = pressU,
        onRelease = releaseU,
        x = 80,
        y = 370
    })
    local buttonUp = widget.newButton({
        width = 40,
        height = 40,
        label = "  ",
        fontSize = 30,
        onPress = pressU,
        onRelease = releaseU,
        x = 235,
        y = 370
    })

    function pressD()
        pressingD = true
        frameD = math.random(1, 2)
    end
    function releaseD()
        pressingD = false
        frameD = 3
    end
    local buttonDown = widget.newButton({
        width = 40,
        height = 40,
        label = "  ",
        fontSize = 30,
        onPress = pressD,
        onRelease = releaseD,
        x = 80,
        y = 455
    })
    local buttonDown2 = widget.newButton({
        width = 40,
        height = 40,
        label = "  ",
        fontSize = 30,
        onPress = pressD,
        onRelease = releaseD,
        x = 235,
        y = 455
    })

    physics.addBody(grass, "static", 
        {friction = 0.3, shape = shapes[1]},
        {friction = 0.3, shape = shapes[2]},
        {friction = 0.3, shape = shapes[3]},
        {friction = 0.3, shape = shapes[4]},
        {friction = 0.3, shape = shapes[5]},
        {friction = 0.3, shape = blocks[1]},
        {friction = 0.3, shape = blocks[2]},
        {friction = 0.3, shape = blocks[3]},
        {friction = 0.3, shape = blocks[4]},
        {friction = 0.3, shape = blocks[5]},
        {friction = 0.3, shape = blocks[6]},
        {friction = 0.3, shape = blocks[7]},
        {friction = 0.3, shape = blocks[8]},
        {friction = 0.3, shape = blocks[9]},
        {friction = 0.3, shape = blocks[10]},
        {friction = 0.3, shape = blocks[11]},
        {friction = 0.3, shape = blocks[12]},
        {friction = 0.3, shape = blocks[13]},
        {friction = 0.3, shape = blocks[14]},
        {friction = 0.3, shape = blocks[15]},
        {friction = 0.3, shape = bars[1]},
        {friction = 0.3, shape = bars[2]},
        {friction = 0.3, shape = bars[3]},
        {friction = 0.3, shape = bars[4]}
    )

    -- hero
    physics.addBody(bomberman, {density = 3.0, friction = 0.0})

    -- enemies
    physics.addBody(enemy1, {radius = enemy1Radio},
                    {density = 3.0, friction = 0.0})
    physics.addBody(enemy2, {density = 3.0, friction = 0.0})

    physics.addBody(ganar, {density = 3.0, friction = 0.0})
    -- names
    bomberman.name = "Bomberman"
    bomberman.isFixedRotation = true
    bomberman.angularVelocity = 0
    enemy1.name = "Enemy1"
    enemy1.isFixedRotation = true
    enemy1.angularVelocity = 0
    enemy2.name = "Enemy2"
    enemy2.isFixedRotation = true
    enemy2.angularVelocity = 0
    grass.name = "Wall"
    ganar.name = "Ganar"

    -- all display objects must be inserted into group
    sceneGroup:insert(background)
    sceneGroup:insert(enemy1)
    sceneGroup:insert(enemy2)
    sceneGroup:insert(bomberman)
    sceneGroup:insert(grass)
    sceneGroup:insert(backgroundControl)
    sceneGroup:insert(ganar)

end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then

        -- Called when the scene is still off screen and is about to move on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
        function choque(self, event)
            print(event.phase)

            if (event.phase == "began") then
                print(self.name .. " choca " .. event.other.name)
                if event.other.name == "Enemy1" then
                    transition.to(bomberman, {time = 1, x = 20, y = 25})
                    print('Cambio')
                elseif event.other.name == "Enemy2" then
                    transition.to(bomberman, {time = 1, x = 20, y = 25})
                    print('Cambio2')
                elseif event.other.name == "Ganar" then
                    print("Entra")
                    -- composer.gotoScene( "level2", "fade", 500 )
                    timer.performWithDelay(1000, onbtnGanarRelease, 1)
                    print('Cambio3')
                end
            elseif (event.phase == "ended") then
                
                    -- elseif event.other.name == "Ganar" then
                    --     print("Entra")
                    --     composer.gotoScene( "level2", "fade", 500 )
                    --     print('Cambio3')
                -- end
            end
        end
        
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc.
        -- local backgroundMusic = audio.loadStream( "theme.mp3" )
        -- local backgroundMusicChannel = audio.play( backgroundMusic, { channel = 1, loops = -1 } )
        timer.performWithDelay(10, moveEnemy1, -1)
        timer.performWithDelay(10, moveEnemy2, -1)
        timer.performWithDelay(1, moveControlRight, -1)
        timer.performWithDelay(1, moveControlLeft, -1)
        timer.performWithDelay(1, moveControlUp, -1)
        timer.performWithDelay(1, moveControlDown, -1)

        bomberman.collision = choque
        bomberman:addEventListener("collision", bomberman)

        -- bomberman.collision = fganar
        bomberman:addEventListener("collision", bomberman)

        physics.setDrawMode("hybrid")
        physics.setGravity(0, 0)
        physics.start()
    end
end

function scene:hide(event)
    local sceneGroup = self.view

    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
        -- physics.stop()
    elseif phase == "did" then
        -- Called when the scene is now off screen
        physics.pause()
    end
end

function scene:destroy(event)

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc.

    local sceneGroup = self.view
    -- physics.stop()
    
    package.loaded[physics] = nil
    physics = nil

    if ganar then
        ganar:removeSelf() -- widgets must be manually removed
        ganar = nil
    end

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

-----------------------------------------------------------------------------------------

return scene
