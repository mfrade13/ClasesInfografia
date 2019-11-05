-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--local auto = require('auto')

local widget = require('widget')

-- Constantes de dimension de pantalla
local _W = display.contentWidth
local _H = display.contentHeight
print(_W.." ".._H)


local aux = 1

local group = display.newGroup()

--PARA CLASE
--local params1 = {
--	img = "auto2",
--	x = _W-30,
--	y = _H/2-15,
--	width = 40,
--	height = 20
--}
--local params2 = {
--	img = "auto4",
--	x = _W/3-2,
--	y = _H-20,
--	width = 20,
--	height = 40
--}

--inicializacion de auto
--local auto1 = auto.new_auto(params1)
--local auto2 = auto.new_auto(params2)

--background
local background = display.newImageRect("calles-background-grande.png",_W,_H)
background.anchorX = 0
background.anchorY = 0


local auto1 = display.newImageRect("auto2.png", 40, 20)
auto1.x = _W-30
auto1.y = _H/2-15
auto1.isVisible = false

local auto2 = display.newImageRect("auto4.png", 20, 40)
auto2.x = _W/3-2
auto2.y = _H-20
auto2.isVisible = false

local auto3 = display.newImageRect("auto9.png", 40, 20)
auto3.x = _W-30
auto3.y = _H/2-15
auto3.isVisible = false

local auto4 = display.newImageRect("auto5.png", 20, 40)
auto4.x = 2*_W/3+24
auto4.y = _H-20
auto4.isVisible = false

local auto5 = display.newImageRect("auto3.png", 40, 20)
auto5.x = 30
auto5.y = _H/2+13
auto5.isVisible = false

local auto6 = display.newImageRect("auto8.png", 20, 40)
auto6.x = _W/3-2
auto6.y = _H-20
auto6.isVisible = false

local auto7 = display.newImageRect("auto6.png", 40, 20)
auto7.x = _W-30
auto7.y = _H/2-15
auto7.isVisible = false

local auto8 = display.newImageRect("auto5.png", 20, 40)
auto8.x = 2*_W/3+24
auto8.y = _H-20
auto8.isVisible = false

local auto9 = display.newImageRect("auto7.png", 40, 20)
auto9.x = 30
auto9.y = _H/2+13
auto9.isVisible = false

local auto10 = display.newImageRect("auto10.png", 20, 40)
auto10.x = 2*_W/3+3
auto10.y = 20
auto10.isVisible = false


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


group:insert(1, background)
group:insert(2,auto1)
group:insert(2,auto2)
group:insert(2,auto3)
group:insert(2,auto4)
group:insert(2,auto5)
group:insert(2,auto6)
group:insert(2,auto7)
group:insert(2,auto8)
group:insert(2,auto9)
group:insert(2,auto10)
group:insert(3, semaforo1)
group:insert(3, semaforo2)
group:insert(3, semaforo3)
group:insert(3, semaforo4)
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
	print("X: "..c.." - "..ac)
	return ac
end

