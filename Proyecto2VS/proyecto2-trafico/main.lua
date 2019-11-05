-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--local auto = require('auto')

local physics = require('physics')

local widget = require('widget')

-- Constantes de dimension de pantalla
local _W = display.contentWidth
local _H = display.contentHeight
print(_W.." ".._H)


local aux = 1

local group = display.newGroup()
local autosGroup = display.newGroup()

physics.start()
--physics.pause()


physics.setDrawMode( "hybrid" )
--background
local background = display.newImageRect("calles-background-grande.png",_W,_H)
background.anchorX = 0
background.anchorY = 0
--physics.addBody( background, "static", {isSensor=true, friction=0.5 ,shape={-_W/2,-_H/2, _W/2,-_H/2, -_W/2,_H/2, _W/2,_H/2}} )

local top = display.newRect( _W/2, 2, _W, 2 )
physics.addBody(top, "static", {shape={-_W/2,-1, _W/2,-1, -_W/2,1, _W/2,1}})
local bottom = display.newRect( _W/2, _H-2, _W, 2 )
physics.addBody(bottom, "static", {shape={-_W/2,-1, _W/2,-1, -_W/2,1, _W/2,1}})
local izquierda = display.newRect( 2, _H/2, 2, _H )
physics.addBody(izquierda, "static", {shape={-1,-_H/2, 1,-_H/2, -1,_H/2, 1,_H/2}})
local derecha = display.newRect( _W, _H/2, 2, _H )
physics.addBody(derecha, "static", {shape={-1,-_H/2, 1,-_H/2, -1,_H/2, 1,_H/2}})
top.name, bottom.name, izquierda.name, derecha.name = "wall","wall","wall","wall"


local cuadraShape = {-55,-55, 55,-55, 55,55, -55,55}
local cuadra1 = display.newPolygon(55,58,cuadraShape)
physics.addBody( cuadra1, "static",{shape=cuadraShape, isSensor=true, friction=0.9} )
local cuadra2 = display.newPolygon(240,58,cuadraShape)
physics.addBody( cuadra2, "static",{shape=cuadraShape, isSensor=true} )
local cuadra3 = display.newPolygon(_W-55,58,cuadraShape)
physics.addBody( cuadra3, "static",{shape=cuadraShape, isSensor=true} )
local cuadra4 = display.newPolygon(55,_H-60,cuadraShape)
physics.addBody( cuadra4, "static",{shape=cuadraShape, isSensor=true} )
local cuadra5 = display.newPolygon(240,_H-60,cuadraShape)
physics.addBody( cuadra5, "static",{shape=cuadraShape, isSensor=true} )
local cuadra6 = display.newPolygon(_W-55,_H-60,cuadraShape)
physics.addBody( cuadra6, "static",{shape=cuadraShape, isSensor=true} )
cuadra1.name, cuadra2.name, cuadra3.name, cuadra4.name, cuadra5.name, cuadra6.name = "cuadra","cuadra","cuadra","cuadra","cuadra","cuadra"


local pasoZebraXShape = { -3,-23, 3,-23, 3,23, -3,23 }
local pasoZebra1 = display.newPolygon( _W/3-57, _H/2, pasoZebraXShape )
pasoZebra1.name = "pasoZebra1"
local pasoZebra2 = display.newPolygon( _W/3+31, _H/2, pasoZebraXShape )
pasoZebra2.name = "pasoZebra2"
local pasoZebra3 = display.newPolygon( 2*_W/3-31, _H/2, pasoZebraXShape )
pasoZebra3.name = "pasoZebra3"
local pasoZebra4 = display.newPolygon( 2*_W/3+57, _H/2, pasoZebraXShape )
pasoZebra4.name = "pasoZebra4"
physics.addBody( pasoZebra1, "static", { shape=pasoZebraXShape, isSensor=true } )
physics.addBody( pasoZebra2, "static", { shape=pasoZebraXShape, isSensor=true } )
physics.addBody( pasoZebra3, "static", { shape=pasoZebraXShape, isSensor=true } )
physics.addBody( pasoZebra4, "static", { shape=pasoZebraXShape, isSensor=true } )

