-----------------------------------------------------------------------------------------
local widget = require("widget")

-- Constantes de dimension de pantalla
local _W = display.contentWidth
local _H = display.contentHeight
x = display.actualContentHeight
y = display.actualContentWidth
local background = display.newRect(0, 0, _W, _H)
background.anchorX = 0
background.anchorY = 0
background:setFillColor(0.9)

-- Function to handle button events
local function handleButtonEvent(event)
    if ("ended" == event.phase) then print(	) end
end

-- Create the widget 
local props = {
    label = "button",
    onEvent = handleButtonEvent,
    emboss = true,
    shape = "roundedRect",
    cornerRadius = 10,
    fillColor = {default = {0, 0, 0, 1}, over = {0, 0, 0, 0.9}},
    strokeColor = {default = {0, 1, 0, 1}, over = {0, 1, 0, 1}},
    strokeWidth = 4,
    fontSize = 30,
    labelColor = {default = {0, 1, 0}, over = {0, 1, 0}},
    font = "Wide Latin"
}

btnmenos = widget.newButton(props)
btnigual = widget.newButton(props)
btncero = widget.newButton(props)
btnpunto = widget.newButton(props)
btnpotenciaN = widget.newButton(props)
btnsigno = widget.newButton(props)
btnlog10 = widget.newButton(props)
btnmas = widget.newButton(props)
btntres = widget.newButton(props)
btndos = widget.newButton(props)
btnuno = widget.newButton(props)
btnpotenciaD = widget.newButton(props)
btnmod = widget.newButton(props)
btnround = widget.newButton(props)
btndivision = widget.newButton(props)
btnseis = widget.newButton(props)
btncinco = widget.newButton(props)
btncuatro = widget.newButton(props)
btncp = widget.newButton(props)
btnup = widget.newButton(props)
btnraiz = widget.newButton(props)
btnmultiplicacion = widget.newButton(props)
btnnueve = widget.newButton(props)
btnocho = widget.newButton(props)
btnsiete = widget.newButton(props)
btnborar = widget.newButton(props)
btnporcentaje = widget.newButton(props)
btnca = widget.newButton(props)

altoButton = 40
anchoButton = 65

btnmenos.width = anchoButton
btnmenos.height = altoButton
btnigual.width = anchoButton
btnigual.height = altoButton
btncero.width = anchoButton
btncero.height = altoButton
btnpunto.width = anchoButton
btnpunto.height = altoButton
btnpotenciaN.width = anchoButton
btnpotenciaN.height = altoButton
btnsigno.width = anchoButton
btnsigno.height = altoButton
btnlog10.width = anchoButton
btnlog10.height = altoButton
btnmas.width = anchoButton
btnmas.height = altoButton
btntres.width = anchoButton
btntres.height = altoButton
btndos.width = anchoButton
btndos.height = altoButton
btnuno.width = anchoButton
btnuno.height = altoButton
btnpotenciaD.width = anchoButton
btnpotenciaD.height = altoButton
btnmod.width = anchoButton
btnmod.height = altoButton
btnround.width = anchoButton
btnround.height = altoButton
btndivision.width = anchoButton
btndivision.height = altoButton
btnseis.width = anchoButton
btnseis.height = altoButton
btncinco.width = anchoButton
btncinco.height = altoButton
btncuatro.width = anchoButton
btncuatro.height = altoButton
btncp.width = anchoButton
btncp.height = altoButton
btnup.width = anchoButton
btnup.height = altoButton
btnraiz.width = anchoButton
btnraiz.height = altoButton
btnmultiplicacion.width = anchoButton
btnmultiplicacion.height = altoButton
btnnueve.width = anchoButton
btnnueve.height = altoButton
btnocho.width = anchoButton
btnocho.height = altoButton
btnsiete.width = anchoButton
btnsiete.height = altoButton
btnborar.width = anchoButton
btnborar.height = altoButton
btnporcentaje.width = anchoButton
btnporcentaje.height = altoButton
btnca.width = anchoButton
btnca.height = altoButton

