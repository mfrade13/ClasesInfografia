width  = display.contentWidth
height = display.contentHeight
display.setDefault( "background", 0,0,0,0)
display.setStatusBar(display.HiddenStatusBar)


--Menu Principal
function menuP()
	local buttonE = display.newRoundedRect( width/2, height/1.1, 160, 50, 10 )
	local buttonM = display.newRoundedRect( width/2, height/1.3, 160, 50, 10 ) 
	local buttonH = display.newRoundedRect( width/2, height/1.60, 160, 50, 10 )  
	local eText = display.newText( "Easy", width/2, height/1.1, native.systemFontBold, 25) 
	local mText = display.newText( "Medium", width/2, height/1.3, native.systemFontBold, 25) 
	local hText = display.newText( "Hard", width/2, height/1.60, native.systemFontBold, 25) 
	local img1 = display.newImageRect("menu.jpg", 300, 200 )
	img1.x = display.contentWidth / 2
	img1.y = display.contentHeight / 5
	buttonE:setFillColor( 0.16,0.16,0.16)
	buttonM:setFillColor( 0.16,0.16,0.16)
	buttonH:setFillColor( 0.16,0.16,0.16)
	--Event listener
	buttonE:addEventListener( "tap", beginGameE)
	buttonM:addEventListener( "tap", beginGameM)
	buttonH:addEventListener( "tap", beginGameH)

	welcomeGroup = display.newGroup()
	welcomeGroup:insert( 1, img1)
	welcomeGroup:insert( 2, buttonE)
	welcomeGroup:insert( 3, buttonM)
	welcomeGroup:insert( 4, buttonH)
	welcomeGroup:insert( 5, eText)
	welcomeGroup:insert( 6, mText)
	welcomeGroup:insert( 7, hText)
end

function beginGameE(event)
	welcomeGroup.isVisible = false
	drawRectE()
	return true
end

function beginGameM(event)
	welcomeGroup.isVisible = false
	drawRectM()
	return true
end

function beginGameH(event)
	welcomeGroup.isVisible = false
	drawRectH()
	return true
end




--tabla
gap = 10
puntajebarGap =0
rectH = (height-3*gap-puntajebarGap)/4
rectW = (width-2*gap)/3
rectTable = {}
local index=1
for i=1,4 do
	for j=1,3 do
		rectTable[index] = {}
		rectTable[index]["x"] = rectW/2 + (j-1)*(rectW + 10)
		rectTable[index]["y"] = rectH/2 + (i-1)*(rectH + 10)
		index = index + 1
	end
end
rectHM = (height-3*gap-puntajebarGap)/4
rectWM = (width-2*gap)/3
rectTableM = {}
local indexM=1
for i=1,12 do
	for j=1,3 do
		rectTableM[indexM] = {}
		rectTableM[indexM]["x"] = rectWM/2 + (j-1)*(rectWM + 10)
		rectTableM[indexM]["y"] = rectHM/2 + (i-1)*(rectHM + 10)
		indexM = indexM + 1
	end
end

rectHH = (height-3*gap-puntajebarGap)/4
rectWH = (width-2*gap)/3
rectTableH = {}
local indexH=1
for i=1,18 do
	for j=1,3 do
		rectTableH[indexH] = {}
		rectTableH[indexH]["x"] = rectWH/2 + (j-1)*(rectWH + 10)
		rectTableH[indexH]["y"] = rectHH/2 + (i-1)*(rectHH + 10)
		indexH = indexH + 1
	end
end



function drawRectE()
	inGameGroup = display.newGroup()
	local imgs = {1,1,2,2,3,3,4,4,5,5,6,6}
	previousSelection = -1
	previousTarget = nil
	previousName = -1
	intentos = 0
	puntaje = 0
	imgRest = 12
	for i=1,12 do
		local rect = display.newRect( rectTable[i]["x"], rectTable[i]["y"], rectW, rectH )
		rect:setFillColor(255/255,1/255,6/255)
		local imgsLen = table.getn(imgs)
		local randomIndex = math.random(1,imgsLen)
		local shape = imgs[randomIndex]
		table.remove(imgs, randomIndex)
		rect.selectedIndex = shape
		rect.name = i
		rect:addEventListener( "touch", imgPresionada )
		inGameGroup:insert( i, rect)
	end
	--Tiempo
	local tText = display.newText( "Time:", 25,-25,native.systemFontBold,20)
	tText:setFillColor( 1,1,1 )
	inGameGroup:insert(tText)
	timerText = display.newText( "00", 80,-25,native.systemFontBold,20)
	timerText:setFillColor( 1,1,1 )
	inGameGroup:insert(timerText)
	timeKeeper = timer.performWithDelay( 1000, 
	function ()
		timerText.text = timerText.text + 1;
	end,0)

