-----------------------------------------------------------------------------------------
--
-- level2.lua
--
-----------------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene()

-- include Corona's library
local physics = require "physics"
local widget = require("widget")

--------------------------------------------
local bomberman = display.newImageRect("bomberman_front_1.png", 18, 20)
bomberman.x, bomberman.y = 19, 25

local ganar = display.newCircle(19, 70, 10)

local enemy1Side = true -- true -> down; false -> up
local enemy1 = display.newImageRect("enemy2_1.png", 13, 18)
enemy1.x, enemy1.y = 114, 25

local enemy2Side = true -- true -> right; false -> left
local enemy2 = display.newImageRect("enemy2_2.png", 17, 18)
enemy2.x, enemy2.y = 145, 264

local enemy3Side = true -- true -> down; false -> up
local enemy3 = display.newImageRect("enemy2_1.png", 13, 18)
enemy3.x, enemy3.y = 114, 264

local pressingR = false
local pressingL = false
local pressingU = false
local pressingD = false

local frameR = 1
local frameL = 1
local frameU = 1
local frameD = 1

local function onbtnGanarRelease()

    composer.gotoScene("menu", "fade", 500)
    return true
end

function moveEnemy1()
    local y = enemy1.y
    local move = 3
    if enemy1Side then
        if y + move < 138 then
        -- if y + move < 538 then
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
            enemy2.x = x - move
        end
    else
        if x - move > 145 then
            enemy2.x = x - move
        else
            enemy2Side = true
            enemy2.x = x + move
        end
    end
end

function moveEnemy3()
    local y = enemy3.y
    local move = 3
    if enemy3Side then
        if y + move < 264 then
            enemy3.y = y + move
        else
            enemy3Side = false
            enemy3.y = y - move
        end
    else
        if y - move > 155 then
            enemy3.y = y - move
        else
            enemy3Side = true
            enemy3.y = y + move
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
			bomberman.fill = {type = "image", filename = "bomberman_right_2.png"}
			frameR = 2
		elseif frameR == 2 then
			frameR = 1
			bomberman.fill = {type = "image", filename = "bomberman_right_3.png"}
		else
			bomberman.fill = { type = "image", filename = "bomberman_right_1.png" }
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
			bomberman.fill = { type = "image", filename = "bomberman_left_1.png" }
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
			bomberman.fill = { type = "image", filename = "bomberman_back_1.png" }
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
			bomberman.fill = {type = "image", filename = "bomberman_front_2.png"}
			frameD = 2
		elseif frameD == 2 then
			frameD = 1
			bomberman.fill = {type = "image", filename = "bomberman_front_3.png"}
		else
			bomberman.fill = { type = "image", filename = "bomberman_front_1.png" }
		end
    end
end

function scene:create(event)

    local sceneGroup = self.view
    physics.stop()
    physics.start()
    physics.pause()

    local background = display.newImageRect("clear_map_2.png", 320, 288)
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

    -- paredes externas
    local alto = {249, 525, 525, 525, 525}
    local bajo = {237, 513, 237, 237, 513}
    local derecha = {320, 253, 7, 320, 320}
    local izquierda = {1, 1, 1, 313, 303}

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
        489, 489, 441, 441, 441, 441, 393, 393, 393, 393, 344, 344, 344, 344,
        296, 296, 296, 296, 513, 413, 317, 513, 513 
    }
    local blockDowns = {
        465, 465, 417, 417, 417, 417, 369, 369, 369, 369, 320, 320, 320, 320,
        273, 273, 273, 273, 445, 348, 249, 465, 465
    }
    local blockLefts = {
        126, 173, 126, 172, 221, 268, 126, 172, 221, 268, 126, 172, 221, 268, 
        126, 172, 221, 268, 31, 31, 31, 221, 303
    }
    local blocksRights = {
        148, 195, 148, 195, 242, 290, 148, 195, 242, 290, 148, 195, 242, 290, 
        148, 195, 242, 290, 102, 102, 102, 253, 313
    }

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
    local buttonRight = widget.newButton({
        width = 40,
        height = 40,
		label = "  ",
		fontSize = 30,
		onPress = pressR,
		onRelease = releaseR,
		x = 115,
		y = 415
	})
	local buttonRight2 = widget.newButton({
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
		print("u")
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

    -- posiciones
    local blocks = {}

    for i = 1, 23 do
        blocks[i] = {
            blockLefts[i], -blockHeights[i], blocksRights[i], -blockHeights[i],
            blocksRights[i], -blockDowns[i], blockLefts[i], -blockDowns[i]
        }
    end

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
        {friction = 0.3, shape = blocks[16]},
        {friction = 0.3, shape = blocks[17]},
        {friction = 0.3, shape = blocks[18]},
        {friction = 0.3, shape = blocks[19]},
        {friction = 0.3, shape = blocks[20]},
        {friction = 0.3, shape = blocks[21]},
        {friction = 0.3, shape = blocks[22]},
        {friction = 0.3, shape = blocks[23]}
    )

    -- hero
    physics.addBody(bomberman, {density = 3.0, friction = 0.0})

    -- enemies
    physics.addBody(enemy1, {density = 3.0, friction = 0.3})
    physics.addBody(enemy2, {density = 3.0, friction = 0.3})
    physics.addBody(enemy3, {density = 3.0, friction = 0.3})
    physics.addBody(ganar, {density = 3.0, friction = 1.0})

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
    enemy3.name = "Enemy3"
    enemy3.isFixedRotation = true
    enemy3.angularVelocity = 0
    grass.name = "Wall"
    ganar.name = "Ganar"

    -- all display objects must be inserted into group
    sceneGroup:insert(background)
    sceneGroup:insert(enemy1)
    sceneGroup:insert(enemy2)
    sceneGroup:insert(enemy3)
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

            if (event.phase == "began") then
                print(self.name .. ": collision began with " .. event.other.name)
                if event.other.name == "Enemy1" then
                    transition.to(bomberman, {time = 1, x = 20, y = 25})
                    print('Cambio')
                elseif event.other.name == "Enemy2" then
                    transition.to(bomberman, {time = 1, x = 20, y = 25})
                    print('Cambio2')
                elseif event.other.name == "Enemy3" then
                    transition.to(bomberman, {time = 1, x = 20, y = 25})
                    print('Cambio3')
                elseif event.other.name == "Ganar" then
                    print("Entra")
                    -- composer.gotoScene( "level2", "fade", 500 )
                    timer.performWithDelay(1000, onbtnGanarRelease, 1)
                    print('Cambio3')
                end

            elseif (event.phase == "ended") then
                
            end
        end
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc.
        -- local backgroundMusic = audio.loadStream( "theme.mp3" )
        -- local backgroundMusicChannel = audio.play( backgroundMusic, { channel = 1, loops = -1 } )
        timer.performWithDelay(50, moveEnemy1, -1)
        timer.performWithDelay(10, moveEnemy2, -1)
        timer.performWithDelay(50, moveEnemy3, -1)
        timer.performWithDelay(1, moveControlRight, -1)
		timer.performWithDelay(1, moveControlLeft, -1)
		timer.performWithDelay(1, moveControlUp, -1)
		timer.performWithDelay(1, moveControlDown, -1)

        bomberman.collision = choque
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
