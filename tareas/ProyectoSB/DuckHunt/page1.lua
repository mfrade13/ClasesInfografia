-----------------------------------------------------------------------------------------
--
-- page1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- forward declarations and other locals
local background, pageText, continueText, pageTween, fadeTween1, fadeTween2, coronaIcon, dogObj, duckObj

local swipeThresh = 100		-- amount of pixels finger must travel to initiate page swipe
local tweenTime = 4000
local animStep = 1
local readyToContinue = false
local grupoFondo, grupoJugo,grupoObstaculos
-- function to show next animation
function showNext()
	if readyToContinue then
		readyToContinue = false

		if (animStep == 1) then
			dogObj.alpha = 1
			dogObj.x = 50
			dogObj.isVisible = true
			transition.to( dogObj, { time=6000, x=210,y=220, onComplete=nextAnimation})
			-- dogObj.isVisible = false
		elseif (animStep == 2) then
			duckObj.alpha = 1
			duckObj.x = 50
			duckObj.isVisible = true
			transition.to( duckObj, { time=3000, x=210,y=0})
			-- dogObj.isVisible = false	
		end
	end
end
function nextAnimation( ... )
			animStep = animStep + 1
			readyToContinue = true
			showNext()
end

-- touch event listener for background object
local function onPageSwipe( self, event )
	local phase = event.phase
	-- if phase == "began" then
	-- 	display.getCurrentStage():setFocus( self )
	-- 	self.isFocus = true
	
	-- elseif self.isFocus then
	-- 	if phase == "ended" or phase == "cancelled" then
			
	-- 		local distance = event.x - event.xStart
	-- 		if distance > swipeThresh then
	-- 			-- SWIPED to right; go back to title page scene
	-- 			composer.gotoScene( "title", "slideRight", 800 )
	-- 		else
	-- 			-- Touch and release; initiate next animation
	-- 			showNext()
	-- 		end
			
	-- 		display.getCurrentStage():setFocus( nil )
	-- 		self.isFocus = nil
	-- 	end
	-- end
	return true
end

function scene:create( event )
	local sceneGroup = self.view
	grupoFondo = display.newGroup()
	grupoJugo =display.newGroup()
	grupoObstaculos = display.newGroup()
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
	local backgroundMusic = audio.loadStream("inicio.mp3")
	audio.play(backgroundMusic)
	
	
	-- create overlay
	
	-- create sun, moon, and corona icon
	dogObj = display.newImageRect( grupoJugo, "dog.png", 75,75)
	dogObj.x = 220
	dogObj.y = 220
	dogObj.isVisible = false

	duckObj = display.newImageRect( grupoJugo, "duck.png", 45, 45 )
	duckObj.x = math.random( 0,300 )
	duckObj.y = 220
	duckObj.isVisible = false
	
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


		
		animStep = 1
		readyToContinue = true
		showNext()


	end	
	-- assign touch event to background to monitor page swiping
		background.touch = onPageSwipe
		background:addEventListener( "touch", background )

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