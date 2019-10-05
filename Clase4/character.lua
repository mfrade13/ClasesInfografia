module(..., package.seeall)


local character = {}

function new_character(params)
 	
 	local character =  display.newImageRect(""..params.name.. ".png", 80, 80 )
 	character.name = params.name
 	character.x = params.x
 	character.y = params.y
 	character.canBlink = true
 	character.jumpX = character.x
 	character.jumpY = character.y

 	function rechargeBlink(  )
 		character.canBlink = true
 	end

 	function fadeIn(  )
 		transition.to(character, {alpha=1,time = 1000, onComplete=rechargeBlink })
 		move()
 	end
 	function move( )
 		character.x, character.y = character.jumpX, character.jumpY
 	end

 	function fadeOut(   )
 		character.canBlink = false
 		transition.to(character, {alpha = 0, time = 1000, onComplete= fadeIn})
 	end

 	function character:blink( event )
 		if character.canBlink then
 			fadeOut()
 			self.jumpX = event.x
 			self.jumpY = event.y
	 	end
 	end

 	return character
 end 
