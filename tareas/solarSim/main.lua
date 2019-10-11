-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

_CW = display.contentWidth / 2
_CH = display.contentHeight / 2

local widget = require('widget')
local planet = require('planet')
local background = display.newImage("thisisnotapi.jpg", _CW, _CH)
local trail = false
local pause = true

sun = display.newCircle( _CW, _CH, 44)
mercury = planet.newPlanet({
	x = _CW,
	y = _CH + 200,
	size = 12,
	r = 0,
	a = 190,
	b = 300,
	t = 0,
	name = "mercury",
	rate = 0.03,
	orbit_center_x = _CW,
	orbit_center_y = _CH - 200,
	min_dist = 1000,
	dir = 1
})


venus = planet.newPlanet({
	x = _CW,
	y = _CH + 200,
	size = 14,
	r = 0,
	a = 220,
	b = 360,
	t = 0,
	name = "venus",
	rate = 0.02,
	orbit_center_x = _CW,
	orbit_center_y = _CH - 200,
	min_dist = 1000,
	dir = -1
})


earth = planet.newPlanet({
	x = _CW,
	y = _CH + 200,
	size = 19,
	r = 0,
	a = 300,
	b = 550,
	t = 0,
	name = "earth",
	rate = 0.02,
	orbit_center_x = _CW,
	orbit_center_y = _CH - 250,
	min_dist = 1000,
	dir = 1
})

mars = planet.newPlanet({
	x = _CW,
	y = _CH + 200,
	size = 16,
	r = 0,
	a = 400,
	b = 600,
	t = 0,
	name = "mars",
	rate = 0.02,
	orbit_center_x = _CW,
	orbit_center_y = _CH - 250,
	min_dist = 1000,
	dir = -1
})
jupiter = planet.newPlanet({
	x = _CW,
	y = _CH + 200,
	size = 24,
	r = 0,
	a = 250,
	b = 450,
	t = 0,
	name = "jupiter",
	rate = 0.02,
	orbit_center_x = _CW,
	orbit_center_y = _CH + 250,
	min_dist = 1000,
	dir = 1
})
saturn = planet.newPlanet({
	x = _CW,
	y = _CH + 200,
	size = 23,
	r = 0,
	a = 300,
	b = 550,
	t = 0,
	name = "saturn",
	rate = 0.02,
	orbit_center_x = _CW,
	orbit_center_y = _CH + 250,
	min_dist = 1000,
	dir = 1
})
uranus = planet.newPlanet({
	x = _CW,
	y = _CH + 200,
	size = 13,
	r = 0,
	a = 400,
	b = 650,
	t = 0,
	name = "uranus",
	rate = 0.03,
	orbit_center_x = _CW,
	orbit_center_y = _CH + 250,
	min_dist = 1000,
	dir = -1
})

moon = planet.newPlanet({
	x = _CW,
	y = _CH + 200,
	size = 9,
	r = 35,
	a = 190,
	b = 300,
	t = 0,
	name = "moon",
	rate = 0.04,
	orbit_center_x = _CW,
	orbit_center_y = _CH - 200,
	min_dist = 1000,
	dir = 1
})

europa = planet.newPlanet({
	x = _CW,
	y = _CH + 200,
	size = 10,
	r = 70,
	a = 190,
	b = 300,
	t = 0,
	name = "europa",
	rate = 0.01,
	orbit_center_x = _CW,
	orbit_center_y = _CH - 200,
	min_dist = 1000,
	dir = 1
})

titan = planet.newPlanet({
	x = _CW,
	y = _CH + 200,
	size = 10,
	r = 80,
	a = 190,
	b = 300,
	t = 0,
	name = "titan",
	rate = 0.03,
	orbit_center_x = _CW,
	orbit_center_y = _CH - 200,
	min_dist = 1000,
	dir = -1
})

function updateMoon( self )
	if self.t >= 2 * math.pi then
		self.t = 0
	end
	if self.state == 2 then
		self.trail_list:insert( display.newCircle(self.x, self.y, 2) )
	end
	self.t = self.t + math.pi * self.rate
	self.x = self.r * math.cos(self.t) + earth.x
	self.y = self.r * math.sin(self.t) + earth.y
