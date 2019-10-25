-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--importaciones
local widget = require('widget')
-- CONSTANTES
local CW = display.contentWidth
local CH = display.contentHeight

display.setStatusBar( display.HiddenStatusBar )

--variables globales
local fondo, imagenComic, barraBaja, boton1, boton2
local grupo = display.newGroup()
local comicGroup = display.newGroup()
local estado = 0
local permitirAnimar = true

fondo = display.newRect( grupo, 0, 0, CW, CH )
fondo.anchorX = 0
fondo.anchorY = 0
fondo:setFillColor(0)

grupo:insert(2, comicGroup)

imagenComic = display.newImageRect( comicGroup, "comic2.png", CW*0.8, CH*0.8 )
--alineacion del grupo
comicGroup.x = CW/2
comicGroup.y = CH/2

local arregloEstados = {
	{x1 = (imagenComic.contentWidth)*1.5 , y1 = imagenComic.contentHeight, xs=3, ys=2  },
	{x1 = imagenComic.contentWidth/2, y1 =imagenComic.contentHeight + 80 ,xs=3.2,ys=3.2 },
	{x1 =  0, y1 = imagenComic.contentHeight, xs =2.2,ys= 2.2  },
	{x1 = imagenComic.contentWidth, y1 = 20, xs=2,ys=2 },
	{x1 = 0, y1 = 20,xs=2.2,ys=2.2 }
}


barraBaja = display.newRect( 0, CH, CW, 100)
barraBaja.anchorX = 0
barraBaja.anchorY = 1
barraBaja:setFillColor( 0 )

grupo:insert(3, barraBaja)

function habilitar()
	permitirAnimar = true
end

function moverCamara()
	if permitirAnimar then
		permitirAnimar = false
		if estado > 0 then
			transition.to( comicGroup, {xScale=arregloEstados[estado].xs , 
				yScale= arregloEstados[estado].ys,
			 	x= arregloEstados[estado].x1, 
			 	y =arregloEstados[estado].y1, time = 1500,
			 	onComplete = habilitar
			 })
		-- 	transition.to( comicGroup, {xScale = 2, yScale = 2,
		-- 	x =  arregloEstados[1].x1 , y= arregloEstados[1].y1 } )		
		-- elseif estado == 2 then
		-- 	transition.to( comicGroup, {x =arregloEstados[2].x1,
		-- 	 y =arregloEstados[2].y1  } )
		-- elseif estado == 3 then
		-- 	transition.to( comicGroup, {x = arregloEstados[3].x1,
		-- 		y= arregloEstados[3].y1} )
		-- elseif estado == 4 then
		-- transition.to( comicGroup, {x = arregloEstados[4].x1,
		-- 		y= arregloEstados[4].y1} )

		elseif estado == 0 then
			transition.to( comicGroup, {xScale=1, yScale=1,x=CW/2, y= CH/2} )
		end
	end

	print(xOffset, yOffset )
	print('ESTADO =' .. tostring(estado))

end

function siguientePagina(  )
	
	if estado < #arregloEstados and permitirAnimar then
		estado = estado + 1
	end
	moverCamara()
	return true
end

function anteriorPagina()
	if estado > 0  and permitirAnimar then
		estado = estado -1
	end
	moverCamara()
end

boton1 = widget.newButton( {
	width = 120,
	height = 80,
	label = "SIGUIENTE",
	fontSize = 38,
	onRelease = siguientePagina,
	x = CW*0.75,
	y = CH*0.95
	})

boton2 = widget.newButton( {
	width = 120,
	height = 80,
	label = "ANTERIOR",
	fontSize = 38,
	onRelease = anteriorPagina,
	x = CW*0.25,
	y = CH*0.95
	})

-- grupo:insert( 4, boton1 )
-- grupo:insert( 4, boton2 )

