-- Change the button's label text

btnmenos:setLabel("--")
btnigual:setLabel("=")
btncero:setLabel("0")
btnpunto:setLabel(".")
btnpotenciaN:setLabel("x^n")
btnsigno:setLabel("+/-")
btnlog10:setLabel("log10")
btnmas:setLabel("+")
btntres:setLabel("3")
btndos:setLabel("2")
btnuno:setLabel("1")
btnpotenciaD:setLabel("x^2")
btnmod:setLabel("mod")
btnround:setLabel("round")
btndivision:setLabel("/")
btnseis:setLabel("6")
btncinco:setLabel("5")
btncuatro:setLabel("4")
btncp:setLabel(")")
btnup:setLabel("(")
btnraiz:setLabel("√")
btnmultiplicacion:setLabel("x")
btnnueve:setLabel("9")
btnocho:setLabel("8")
btnsiete:setLabel("7")
btnborar:setLabel("<==")
btnporcentaje:setLabel("%")
btnca:setLabel("C")

pantallax = 480
pantallay = 320
vmargin = 3

-- Center the button
btnmenos.x = pantallax - (anchoButton / 2) - vmargin
btnmenos.y = pantallay - (altoButton / 2) - vmargin
btnigual.x = btnmenos.x - (anchoButton) - vmargin
btnigual.y = pantallay - (altoButton / 2) - vmargin
btncero.x = btnigual.x - (anchoButton) - vmargin
btncero.y = pantallay - (altoButton / 2) - vmargin
btnpunto.x = btncero.x - (anchoButton) - vmargin
btnpunto.y = pantallay - (altoButton / 2) - vmargin
btnpotenciaN.x = btnpunto.x - (anchoButton) - vmargin
btnpotenciaN.y = pantallay - (altoButton / 2) - vmargin
btnsigno.x = btnpotenciaN.x - (anchoButton) - vmargin
btnsigno.y = pantallay - (altoButton / 2) - vmargin
btnlog10.x = btnsigno.x - (anchoButton) - vmargin
btnlog10.y = pantallay - (altoButton / 2) - vmargin
btnmas.x = pantallax - (anchoButton / 2) - vmargin
btnmas.y = btnmenos.y - (altoButton) - vmargin
btntres.x = btnmenos.x - (anchoButton) - vmargin
btntres.y = btnmenos.y - (altoButton) - vmargin
btndos.x = btnigual.x - (anchoButton) - vmargin
btndos.y = btnigual.y - (altoButton) - vmargin
btnuno.x = btncero.x - (anchoButton) - vmargin
btnuno.y = btncero.y - (altoButton) - vmargin
btnpotenciaD.x = btnpunto.x - (anchoButton) - vmargin
btnpotenciaD.y = btnpunto.y - (altoButton) - vmargin
btnmod.x = btnpotenciaN.x - (anchoButton) - vmargin
btnmod.y = btnpotenciaN.y - (altoButton) - vmargin
btnround.x = btnsigno.x - (anchoButton) - vmargin
btnround.y = btnsigno.y - (altoButton) - vmargin
btndivision.x = pantallax - (anchoButton / 2) - vmargin
btndivision.y = btnmas.y - (altoButton) - vmargin
btnseis.x = btnmas.x - (anchoButton) - vmargin
btnseis.y = btnmas.y - (altoButton) - vmargin
btncinco.x = btntres.x - (anchoButton) - vmargin
btncinco.y = btntres.y - (altoButton) - vmargin
btncuatro.x = btndos.x - (anchoButton) - vmargin
btncuatro.y = btndos.y - (altoButton) - vmargin
btncp.x = btnuno.x - (anchoButton) - vmargin
btncp.y = btnuno.y - (altoButton) - vmargin
btnup.x = btnpotenciaD.x - (anchoButton) - vmargin
btnup.y = btnpotenciaD.y - (altoButton) - vmargin
btnraiz.x = btnmod.x - (anchoButton) - vmargin
btnraiz.y = btnmod.y - (altoButton) - vmargin
btnmultiplicacion.x = pantallax - (anchoButton / 2) - vmargin
btnmultiplicacion.y = btndivision.y - (altoButton) - vmargin
btnnueve.x = btndivision.x - (anchoButton) - vmargin
btnnueve.y = btndivision.y - (altoButton) - vmargin
btnocho.x = btnseis.x - (anchoButton) - vmargin
btnocho.y = btnseis.y - (altoButton) - vmargin
btnsiete.x = btncinco.x - (anchoButton) - vmargin
btnsiete.y = btncinco.y - (altoButton) - vmargin
btnborar.x = btncuatro.x - (anchoButton) - vmargin
btnborar.y = btncuatro.y - (altoButton) - vmargin
btnporcentaje.x = btncp.x - (anchoButton) - vmargin
btnporcentaje.y = btncp.y - (altoButton) - vmargin
btnca.x = btnup.x - (anchoButton) - vmargin
btnca.y = btnup.y - (altoButton) - vmargin