end

function udpateEuropa( self )
	if self.t >= 2 * math.pi then
		self.t = 0
	end
	if self.state == 2 then
		self.trail_list:insert( display.newCircle(self.x, self.y, 2) )
	end
	self.t = self.t + math.pi * self.rate
	self.x = self.r * math.cos(self.t) + jupiter.x
	self.y = self.r * math.sin(self.t) + jupiter.y 
end

function updateTitan( self )
	if self.t >= 2 * math.pi then
		self.t = 0
	end
	if self.state == 2 then
		self.trail_list:insert( display.newCircle(self.x, self.y, 2) )
	end
	self.t = self.t + math.pi * self.rate
	self.x = self.r * math.cos(self.t) + saturn.x
	self.y = self.r * math.sin(self.t) + saturn.y 
end

function updateElliptical( self )
	if self.t >= 2 * math.pi then
		self.t = 0
	end
	if self.state == 2 then
		self.trail_list:insert( display.newCircle(self.x, self.y, 2) )
	end
	local d = ((self.x - _CW) ^ 2 + (self.y - _CH) ^ 2) ^ 0.5
	if self.min_dist > d then
		self.min_dist = d
	end
	self.v = self.rate * (self.min_dist / d)
	self.t = self.t + math.pi * self.v
	self.x = self.a * math.cos(self.dir * self.t) + self.orbit_center_x
	self.y = self.b * math.sin(self.dir * self.t) + self.orbit_center_y
end

mercury:setFillColor( 230/255, 202/255, 202/255 )
venus:setFillColor( 234/255, 200/255, 171/255 )
earth:setFillColor( 25/255, 25/255, 255/255 )
mars:setFillColor( 255/255, 25/255, 35/255 )
jupiter:setFillColor( 230/255, 153/255, 60/255 )
saturn:setFillColor( 234/255, 215/255, 108/255 )
uranus:setFillColor( 163/255, 166/255, 240/255 )
moon:setFillColor( 200/255, 200/255, 200/255 )
europa:setFillColor( 200/255, 150/255, 200/255 )
titan:setFillColor( 250/255, 255/255, 255/255 )
sun:setFillColor( 1,1,0 )

mercury.enterFrame = updateElliptical
venus.enterFrame = updateElliptical
earth.enterFrame = updateElliptical
mars.enterFrame = updateElliptical
jupiter.enterFrame = updateElliptical
saturn.enterFrame = updateElliptical
uranus.enterFrame = updateElliptical
moon.enterFrame = updateMoon
europa.enterFrame = udpateEuropa
titan.enterFrame = updateTitan

function handleButtonEvent( event )
 
    if ( "ended" == event.phase ) then
        if not pause then
			Runtime:removeEventListener( "enterFrame", mercury )
			Runtime:removeEventListener( "enterFrame", venus )
			Runtime:removeEventListener( "enterFrame", earth )
			Runtime:removeEventListener( "enterFrame", mars )
			Runtime:removeEventListener( "enterFrame", jupiter )
			Runtime:removeEventListener( "enterFrame", saturn )
			Runtime:removeEventListener( "enterFrame", uranus )
			Runtime:removeEventListener( "enterFrame", moon )
			Runtime:removeEventListener( "enterFrame", europa )
			Runtime:removeEventListener( "enterFrame", titan )
			pause = true
		else
			Runtime:addEventListener( "enterFrame", mercury )
			Runtime:addEventListener( "enterFrame", venus )
			Runtime:addEventListener( "enterFrame", earth )
			Runtime:addEventListener( "enterFrame", mars )
			Runtime:addEventListener( "enterFrame", jupiter )
			Runtime:addEventListener( "enterFrame", saturn )
			Runtime:addEventListener( "enterFrame", uranus )
			Runtime:addEventListener( "enterFrame", moon )
			Runtime:addEventListener( "enterFrame", europa )
			Runtime:addEventListener( "enterFrame", titan )
			pause = false
		end
    end
end

local pause_button = widget.newButton(
    {
        width = 100,
        height = 100,
        x = 100,
        y = 1800,
        fontSize = 100,
		defaultFile = "pause.png",
        overFile = "pauseOver.png",
        id = "pause_button",
        onEvent = handleButtonEvent
    }
)