local pasoZebraYShape = { -20,-3, 20,-3, 20,3, -20,3 }
local pasoZebra5 = display.newPolygon( _W/3-13, _H/2-53, pasoZebraYShape )
pasoZebra5.name = "pasoZebra5"
local pasoZebra6 = display.newPolygon( _W/3-13, _H/2+53, pasoZebraYShape )
pasoZebra6.name = "pasoZebra6"
local pasoZebra7 = display.newPolygon( 2*_W/3+13, _H/2-53, pasoZebraYShape )
pasoZebra7.name = "pasoZebra7"
local pasoZebra8 = display.newPolygon( 2*_W/3+13, _H/2+53, pasoZebraYShape )
pasoZebra8.name = "pasoZebra8"
physics.addBody( pasoZebra5, "static", { shape=pasoZebraYShape, isSensor=true } )
physics.addBody( pasoZebra6, "static", { shape=pasoZebraYShape, isSensor=true } )
physics.addBody( pasoZebra7, "static", { shape=pasoZebraYShape, isSensor=true } )
physics.addBody( pasoZebra8, "static", { shape=pasoZebraYShape, isSensor=true } )


---Semaforos
local semaforo1 = display.newImageRect("semaforoH-verde.png", 35,20)
semaforo1.x = _W/3-10
semaforo1.y = _H/2-15

local semaforo2 = display.newImageRect("semaforoH-verde.png", 35,20)
semaforo2.x = 2*_W/3+17
semaforo2.y = _H/2-15

local semaforo3 = display.newImageRect("semaforoV-rojo.png", 19,34)
semaforo3.x = _W/3
semaforo3.y = _H/2+15

local semaforo4 = display.newImageRect("semaforoV-rojo.png", 19,34)
semaforo4.x = 2*_W/3+25
semaforo4.y = _H/2+15


---Autos
physics.setGravity( 0, 0 )

local autos = {}


--no olvidar: isVisible = false, width y height (20, 40) depende la direccion
local xi, yi, xd, yd = 30, _H/2+13, _W-30, _H/2-15
local x1a, y1a, x1ab, y1ab, x2a, y2a, x2ab, y2ab = _W/3-23, 25 ,_W/3-2, _H-25, 2*_W/3+3, 25, 2*_W/3+24, _H-25
local attAutos = {
	{img="spritesheet_auto1i.jpg", x=xd, y=yd, name="auto",direccion="izq",vx=-80,vy=0},
	{img="spritesheet_auto2d.jpg", x=xi, y=yi, name="auto",direccion="der",vx=70,vy=0},
	{img="spritesheet_auto3a.jpg", x=x1ab, y=y1ab, name="auto",direccion="arr",vx=0,vy=-70},
	{img="spritesheet_auto4a.jpg", x=x2ab, y=y2ab, name="auto",direccion="arr",vx=0,vy=-60},
	{img="spritesheet_auto5ab.jpg", x=x1a, y=y1a, name="auto",direccion="aba",vx=0,vy=70},
	{img="spritesheet_auto6ab.jpg", x=x2a, y=y2a, name="auto",direccion="aba",vx=0,vy=50},
	{img="spritesheet_auto2i.jpg", x=xd, y=yd, name="auto",direccion="izq",vx=-50,vy=0},
	{img="spritesheet_auto3d.jpg", x=xi, y=yi, name="auto",direccion="der",vx=50,vy=0},
	{img="spritesheet_auto4a.jpg", x=x1ab, y=y1ab, name="auto",direccion="arr",vx=0,vy=-60},
	{img="spritesheet_auto5a.jpg", x=x2ab, y=y2ab, name="auto",direccion="arr",vx=0,vy=-60},
	{img="spritesheet_auto6ab.jpg", x=x1a, y=y1a, name="auto",direccion="aba",vx=0,vy=50},
	{img="spritesheet_auto1ab.jpg", x=x2a, y=y2a, name="auto",direccion="aba",vx=0,vy=40},
	{img="spritesheet_auto3i.jpg", x=xd, y=yd, name="auto",direccion="izq",vx=-70,vy=0},
	{img="spritesheet_auto4d.jpg", x=xi, y=yi, name="auto",direccion="der",vx=55,vy=0},
	{img="spritesheet_auto5a.jpg", x=x1ab, y=y1ab, name="auto",direccion="arr",vx=0,vy=-45},
	{img="spritesheet_auto6a.jpg", x=x2ab, y=y2ab, name="auto",direccion="arr",vx=0,vy=-55},
	{img="spritesheet_auto1ab.jpg", x=x1a, y=y1a, name="auto",direccion="aba",vx=0,vy=65},
	{img="spritesheet_auto2ab.jpg", x=x2a, y=y2a, name="auto",direccion="aba",vx=0,vy=40},
	{img="spritesheet_auto4i.jpg", x=xd, y=yd, name="auto",direccion="izq",vx=-50,vy=0},
	{img="spritesheet_auto5d.jpg", x=xi, y=yi, name="auto",direccion="der",vx=70,vy=0},
	{img="spritesheet_auto6a.jpg", x=x1ab, y=y1ab, name="auto",direccion="arr",vx=0,vy=-30},
	{img="spritesheet_auto1a.jpg", x=x2ab, y=y2ab, name="auto",direccion="arr",vx=0,vy=-60},
	{img="spritesheet_auto2ab.jpg", x=x1a, y=y1a, name="auto",direccion="aba",vx=0,vy=70},
	{img="spritesheet_auto3ab.jpg", x=x2a, y=y2a, name="auto",direccion="aba",vx=0,vy=50},
	{img="spritesheet_auto5i.jpg", x=xd, y=yd, name="auto",direccion="izq",vx=-45,vy=0},
	{img="spritesheet_auto6d.jpg", x=xi, y=yi, name="auto",direccion="der",vx=60,vy=0},
	{img="spritesheet_auto1a.jpg", x=x1ab, y=y1ab, name="auto",direccion="arr",vx=0,vy=-40},
	{img="spritesheet_auto2a.jpg", x=x2ab, y=y2ab, name="auto",direccion="arr",vx=0,vy=-30},
	{img="spritesheet_auto3ab.jpg", x=x1a, y=y1a, name="auto",direccion="aba",vx=0,vy=40},
	{img="spritesheet_auto4ab.jpg", x=x2a, y=y2a, name="auto",direccion="aba",vx=0,vy=50}
}




