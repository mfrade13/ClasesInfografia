local widget = require('widget')


--Menu Principal
local screen_adjustment = 1
local menuImg = display.newImage("menu.jpg", true)
menuImg.xScale = ((screen_adjustment  * menuImg.contentWidth)/menuImg.contentWidth)/3
menuImg.yScale = menuImg.xScale
menuImg.x = display.contentWidth / 2
menuImg.y = display.contentHeight / 3


local buttonEasy = widget.newButton{
	id = 'buttonEasy',
	x = display.contentWidth*0.2,
	y = display.contentHeight*0.85,
--	onRelease = onBackgroundTouch,
	width = 100,
	height = 50,
	label = 'Easy',
	fontSize = 25,
	labelColor = {default = {1,0,0}, over = {0,1,0}}
}

local buttonMedium = widget.newButton{
	id = 'buttonMedium',
	x = display.contentWidth*0.5,
	y = display.contentHeight*0.85,
--	onRelease = onBackgroundTouch,
	width = 100,
	height = 50,
	label = 'Medium',
	fontSize = 25,
	labelColor = {default = {1,0,0}, over = {0,1,0}}
}

local buttonHard = widget.newButton{
	id = 'buttonEasy',
	x = display.contentWidth*0.8,
	y = display.contentHeight*0.85,
--	onRelease = onBackgroundTouch,
	width = 100,
	height = 50,
	label = 'Hard',
	fontSize = 25,
	labelColor = {default = {1,0,0}, over = {0,1,0}}
}




--Juego