function cycle_mercury(event)
	if ( "ended" == event.phase ) then
		mercury.state = mercury.state + 1
		if mercury.state == 3 then
			mercury.state = 0
		end
		print(mercury.state)
		if mercury.state == 0 then
			mercury.isVisible = false
			mercury.trail_list.isVisible = false
		elseif mercury.state == 1 then
			mercury.isVisible = true
			mercury.trail_list.isVisible = false
		elseif mercury.state == 2 then
			mercury.isVisible = true
			mercury.trail_list.isVisible = true
		end
	end
end

local mercury_button = widget.newButton(
    {
        width = 100,
        height = 100,
        x = 200,
        y = 1800,
        fontSize = 100,
		defaultFile = "mercury.png",
		overFile = "mercury.png",
        id = "mercury_button",
        onEvent = cycle_mercury
    }
)

function cycle_venus(event)
	if ( "ended" == event.phase ) then
		venus.state = venus.state + 1
		if venus.state == 3 then
			venus.state = 0
		end
		print(venus.state)
		if venus.state == 0 then
			venus.isVisible = false
			venus.trail_list.isVisible = false
		elseif venus.state == 1 then
			venus.isVisible = true
			venus.trail_list.isVisible = false
		elseif venus.state == 2 then
			venus.isVisible = true
			venus.trail_list.isVisible = true
		end
	end
end

local venus_button = widget.newButton(
    {
        width = 100,
        height = 100,
        x = 300,
        y = 1800,
        fontSize = 100,
		defaultFile = "venus.png",
		overFile = "venus.png",
        id = "venus_button",
        onEvent = cycle_venus
    }
)

function cycle_earth(event)
	if ( "ended" == event.phase ) then
		earth.state = earth.state + 1
		if earth.state == 3 then
			earth.state = 0
		end
		print(earth.state)
		if earth.state == 0 then
			earth.isVisible = false
			earth.trail_list.isVisible = false
		elseif earth.state == 1 then
			earth.isVisible = true
			earth.trail_list.isVisible = false
		elseif earth.state == 2 then
			earth.isVisible = true
			earth.trail_list.isVisible = true
		end
	end
end

local earth_button = widget.newButton(
    {
        width = 100,
        height = 100,
        x = 400,
        y = 1800,
        fontSize = 100,
		defaultFile = "earth.png",
		overFile = "earth.png",
        id = "earth_button",
        onEvent = cycle_earth
    }
)

function cycle_mars(event)
	if ( "ended" == event.phase ) then
		mars.state = mars.state + 1
		if mars.state == 3 then
			mars.state = 0
		end
		print(mars.state)
		if mars.state == 0 then
			mars.isVisible = false
			mars.trail_list.isVisible = false
		elseif mars.state == 1 then
			mars.isVisible = true
			mars.trail_list.isVisible = false
		elseif mars.state == 2 then
			mars.isVisible = true
			mars.trail_list.isVisible = true
		end
	end
end

local mars_button = widget.newButton(
    {
        width = 100,
        height = 100,
        x = 500,
        y = 1800,
        fontSize = 100,
		defaultFile = "mars.png",
		overFile = "mars.png",
        id = "mars_button",
        onEvent = cycle_mars
    }
)

function cycle_jupiter(event)
	if ( "ended" == event.phase ) then
		jupiter.state = jupiter.state + 1
		if jupiter.state == 3 then
			jupiter.state = 0
		end
		print(jupiter.state)
		if jupiter.state == 0 then
			jupiter.isVisible = false
			jupiter.trail_list.isVisible = false
		elseif jupiter.state == 1 then
			jupiter.isVisible = true
			jupiter.trail_list.isVisible = false
		elseif jupiter.state == 2 then
			jupiter.isVisible = true
			jupiter.trail_list.isVisible = true
		end
	end
end

local jupiter_button = widget.newButton(
    {
        width = 100,
        height = 100,
        x = 600,
        y = 1800,
        fontSize = 100,
		defaultFile = "jupiter.png",
		overFile = "jupiter.png",
        id = "jupiter_button",
        onEvent = cycle_jupiter
    }
)