group:insert(1,background)
group:insert(3,semaforo1)
group:insert(3,semaforo2)
group:insert(3,semaforo3)
group:insert(3,semaforo4)
group:insert(2,autosGroup)
group:insert(1,pasoZebra1)
group:insert(1,pasoZebra2)
group:insert(1,pasoZebra3)
group:insert(1,pasoZebra4)
group:insert(1,pasoZebra5)
group:insert(1,pasoZebra6)
group:insert(1,pasoZebra7)
group:insert(1,pasoZebra8)
group:insert(1,top)
group:insert(1,bottom)
group:insert(1,izquierda)
group:insert(1,derecha)
group:insert(1,cuadra1)
group:insert(1,cuadra2)
group:insert(1,cuadra3)
group:insert(1,cuadra4)
group:insert(1,cuadra5)
group:insert(1,cuadra6)
group.isVisible = true




---SEMAFORO
local colorSH = "verde"
function cambiarImagenH(newColor)
	colorSH = newColor
	--print( "cambiando imagen a "..newColor )
	group:remove(semaforo1)
	display.remove( semaforo1 )
	semaforo1 = display.newImageRect(group,"semaforoH-"..newColor..".png", 35,20)
	semaforo1.x = _W/3-10
	semaforo1.y = _H/2-15
	group:insert(semaforo1)
	group:remove(semaforo2)
	display.remove( semaforo2 )
	semaforo2 = display.newImageRect(group,"semaforoH-"..newColor..".png", 35,20)
	semaforo2.x = 2*_W/3+17
	semaforo2.y = _H/2-15
	group:insert(semaforo2)
end


function cambiarVerdeH( )
	cambiarImagenH("verde")
end
function cambiarAmarilloH( )
	cambiarImagenH("amarillo")
end
function cambiarRojoH( )
	cambiarImagenH("rojo")
end

function cambiarSemaforoH()
	--print( "Estoy cambiando semaforo" )
	cambiarVerdeH()	
	transition.to(aux,{time=3000, onComplete=cambiarAmarilloH})
	transition.to(aux,{delay=3000,time=2000, onComplete=cambiarRojoH})
end

cambiarSemaforoH()
local timerSH = timer.performWithDelay( 10000, cambiarSemaforoH,-1 )

local colorSV = "rojo"
function cambiarImagenV(newColor)
	colorSV = newColor
	--print( "cambiando imagen a "..newColor )
	group:remove(semaforo3)
	display.remove( semaforo3 )
	semaforo3 = display.newImageRect(group,"semaforoV-"..newColor..".png", 19,34)
	semaforo3.x = _W/3
	semaforo3.y = _H/2+15
	group:insert(semaforo3)
	group:remove(semaforo4)
	display.remove( semaforo4 )
	semaforo4 = display.newImageRect(group,"semaforoV-"..newColor..".png", 19,34)
	semaforo4.x = 2*_W/3+25
	semaforo4.y = _H/2+15
	group:insert(semaforo4)