local resultado = display.newRect(pantallax / 2, pantallay / 4.5,
                                  (pantallax - 10), pantallay / 2.5)
resultado:setFillColor(0)
resultado:setStrokeColor(0, 1, 0)
resultado.strokeWidth = 4



text = ""
largo = 450
lc = {}
chars = {}
local dsp = display.newText(text, 360, 50, "Arial", 25)
function btnuno:touch( event )
	if event.phase == "began" then
		text = text.."1"
		display.remove( dsp )
		table.insert( lc, 6 )
		table.insert( chars, "n" )
		largo = largo - 6
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btndos:touch( event )
	if event.phase == "began" then
		text = text.."2"
		display.remove( dsp )
		table.insert( lc, 7 )
		table.insert( chars, "n" )
		largo = largo - 7
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btntres:touch( event )
	if event.phase == "began" then
		text = text.."3"
		display.remove( dsp )
		table.insert( lc, 7 )
		table.insert( chars, "n" )
		largo = largo - 7
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btncuatro:touch( event )
	if event.phase == "began" then
		text = text.."4"
		display.remove( dsp )
		table.insert( lc, 7 )
		table.insert( chars, "n" )
		largo = largo - 7
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btncinco:touch( event )
	if event.phase == "began" then
		text = text.."5"
		display.remove( dsp )
		table.insert( lc, 7 )
		table.insert( chars, "n" )
		largo = largo - 7
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnseis:touch( event )
	if event.phase == "began" then
		text = text.."6"
		display.remove( dsp )
		table.insert( lc, 7 )
		table.insert( chars, "n" )
		largo = largo - 7 
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnsiete:touch( event )
	if event.phase == "began" then
		text = text.."7"
		display.remove( dsp )
		table.insert( lc, 7 )
		table.insert( chars, "n" )
		largo = largo - 7
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnocho:touch( event )
	if event.phase == "began" then
		text = text.."8"
		display.remove( dsp )
		table.insert( lc, 7 )
		table.insert( chars, "n" )
		largo = largo - 7
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnnueve:touch( event )
	if event.phase == "began" then
		text = text.."9"
		display.remove( dsp )
		table.insert( lc, 7 )
		table.insert( chars, "n" )
		largo = largo - 7
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btncero:touch( event )
	if event.phase == "began" then
		text = text.."0"
		display.remove( dsp )
		table.insert( lc, 7 )
		table.insert( chars, "n" )
		largo = largo - 7
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnmenos:touch( event )
	if event.phase == "began" then
		text = text.."-"
		display.remove( dsp )
		table.insert( lc, 4.2 )
		table.insert( chars, "o" )
		largo = largo - 4.2
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnmas:touch( event )
	if event.phase == "began" then
		text = text.."+"
		display.remove( dsp )
		table.insert( lc, 7.2 )
		table.insert( chars, "o" )
		largo = largo - 7.2
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnmultiplicacion:touch( event )
	if event.phase == "began" then
		text = text.."*"
		display.remove( dsp )
		table.insert( lc, 5 )
		table.insert( chars, "o" )
		largo = largo - 5
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btndivision:touch( event )
	if event.phase == "began" then
		text = text.."/"
		display.remove( dsp )
		table.insert( lc, 3.4 )
		table.insert( chars, "o" )
		largo = largo - 3.4
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnpunto:touch( event )
	if event.phase == "began" then
		contain = string.find( text, "%." )
		--print(contain)
		if contain == nil then
			if text:len() == 0 then
				text = text.."0"
			end
			text = text.."."
			display.remove( dsp )
			table.insert( lc, 3.4 )
			table.insert( chars, "d" )
			largo = largo - 3.4
			dsp = display.newText(text, largo, 50, "Arial", 25)
		end
	end
	return true
