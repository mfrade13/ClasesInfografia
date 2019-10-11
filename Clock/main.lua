-----------------------------------------------------------------------------------------
--
-- main.lua

--Benjamin Soto 2019
-----------------------------------------------------------------------------------------
--Background
local background = display.newImageRect( "b.jpg", 1536, 2048 )
background.x = display.contentCenterX
background.y = display.contentCenterY
--Imagen del reloj
local clock = display.newImageRect( "bird2.jpg", 1000, 1400 )
clock.x = display.contentCenterX+30
clock.y = display.contentCenterY-150

--Boton Pausa
local botonHora = display.newImageRect( "knob.png", 200, 270 )
botonHora.x = display.contentCenterX+340
botonHora.y = display.contentCenterY-650
botonHora.rotation=-45
--Boton Aumento
local botonMin = display.newImageRect( "knob.png", 200, 270 )
botonMin.x = display.contentCenterX-340
botonMin.y = display.contentCenterY-650
botonMin.rotation=225
--Horero
local hor = display.newRect( 783, 1120, 90, 25 )
hor:setFillColor( 0)
hor.anchorX =1
hor.anchorY =1
--Minutero
local minu = display.newRect( 778, 1130, 160, 14 )
minu:setFillColor( 0)
minu.anchorX =1
minu.anchorY =1
--Pendulo
local pen = display.newImageRect( "pend.png", 270, 600 )
pen.x = display.contentCenterX
pen.y = display.contentCenterY+320
pen.anchorX =0
pen.anchorY =0
pen.rotation = 45
--Pajaro
local pajaro = display.newImageRect( "bird.png", 119, 173 )
pajaro.x = display.contentCenterX+10
pajaro.y = display.contentCenterY-280
--Sonido
local chirp = audio.loadSound( "chirpwav.wav" )
---Fondo Falso
local falso = display.newImageRect( "bird2.png", 1000, 1400 )
falso.x = display.contentCenterX+30
falso.y = display.contentCenterY-150
--Aparicion
local function subir()
    local playback = audio.play( chirp )
    transition.to( pajaro, { time=300, alpha=1, x=(display.contentCenterX+10), y=(display.contentCenterY-440), transition=easing.inOutCubic } )
    transition.to( pajaro, { time=400, delay=1500,alpha=1, x=(display.contentCenterX+10), y=(display.contentCenterY-280), transition=easing.inOutCubic } )
end

--Operacion del reloj

local timeTable = os.date("*t")
hor.rotation   = (timeTable.min+15) * 6
minu.rotation = (timeTable.sec+15) * 6
while hor.rotation%30 ~= 0 do
    hor.rotation=hor.rotation-1
    end
local rotacionMinInicial =minu.rotation

local function moveHands(e)
    minu.rotation = minu.rotation+6
    if(minu.rotation%450==0) then
            hor.rotation =hor.rotation +30
            minu.rotation=minu.rotation-360
            subir()
    end
    if(hor.rotation%450==0) then
        hor.rotation=hor.rotation-360
    end
    --Movimiento del pendulo
    if minu.rotation%12 == 0 then
    	transition.to( pen, { rotation=-45, time=80, transition=easing.inOutCubic } )
    	transition.to( pen, { time=80, alpha=1, x=(display.contentCenterX-70), y=(display.contentCenterY+465), transition=easing.inOutCubic } )
    	
    else
    	transition.to( pen, { rotation=45, time=80, transition=easing.inOutCubic } )
    	transition.to( pen, { time=80, alpha=1, x=(display.contentCenterX), y=(display.contentCenterY+320), transition=easing.inOutCubic } )

    end
end 

--Inicializacion del reloj
local times= timer.performWithDelay(1000, moveHands, 0)
local stop =1
--Botones
-- Boton derecho
local function botonDerechaHandler( event )
    
    if (event.phase == "began") then  
        stop=stop+1
        if stop%2 == 0 then
            timer.cancel( times )   
        else
            times=timer.performWithDelay(1000, moveHands, 0)
        end
        
    end
    return true
 
end 
botonHora:addEventListener("touch", botonDerechaHandler)
-- Boton izquierdo
local switchHora =0
local function botonIzquierdoHandler( event )
    if (event.phase == "began") then 
        minu.rotation = minu.rotation + 6  
        if(minu.rotation%450==0) then
            hor.rotation =hor.rotation +30
            minu.rotation=minu.rotation-360
            subir()
        end
        if(hor.rotation%450==0) then
        hor.rotation=hor.rotation-360
    end
    end
    return true
 
end 
botonMin:addEventListener("touch", botonIzquierdoHandler)

----Reloj Digital
local horaDig=display.newText("00:00", display.contentCenterX+10, display.contentCenterY-920, "SignPainter-HouseScriptSemibold", 120)
horaDig:setFillColor(0.4, 0.7, 1, 1)
local function updateT()
    if (((minu.rotation-90)/6)<10) then
        horaDig.text = ((hor.rotation-90)/30)..":0"..((minu.rotation-90)/6)
    else
        horaDig.text = ((hor.rotation-90)/30)..":"..((minu.rotation-90)/6)
    end
end
local di= timer.performWithDelay(500, updateT, 0)