end


function cambiarVerdeV( )
	cambiarImagenV("verde")
end
function cambiarAmarilloV( )
	cambiarImagenV("amarillo")
end
function cambiarRojoV( )
	cambiarImagenV("rojo")
end

function cambiarSemaforoV()
	--print( "Estoy cambiando semaforo" )
	cambiarRojoV()	
	transition.to(aux,{time=5000, onComplete=cambiarVerdeV})
	transition.to(aux,{delay=4000,time=3000, onComplete=cambiarAmarilloV})
end

cambiarSemaforoV()
local timerv = timer.performWithDelay( 10000, cambiarSemaforoV,-1 )


--AUTO

--en X
function identificarAccionX( )
	local c = colorSH
	local ac = "mover"
	if(c == "rojo")  then
	ac = "detener"
	elseif(c == "amarillo") then
		ac = "frenar"
	end
	--print("X: "..c.." - "..ac)
	return ac
end


function choqueX(self, event)
	local phase = event.phase
		--print("collision can jump state", crate.canJump)

	if phase == "began" then
		--print("Yo " .. self.name  ..  " me estoy chocando con " .. event.other.name )
		if self.direccion == "izq" and (event.other.name == "pasoZebra2" or event.other.name == "pasoZebra4") then
			self.inCollision = true
			print("collision true")
		elseif self.direccion == "der" and (event.other.name == "pasoZebra1" or event.other.name == "pasoZebra3") then
			self.inCollision = true
			print("collision true")
		elseif event.other.name == "auto" and event.other.isVisible then
			self.inCollision = true
			self.finish = true
			self:setFrame( 2 )
			event.other:setFrame( 2 )
		elseif event.other.name == "wall" and event.other.y >= 115 and event.other.y <= _H-115 then
			self.isVisible = false
			self.isSensor = true
			self.inCollision = true
			self.finish = true
			print( "collision wall" )
		end

	elseif phase == "ended" then
		self.inCollision = false
		print('me choque con '.. event.other.name)
	end
end

	

function moverEnXP(autox, i)
	--autox:applyLinearImpulse( -0.03, 0, autox.x, autox.y )
	if(autox.inCollision) then
		local accion = identificarAccionX()
		if(accion == "detener") then
			autox:setLinearVelocity( 0, 0 )
		elseif(accion == "frenar") then
			autox.linearDamping = 10
		else
			autox:setLinearVelocity( attAutos[i].vx, attAutos[i].vy )
			autox.linearDamping = 0	
			--print("Se mueve")
		end
	else
		autox:setLinearVelocity( attAutos[i].vx, attAutos[i].vy )
		autox.linearDamping = 0	
		print("collision false")
	end
	
		--if(autox.x <= 20) then
		--	autox.isVisible = false
		--end
	
end


--en Y
function identificarAccionY( )
	local c = colorSV
	local ac = "mover"
	if(c == "rojo")  then
		ac = "detener"
	elseif(c == "amarillo") then
		ac = "frenar"
	end
	--print("Y: "..c.." - "..ac)
	return ac
end

function choqueY(self, event)
	local phase = event.phase
		--print("collision can jump state", crate.canJump)

	if phase == "began" then
		--print("Yo " .. self.name  ..  " me estoy chocando con " .. event.other.name )
		if self.direccion == "arr" and (event.other.name == "pasoZebra6" or event.other.name == "pasoZebra8") then
			self.inCollision = true
			print("collision true")
		elseif self.direccion == "aba" and (event.other.name == "pasoZebra5" or event.other.name == "pasoZebra7") then
			self.inCollision = true
			print("collision true")
		elseif event.other.name == "auto" and event.other.isVisible then
			self.inCollision = true
			self.finish = true
			self:setFrame( 2 )
			event.other:setFrame( 2 )
		elseif event.other.name == "wall" and (event.other.x >= 115 and event.other.x <= 180 or event.other.x >= 200 and event.other.x <= 265) then
			self.isVisible = false
			self.isSensor = true
			self.inCollision = true
			self.finish = true
			print( "collision wall" )
		end

	elseif phase == "ended" then
		self.inCollision = false
		print('me choque con '.. event.other.name)
	end
end