function moverEnX(autox,timeX, dir)
	if(dir == "izq") then 
		transition.to(autox,{x = -20, time = timeX})
		local accion = "mover"
		local sem = 1 --1 izquierda, 2 derecha
		--print(auto1.x .." - "..semaforo1.x.." - "..semaforo2.x)
		if(autox.x >= semaforo1.x + 30 and autox.x <= semaforo1.x + 60) then
			accion = identificarAccionX()
			sem = 1
		end
		if(autox.x >= semaforo2.x + 30 and autox.x <= semaforo2.x + 60) then
			accion = identificarAccionX()
			sem = 2
		end
		if(accion == "detener") then
			transition.cancel( autox )
		elseif(accion == "frenar") then
			if(sem == 1) then
				transition.to(autox,{x = semaforo1.x+40, time=2*timeX})
			elseif(sem == 2) then
				transition.to(autox,{x = semaforo2.x+40, time=2*timeX})
			end
		else
			transition.to(autox,{x = -20, time=timeX})
		end
		if(autox.x <= 20) then
			autox.isVisible = false
		end
	else
		transition.to(autox,{x = _W+20, time = timeX})
		local accion = "mover"
		local sem = 1 --1 izquierda, 2 derecha
		--print(autox.x .." - "..semaforo1.x.." - "..semaforo2.x)
		if(autox.x <= semaforo1.x - 50 and autox.x >= semaforo1.x - 85) then
			accion = identificarAccionX()
			sem = 1
		end
		if(autox.x <= semaforo2.x - 50 and autox.x >= semaforo2.x - 85) then
			accion = identificarAccionX()
			sem = 2
		end
		if(accion == "detener") then
			transition.cancel( autox )
		elseif(accion == "frenar") then
			if(sem == 1) then
				transition.to(autox,{x = semaforo1.x-55, time=2*timeX})
			elseif(sem == 2) then
				transition.to(autox,{x = semaforo2.x-55, time=2*timeX})
			end
		else
			transition.to(autox,{x = _W+20, time=timeX})
		end
		if(autox.x >= _W-20) then
			autox.isVisible = false
		end
	end
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
	print("Y: "..c.." - "..ac)
	return ac
end

function moverEnY(autoy,timeY,dir)
	if(dir == "arr") then 
		transition.to(autoy,{y = -10, time = timeY})
		local accion = "mover"
		local sem = 3 --3 izquierda, 4 derecha
		--print(auto2.y .." - "..semaforo3.y.." - "..semaforo4.y)
		if(autoy.y >= semaforo3.y + 30 and autoy.y <= semaforo3.y + 50) then
			accion = identificarAccionY()
			sem = 3
		end
		if(autoy.y >= semaforo4.y + 30 and autoy.y <= semaforo4.y + 50) then
			accion = identificarAccionY()
			sem = 4
		end
		if(accion == "detener") then
			transition.cancel( autoy )
		elseif(accion == "frenar") then
			if(sem == 3) then
				transition.to(autoy,{y = semaforo3.y+50, time=2*timeY})
			elseif(sem == 4) then
				transition.to(autoy,{y = semaforo4.y+50, time=2*timeY})
			end
		else
			transition.to(autoy,{y = -10, time=timeY})
		end
		if(autoy.y <= 10) then
			autoy.isVisible = false
		end
	else
		transition.to(autoy,{y = _H+10, time = timeY})
		local accion = "mover"
		local sem = 3 --3 izquierda, 4 derecha
		--print(autoy.y .." - "..semaforo3.y.." - "..semaforo4.y)
		if(autoy.y <= semaforo3.y - 70 and autoy.y >= semaforo3.y - 100) then
			accion = identificarAccionY()
			sem = 3
		end
		if(autoy.y <= semaforo4.y - 70 and autoy.y >= semaforo4.y - 100) then
			accion = identificarAccionY()
			sem = 4
		end
		if(accion == "detener") then
			transition.cancel( autoy )
		elseif(accion == "frenar") then
			if(sem == 3) then
				transition.to(autoy,{y = semaforo3.y-75, time=2*timeY})
			elseif(sem == 4) then
				transition.to(autoy,{y = semaforo4.y-75, time=2*timeY})
			end
		else
			transition.to(autoy,{y = _H+10, time=timeY})
		end
		if(autoy.y >= _H-12) then
			autoy.isVisible = false
		end
	end
end


local tanda = 0
function moverX( )
	auto1.isVisible = true
	moverEnX(auto1,2000,"izq")
	auto5.isVisible = true
	moverEnX(auto5,4000,"der")
	if(tanda >= 2) then
		auto3.isVisible = true
		moverEnX(auto3,4000,"izq")
	end
	if(tanda >= 3) then
		auto7.isVisible = true
		moverEnX(auto7,5000,"izq")
		auto9.isVisible = true
		moverEnX(auto9,5000,"der")
	end
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
	timer.performWithDelay( 300, moverX,-1 )
	timer.performWithDelay( 200, moverY,-1 )
	timer.performWithDelay( 200, moverY,-1 )
	tanda = tanda+1
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
 