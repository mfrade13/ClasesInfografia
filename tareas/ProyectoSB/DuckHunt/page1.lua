-----------------------------------------------------------------------------------------
--
-- page1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- forward declarations and other locals
local background, pageText, continueText, pageTween, fadeTween1, fadeTween2, coronaIcon, dogObj, duckObj, duckV
local sheetDog, DogD, DogD2
local swipeThresh = 100		-- amount of pixels finger must travel to initiate page swipe
local tweenTime = 4000
local animStep = 1
local contador = 1
local readyToContinue = false
local grupoFondo, grupoJugo,grupoObstaculos, grupoPerro, score, rondas, nDucks, shoots, rectangulo
-- function to show next animation
function showNext()
	if readyToContinue then
		readyToContinue = false
		if (animStep == 1) then
			if (contador == 1) then
				DogD:setSequence( "empieza" )
				DogD:play()
				transition.to( DogD, { time=1500, x=90,y=235, onComplete=cAni})
			elseif (contador == 2) then
				DogD:setSequence( "olfate" )
				DogD:play()
				transition.to( DogD, {time=1000, x=90,y=235, onComplete=cAni})
			elseif (contador == 3) then
				DogD:setSequence( "empieza" )
				DogD:play()
				transition.to( DogD, {time=1500, x=120,y=235, onComplete=cAni})
			elseif (contador == 4) then
				DogD:setSequence( "olfate" )
				DogD:play()
				transition.to( DogD, {time=4000, x=120,y=235, onComplete=cAni,onComplete=nextAnimation})
			end	

		elseif (animStep == 2) then
			DogD.isVisible=false
			DogD2.isVisible=false
			dCreado()
			
			
		end
	end
end

function starGame( ... )
	rondas = 1
	shoots = 3
	score = 0
	display.newText( "Shoot= ".. shoots, 50, 0 , Arial , 15 )
	display.newText( "Score= ".. score, 50, 20 , Arial , 15 )
end

local options = {
		width = 59,
		height = 51,
		numFrames = 5
	}
sheetDog = graphics.newImageSheet("dog2.png", options)
sequence={
	{name="empieza",sheet=sheetDog, frames={1,2,3},time = 500,loopCount=4},
	{name="olfate",sheet=sheetDog, frames={4,5},time = 300,loopCount=2}	
}
-- sheetDog2 = graphics.newImageSheet("dog2.png", options)
-- sequence={
-- 	{name="susto",sheet=sheetDog2, frames={1},time = 500,loopCount=2},
-- 	{name="salto",sheet=sheetDog2, frames={2,3},time = 900,loopCount=5},
-- 	{name="risa",sheet=sheetDog2, frames={4,5},time = 900,loopCount=5}
-- }
function cAni( ... )
			contador = contador + 1
			readyToContinue = true
			showNext()
end
function nextAnimation( ... )
			animStep = animStep + 1
			readyToContinue = true
			showNext()
end

-- touch event listener for background object
local function backgroundtouch(event)
	local phase = event.phase
	if (phase == "began") then
		local sound = audio.loadStream("Gunshot.mp3")
		audio.play(sound)
		
	end
	return true	
end
local function shoot(event)
	local phase = event.phase
	if phase == "ended" then
		dMuerto()
		local sound = audio.loadStream("Gunshot.mp3")
		audio.play(sound)
	end
	return true
end

function scene:create( event )
	local sceneGroup = self.view
	grupoFondo = display.newGroup()
	grupoJugo =display.newGroup()
	grupoObstaculos = display.newGroup()
	grupoPerro = display.newGroup()
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	sceneGroup:insert( grupoFondo )
	sceneGroup:insert( grupoJugo )
	sceneGroup:insert( grupoObstaculos)
	-- create background image
	background = display.newImageRect( grupoFondo, "Base.png", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	local startMusic = audio.loadStream("inicio.mp3")
	audio.play(startMusic)
	
	
	-- create overlay
	
	-- create sun, moon, and corona icon
	DogD = display.newSprite(grupoPerro,  sheetDog, sequence)
	DogD.x = 40
	DogD.y = 235
	DogD.xScale = 1.5
	DogD.yScale = 1.5
	-- DogD2 = display.newSprite(grupoPerro,  sheetDog2, sequence)
	-- DogD2.x = 120
	-- DogD2.y = 235
	-- DogD2.xScale = 1.5
	-- DogD2.yScale = 1.5
	-- DogD2.isVisible = true

	duckObj = display.newImageRect( grupoJugo, "duck.png", 45, 45 )
		duckObj.x = 230
		duckObj.y = 230
		duckObj.isVisible = false

	DogD2 = display.newImageRect( grupoPerro, "Dog4.png", 55, 55 )
	DogD2.x = 350
	DogD2.y = 235
	DogD2.isVisible = false
	end

function dCreado( ... )
	duckObj.alpha = 1
	duckObj.isVisible = true
	duckV = true
	transition.to( duckObj, {time=1500, x=math.random( 0,200 ),y=math.random( 0,200 )})
	transition.to( duckObj, {delay = 1500,time=1500, x=math.random( 0,100 ),y=math.random( 0,100 )})
	transition.to( duckObj, {delay = 1500,time=1500, x=math.random( 0,100 ),y=math.random( 0,100 )})
	--transition.to( duckObj, {delay = 1500,time=1500, x=-math.random( 0,200 ),y=-math.random( 0,200 )})
	DogD2.isVisible=false
end	
function dMuerto( ... )
	duckV = false
	-- score = score + 100
	transition.cancel(duckObj)
	transition.to( duckObj, {time=1500, x=230,y=230})
	
	
	-- GameOver()
	Punto()
end
function Punto( ... )
	DogD2.isVisible = true
	duckObj.isVisible=false
	transition.to( DogD2, {time=1500,x=230,y=190} )
	transition.to( DogD2, {delay = 1500,time=1500,x=230,y=235} )
	dCreado()
end

-- function GameOver( ... )
-- 	if (shoot == 0) then
-- 		display.newText( "GameOver", 100, 100 , Arial , 45 )
-- 	end
-- 	-- if (duckObj.event.x < 0  and duckObj.event.y < 0 and duckV == true) then
-- 	-- 	display.newText( "GameOver", 100, 100 , Arial , 45 )
-- 	-- end
-- 	dCreado()
-- end

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


		
		animStep = 1
		readyToContinue = true
		showNext()


	end	
	-- assign touch event to background to monitor page swiping
		
		background:addEventListener("touch",backgroundtouch)
		duckObj:addEventListener("touch",shoot)
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		
		-- hide objects
		
	
		-- remove touch event listener for background
		background:removeEventListener( "touch", background )
	
		-- cancel page animations (if currently active)
		
		
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

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------


return scene