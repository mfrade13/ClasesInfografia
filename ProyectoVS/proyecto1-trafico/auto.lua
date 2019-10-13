module(..., package.seeall) -- paquete necesario para exportar la clase

local this = {}

function new_auto(params)
 	
 	auto = display.newImageRect("auto"..params.img..".png", params.width, params.height )
 	auto.img = params.img
 	auto.x = params.x
 	auto.y = params.y


	function identificarAccionX( colorSH )
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
 	
 	function moverEnX(semaforo1, semaforo2, color)
		local timeX = 4000
		transition.to(auto,{x = -20, time = timeX})
		local accion = "mover"
		local sem = 1 --1 izquierda, 2 derecha
		--print(auto1.x .." - "..semaforo1.x.." - "..semaforo2.x)
		if(auto.x >= semaforo1.x + 30 and auto.x <= semaforo1.x + 60) then
			accion = self:identificarAccionX(color)
			sem = 1
		end
		if(auto.x >= semaforo2.x + 30 and auto.x <= semaforo2.x + 60) then
			accion = self:identificarAccionX(color)
			sem = 2
		end
		if(accion == "detener") then
			transition.cancel( auto )
		elseif(accion == "frenar") then
			if(sem == 1) then
				transition.to(auto,{x = semaforo1.x+40, time=3*timeX})
			elseif(sem == 2) then
				transition.to(auto,{x = semaforo2.x+40, time=3*timeX})
			end
		else
			transition.to(auto,{x = -20, time=timeX})
		end
		if(auto.x <= 20) then
			auto.isVisible = false
		end
	end


	--en Y
	function identificarAccionY( colorSV )
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

 	function moverEnY(semaforo3,semaforo4,color)
		local timeY = 4000
		transition.to(auto,{y = -10, time = timeY})
		local accion = "mover"
		local sem = 3 --3 izquierda, 4 derecha
		--print(auto2.y .." - "..semaforo3.y.." - "..semaforo4.y)
		if(auto.y >= semaforo3.y + 30 and auto.y <= semaforo3.y + 50) then
			accion = self:identificarAccionY(color)
			sem = 3
		end
		if(auto.y >= semaforo4.y + 30 and auto.y <= semaforo4.y + 50) then
			accion = self:identificarAccionY(color)
			sem = 4
		end
		if(accion == "detener") then
			transition.cancel( auto )
		elseif(accion == "frenar") then
			if(sem == 3) then
				transition.to(auto,{y = semaforo3.y+50, time=3*timeY})
			elseif(sem == 4) then
				transition.to(auto,{y = semaforo4.y+50, time=3*timeY})
			end
		else
			transition.to(auto,{y = -10, time=timeY})
		end
		if(auto.y <= 10) then
			auto.isVisible = false
		end

	end

 	return this
 end 