function cycle_saturn(event)
	if ( "ended" == event.phase ) then
		saturn.state = saturn.state + 1
		if saturn.state == 3 then
			saturn.state = 0
		end
		print(saturn.state)
		if saturn.state == 0 then
			saturn.isVisible = false
			saturn.trail_list.isVisible = false
		elseif saturn.state == 1 then
			saturn.isVisible = true
			saturn.trail_list.isVisible = false
		elseif saturn.state == 2 then
			saturn.isVisible = true
			saturn.trail_list.isVisible = true
		end
	end
end

local saturn_button = widget.newButton(
    {
        width = 100,
        height = 100,
        x = 700,
        y = 1800,
        fontSize = 100,
		defaultFile = "saturn.png",
		overFile = "saturn.png",
        id = "saturn_button",
        onEvent = cycle_saturn
    }
)

function cycle_uranus(event)
	if ( "ended" == event.phase ) then
		uranus.state = uranus.state + 1
		if uranus.state == 3 then
			uranus.state = 0
		end
		print(uranus.state)
		if uranus.state == 0 then
			uranus.isVisible = false
			uranus.trail_list.isVisible = false
		elseif uranus.state == 1 then
			uranus.isVisible = true
			uranus.trail_list.isVisible = false
		elseif uranus.state == 2 then
			uranus.isVisible = true
			uranus.trail_list.isVisible = true
		end
	end
end

local uranus_button = widget.newButton(
    {
        width = 100,
        height = 100,
        x = 800,
        y = 1800,
        fontSize = 100,
		defaultFile = "uranus.png",
		overFile = "uranus.png",
        id = "uranus_button",
        onEvent = cycle_uranus
    }
)

function cycle_moon(event)
	if ( "ended" == event.phase ) then
		moon.state = moon.state + 1
		if moon.state == 3 then
			moon.state = 0
		end
		print(moon.state)
		if moon.state == 0 then
			moon.isVisible = false
			moon.trail_list.isVisible = false
		elseif moon.state == 1 then
			moon.isVisible = true
			moon.trail_list.isVisible = false
		elseif moon.state == 2 then
			moon.isVisible = true
			moon.trail_list.isVisible = true
		end
	end
end

local moon_button = widget.newButton(
    {
        width = 100,
        height = 100,
        x = 100,
        y = 1700,
        fontSize = 100,
		defaultFile = "moon.png",
		overFile = "moon.png",
        id = "moon_button",
        onEvent = cycle_moon
    }
)

function cycle_europa(event)
	if ( "ended" == event.phase ) then
		europa.state = europa.state + 1
		if europa.state == 3 then
			europa.state = 0
		end
		print(europa.state)
		if europa.state == 0 then
			europa.isVisible = false
			europa.trail_list.isVisible = false
		elseif europa.state == 1 then
			europa.isVisible = true
			europa.trail_list.isVisible = false
		elseif europa.state == 2 then
			europa.isVisible = true
			europa.trail_list.isVisible = true
		end
	end
end

local europa_button = widget.newButton(
    {
        width = 100,
        height = 100,
        x = 200,
        y = 1700,
        fontSize = 100,
		defaultFile = "europa.png",
		overFile = "europa.png",
        id = "europa_button",
        onEvent = cycle_europa
    }
)

function cycle_titan(event)
	if ( "ended" == event.phase ) then
		titan.state = titan.state + 1
		if titan.state == 3 then
			titan.state = 0
		end
		print(titan.state)
		if titan.state == 0 then
			titan.isVisible = false
			titan.trail_list.isVisible = false
		elseif titan.state == 1 then
			titan.isVisible = true
			titan.trail_list.isVisible = false
		elseif titan.state == 2 then
			titan.isVisible = true
			titan.trail_list.isVisible = true
		end
	end
end

local titan_button = widget.newButton(
    {
        width = 100,
        height = 100,
        x = 300,
        y = 1700,
        fontSize = 100,
		defaultFile = "titan.png",
		overFile = "titan.png",
        id = "titan_button",
        onEvent = cycle_titan
    }
)