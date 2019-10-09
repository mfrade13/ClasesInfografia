-----------------------------------------------------------------------------------------
--
-- main.lua
-- 6/10/2019 Luis Fernando Choque Arana Codigo=36267
-- 
-----------------------------------------------------------------------------------------

--local earth = display.newImageRect("earth.png",50,50)
--earth.x=100
--earth.y=125

--transition.to(earth, {x=200,y=225, time=1000})
--transition.to(earth, {x=100,y=25, time=1000})

local widget= require 'widget'

local origenx,origeny=512,300

local pendulo = display.newImage( "pendulo.png", 480,430 )
local contorno=display.newCircle( origenx, origeny, 200 )
contorno:setFillColor( 0.2)
contorno.strokeWidth = 10
contorno:setStrokeColor( 2, 0, 0 )

nums = require 'numeros'

local minutero= display.newImage("minutero.png", origenx, origeny)
minutero:scale(0.3,0.3)
minutero.anchorY=0
minutero.rotation=180


local horero= display.newImage("minutero.png", origenx, origeny)
horero:scale(0.1,0.2)
horero.anchorY=0
horero.rotation=180

local centro=display.newCircle( origenx, origeny, 20 )
centro:setFillColor( 0.8)
centro.strokeWidth = 2
centro:setStrokeColor( 1, 0, 0 )

local bird= display.newImage( "bird.png", 512,20 )
bird:scale(0.05,0.05)
bird.isVisible = false


local hora= display.newText( "00" .. ":" ..  "00", 512, 900, native.systemFont, 130 )
hora:setTextColor(1,1,1)

pendulo.anchorY=0
pendulo:scale( 0.25, 0.5 )

local angulo  = 1
local anguloMinutero=180
local anguloHorero=180

local girarDerecha= true

function moverPendulo( )

	if(girarDerecha) then
		angulo=angulo+7
	else 
		angulo=angulo-7
	end

	if(angulo>20) then
		girarDerecha=false
	elseif (angulo<-30) then
		girarDerecha=true
	end

	anguloMinutero= anguloMinutero+6

	if(anguloMinutero%4==0) then
		anguloHorero= anguloHorero+1
	end

	if(anguloMinutero>535) then
		bird.isVisible = true
		anguloMinutero=180
	end

	if(anguloMinutero>187) then
		bird.isVisible = false
	end

	if(anguloHorero>900) then
		anguloHorero=180
	end

	print(anguloMinutero)
	minutero.rotation=anguloMinutero
	horero.rotation=anguloHorero
	pendulo.rotation= angulo
	
	
	hora.text= math.floor((anguloHorero-180)/30) .. ":".. math.floor((anguloMinutero-180)/6)

end

local l= timer.performWithDelay( 50, moverPendulo,-1)

function startClock()
--	timer.performWithDelay( 1000, moverPendulo,-1)
	timer.resume(l)
end



function  parar(  )
	timer.pause(l)
--	Runtime:removeEventListener("enterFrame",moverPendulo)
--	pendulo.rotation=0
end

local start= widget.newButton(
	{
		id='startButton',
		x= 300,
		y= 1100,
		onRelease = startClock,
		--defaultFile = 'button.png',
		--overFile= 'bird.png',
		width = 100,
		heigh= 100,
		label= 'START!',
		fontSize= 50,
		labelColor = {default={1,0,0}, over={0,1,0} }
	}
)


local stop= widget.newButton(
	{
		id='stopButton',
		x= 600,
		y= 1100,
		onRelease = parar,
	
		width = 100,
		heigh= 100,
		label= 'STOP!',
		fontSize= 50,
		labelColor = {default={1,0,0}, over={0,1,0} }
	}
)