function moverEnYP(autoy, i)
	--print("Se mueve")
	--autoy:applyLinearImpulse( 0, -0.03, autoy.x, autoy.y )
	--autoy:setLinearVelocity( 0,-80 )
	if(autoy.inCollision) then
		local accion = identificarAccionY()
		if(accion == "detener") then
			autoy:setLinearVelocity( 0, 0 )
		elseif(accion == "frenar") then
			autoy.linearDamping = 10
		else
			autoy:setLinearVelocity( attAutos[i].vx, attAutos[i].vy )
			autoy.linearDamping = 0	
			--print("Se mueve")
		end
	else
		autoy:setLinearVelocity( attAutos[i].vx, attAutos[i].vy )
		autoy.linearDamping = 0	
		print("collision false")
	end
	
end



local tanda = 0
function moverX( )
	for i=1,tanda*6 do
		local pos = i
		if (not autos[pos].finish and (autos[pos].direccion == "der" or autos[pos].direccion == "izq")) then
			autos[pos].isSensor = false
			autos[pos].isVisible = true
			moverEnXP(autos[pos],pos)
		end
	end
end

function moverY( )	
	for i=1,tanda*6 do
		local pos = i
		print( tanda .. "*****************".. pos .."***************" )
		if (not autos[pos].finish and (autos[pos].direccion == "arr" or autos[pos].direccion == "aba")) then
			autos[pos].isSensor = false
			autos[pos].isVisible = true
			moverEnYP(autos[pos],pos)
		end
	end
end

function lanzarAutos( )
	if (tanda+1)*6 <= #attAutos then
		for i=6*tanda+1,#attAutos do
			local w = 40
			local h = 22
			local c = choqueX
			local autoShape = {-20,-10, 20,-10, -20,10, 20,10}
			if(attAutos[i].direccion == "arr" or attAutos[i].direccion == "aba") then
				w = 20
				h = 39
				c = choqueY
				autoShape = {-10,-20, 10,-20, -10,20, 10,20}
			end
			--local autoSheet = graphics.newImageSheet( "spritesheet_auto2d.jpg", {width=40, height=22, numFrames=2} )
			local autoSheet = graphics.newImageSheet( attAutos[i].img, {width=w, height=h, numFrames=2} )

			--autos[i] = display.newImageRect(attAutos[i].img, w, h)
			autos[i] = display.newSprite( autoSheet, {start=1, count=2, time=1000, loopCount=1} )
			autos[i].x = attAutos[i].x
			autos[i].y = attAutos[i].y
			--autos[i].xScale = 0.2
			--autos[i].yScale = 0.75
			autos[i]:setFrame( 1 )
			autos[i].completeName = attAutos[i].completeName
			autos[i].name = attAutos[i].name
			autos[i].direccion = attAutos[i].direccion
			autos[i].inCollision = false
			autos[i].isVisible = false
			autos[i].finish = false
			
			--autoOutline = graphics.newOutline( 2, attAutos[i].img )
			--physics.addBody( autos[i], "dynamic",{ outline=autoOutline, isSensor=true } )
			physics.addBody(autos[i],"dynamic", {isSensor=true,shape=autoShape})
			autos[i].collision = c
			autos[i]:addEventListener( "collision", autos[i] )

			autosGroup:insert(autos[i])
		end
		timer.performWithDelay( 300, moverX,-1 )
		timer.performWithDelay( 200, moverY,-1 )
		--timer.performWithDelay( 200, moverY,-1 )
		tanda = tanda+1
	end
end

--funcion touch para el objeto background
local function onBackgroundTouch( event )

	if event.phase == "moved" then
	elseif event.phase == "cancelled" or event.phase == "ended" then
		--timer.performWithDelay( 300, auto1:moverEnX(semaforo1,semaforo2,colorSH),-1 ) --pa clase
		--timer.performWithDelay( 200, auto2:moverEnY(semaforo3,semaforo4,colorSV),-1 ) --pa clase
		lanzarAutos()
		timer.performWithDelay( 10000, lanzarAutos, -1)
		--background:removeEventListener( "touch", background )
	end
	return true
end

--adicionar evento touch a un objeto
--background:addEventListener( "touch", background )


local myButton = widget.newButton(
    {
        width = 70,
        height = 30,
        x = _W/2,
        y = _H/6,
        defaultFile = "default-button.png",
        overFile = "over-button.png",
        label = "INICIAR",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        onRelease = onBackgroundTouch
    }
)
 