end

function drawRectM()
	inGameGroupM = display.newGroup()
	local imgs = {1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12}
	previousSelection = -1
	previousTarget = nil
	previousName = -1
	intentos = 0
	puntaje = 0
	imgRest = 24
	for i=1,24 do
		local rectM = display.newRect( rectTableM[i]["x"], rectTableM[i]["y"], rectWM, rectHM )
		rectM:setFillColor(255/255,1/255,6/255)
		local imgsLen = table.getn(imgs)
		local randomIndex = math.random(1,imgsLen)
		local shape = imgs[randomIndex]
		table.remove(imgs, randomIndex)
		rectM.selectedIndex = shape
		rectM.name = i
		rectM:addEventListener( "touch", imgPresionada )
		inGameGroupM:insert( i, rectM)
	end
	--Tiempo
	local tText = display.newText( "Time:", 25,-25,native.systemFontBold,20)
	tText:setFillColor( 1,1,1 )
	inGameGroupM:insert(tText)
	timerText = display.newText( "00", 80,-25,native.systemFontBold,20)
	timerText:setFillColor( 1,1,1 )
	inGameGroupM:insert(timerText)
	timeKeeper = timer.performWithDelay( 1000, 
	function ()
		timerText.text = timerText.text + 1;
	end,0)

end

function drawRectH()
	inGameGroup = display.newGroup()
	local imgs = {1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15,16,16,17,17,18,18}
	previousSelection = -1
	previousTarget = nil
	previousName = -1
	intentos = 0
	puntaje = 0
	imgRest = 32
	for i=1,32 do
		local rectH = display.newRect( rectTableH[i]["x"], rectTableH[i]["y"], rectWH, rectHH )
		rectH:setFillColor(255/255,1/255,6/255)
		local imgsLen = table.getn(imgs)
		local randomIndex = math.random(1,imgsLen)
		local shape = imgs[randomIndex]
		table.remove(imgs, randomIndex)
		rectH.selectedIndex = shape
		rectH.name = i
		rectH:addEventListener( "touch", imgPresionada )
		inGameGroup:insert( i, rectH)
	end
	--Tiempo
	local tText = display.newText( "Time:", 25,-25,native.systemFontBold,20)
	tText:setFillColor( 1,1,1 )
	inGameGroup:insert(tText)
	timerText = display.newText( "00", 80,-25,native.systemFontBold,20)
	timerText:setFillColor( 1,1,1 )
	inGameGroup:insert(timerText)
	timeKeeper = timer.performWithDelay( 1000, 
	function ()
		timerText.text = timerText.text + 1;
	end,0)

end
--Logica de juego
function imgPresionada(event)
	if("began" == event.phase and imgRest > 0) then
		local clickedIndex = event.target.selectedIndex
		local clickedName = event.target.name
		local fname = clickedIndex..".png"	
		if (clickedIndex == previousSelection and previousName ~= clickedName) then
			event.target.fill = { type = "image",filename = fname}
			local to_remove = previousTarget
			previousSelection = -1
			previousName = -1
			previousTarget = nil
			puntaje = puntaje + 1
			imgRest = imgRest - 2
			local pauseT = timer.performWithDelay(500,
			function ()
				event.target:removeSelf()
				to_remove:removeSelf()
				pantallaFinal(imgRest, intentos)
			end,1)

		else 
			event.target.fill = { type = "image",filename = fname}
			if (previousSelection > -1) then
				previousTarget.fill = {255/255,0/255,0/255}
			end
			previousSelection = clickedIndex
			previousName = clickedName
			previousTarget = event.target
			intentos = intentos + 1
		end
	end
end

function pantallaFinal(imgRest, intentos)
	if(imgRest == 0) then
		inGameGroup.isVisible = false
		local msg = "Ganaste\n           \nTiempo: " .. timerText.text .." segundos"
		local tText = display.newText( msg,width/2,height/2,native.systemFontBold,20)
		tText:setFillColor( 1,1,1 )
		local holdTime = timer.performWithDelay(2000,
		function ()
			timer.cancel(timeKeeper)
			tText:removeSelf()
			welcomeGroup:removeSelf()
			inGameGroup:removeSelf()
			menuP()
		end,1)
	end
end


menuP()