end

function btnborar:touch( event )
	if event.phase == "began" then
		text = text:sub( 1, -2 )
		display.remove( dsp )
		largo = largo + lc[table.getn(lc)]
		rchar = table.remove( chars )
		print( table.remove( lc ), "..." , rchar)
		if rchar == "r" then
			text = text:sub( 1, -5 )
		end
		if rchar == "l" then
			text = text:sub( 1, -6 )
		end
		if rchar == "m" then
			text = text:sub( 1, -4 )
		end

		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnca:touch( event )
	if event.phase == "began" then
		text = ""
		display.remove( dsp )
		lc = {}
		chars = {}
		largo = 450 
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btncp:touch( event )
	if event.phase == "began" then
		text = text..")"
		display.remove( dsp )
		table.insert( lc, 4.2 )
		table.insert( chars, "p" )
		largo = largo - 4.2
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnup:touch( event )
	if event.phase == "began" then
		text = text.."("
		display.remove( dsp )
		table.insert( lc, 4.2 )
		table.insert( chars, "p" )
		largo = largo - 4.2
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnraiz:touch( event )
	if event.phase == "began" then
		text = text.."sqrt("
		display.remove( dsp )
		table.insert( lc, 6.8*4 )
		table.insert( lc, 4.2 )
		table.insert( chars, "r" )
		table.insert( chars, "p" )
		largo = largo - 11
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnporcentaje:touch( event )
	if event.phase == "began" then
		text = text.."%"
		display.remove( dsp )
		table.insert( lc, 11.2 )
		table.insert( chars, "s" )
		largo = largo - 11.2
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnmod:touch( event )
	if event.phase == "began" then
		text = text.."mod("
		display.remove( dsp )
		table.insert( lc, 24.5 )
		table.insert( chars, "m" )
		table.insert( lc, 4.2 )
		table.insert( chars, "p" )
		largo = largo - 24.5 - 4.2
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnlog10:touch( event )
	if event.phase == "began" then
		text = text.."log10("
		display.remove( dsp )
		table.insert( lc, 30.6 )
		table.insert( chars, "l" )
		table.insert( lc, 4.2 )
		table.insert( chars, "p" )
		largo = largo - 30.6 - 4.2
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnpotenciaD:touch( event )
	if event.phase == "began" then
		text = text.."^2"
		display.remove( dsp )
		table.insert( lc, 5.7 )
		table.insert( chars, "pw" )
		table.insert( lc, 7 )
		table.insert( chars, "n" )
		largo = largo - 12.7
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end

function btnpotenciaN:touch( event )
	if event.phase == "began" then
		text = text.."^"
		display.remove( dsp )
		table.insert( lc, 5.7 )
		table.insert( chars, "pw" )
		largo = largo - 5.7
		dsp = display.newText(text, largo, 50, "Arial", 25)
	end
	return true
end
