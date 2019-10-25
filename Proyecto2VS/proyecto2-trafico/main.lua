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
physics.addBody( cuadra1, "static",{shape=cuadraShape, isSensor=true} )
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
local attAutos = {
	{img="auto1i.png", x=_W-30, y=_H/2-15, name="auto",direccion="izq",vx=-70,vy=0},
	{img="auto2a.png", x=_W/3-2, y=_H-20, name="auto",direccion="arr",vx=0,vy=-70},
	{img="auto2i.png", x=_W-30, y=_H/2-15, name="auto",direccion="izq",vx=-40,vy=0},
	{img="auto4a.png", x=2*_W/3+24, y=_H-20, name="auto",direccion="arr",vx=0,vy=-40},
	{img="auto3d.png", x=30, y=_H/2+13, name="auto",direccion="der",vx=70,vy=0},
	{img="auto5a.png", x=_W/3-2, y=_H-20, name="auto",direccion="arr",vx=0,vy=-30},
	{img="auto5i.png", x=_W-30, y=_H/2-15, name="auto",direccion="izq",vx=-70,vy=0},
	{img="auto4a.png", x=2*_W/3+24, y=_H-20, name="auto",direccion="arr",vx=0,vy=-50},
	{img="auto6d.png", x=30, y=_H/2+13, name="auto",direccion="der",vx=70,vy=0},
	{img="auto1ab.png", x=2*_W/3+3, y=20, name="auto",direccion="aba",vx=0,vy=50}
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
		elseif event.other.name == "auto" then
			--self.inCollision = true
		elseif event.other.name == "wall" then
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


function moverEnYP(autoy)
	print("Se mueve")
	--autoy:applyLinearImpulse( 0, -0.03, autoy.x, autoy.y )
	autoy:setLinearVelocity( 0,-80 )
end



local tanda = 0
function moverX( )
	if (not autos[1].finish) then
		autos[1].isSensor = false
		autos[1].isVisible = true
		moverEnXP(autos[1],1)
	end

	--auto1.isVisible = true
	--moverEnX(auto1,2000,"izq")
	--auto5.isVisible = true
	--moverEnX(auto5,4000,"der")
	--if(tanda >= 2) then
	--	auto3.isVisible = true
	--	moverEnX(auto3,4000,"izq")
	--end
	--if(tanda >= 3) then
	--	auto7.isVisible = true
--		moverEnX(auto7,5000,"izq")
--		auto9.isVisible = true
--		moverEnX(auto9,5000,"der")
--	end
end

function moverY( )	
	auto2.isVisible = true
	auto4.isVisible = true
	moverEnY(auto2,3500,"arr")
	moverEnY(auto4,6000,"arr")
	if(tanda >= 2) then
		auto6.isVisible = true
		auto10.isVisible = true
		moverEnY(auto6,5000,"arr")
		moverEnY(auto10,4000,"aba")
	end
	if(tanda >= 3) then
		auto8.isVisible = true
		moverEnY(auto8,5000,"arr")
	end
	
end

function lanzarAutos( )
	for i=1,10 do
		local w = 40
		local h = 20
		local c = choqueX
		if(attAutos[i].direccion == "arr" or attAutos[i].direccion == "aba") then
			w = 20
			h = 40
			--c = choqueY
		end
		autos[i] = display.newImageRect(attAutos[i].img, w, h)
		autos[i].x = attAutos[i].x
		autos[i].y = attAutos[i].y
		autos[i].name = attAutos[i].name
		autos[i].direccion = attAutos[i].direccion
		autos[i].inCollision = false
		autos[i].isVisible = false
		autos[i].finish = false
		
		autoOutline = graphics.newOutline( 2, attAutos[i].img )
		physics.addBody( autos[i], "dynamic",{ outline=autoOutline, isSensor=true } )
		autos[i].collision = c
		autos[i]:addEventListener( "collision", autos[i] )

		autosGroup:insert(autos[i])
	end
	timer.performWithDelay( 300, moverX,-1 )
	--timer.performWithDelay( 200, moverY,-1 )
	--timer.performWithDelay( 200, moverY,-1 )
	tanda = tanda+1

end

--funcion touch para el objeto background
local function onBackgroundTouch( event )

	if event.phase == "moved" then
	elseif event.phase == "cancelled" or event.phase == "ended" then
		--timer.performWithDelay( 300, auto1:moverEnX(semaforo1,semaforo2,colorSH),-1 ) --pa clase
		--timer.performWithDelay( 200, auto2:moverEnY(semaforo3,semaforo4,colorSV),-1 ) --pa clase
		lanzarAutos()
		--timer.performWithDelay( 10000, lanzarAutos, -1)
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
 