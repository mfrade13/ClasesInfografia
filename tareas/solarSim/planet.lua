module(..., package.seeall)

function newPlanet(params)
	local planet = display.newCircle(params.x, params.y, params.size)
	planet.trail_list = display.newGroup( )
	planet.r = params.r
	planet.name = params.name
	planet.rate = params.rate
	planet.v = planet.rate
	planet.t = params.t
	planet.orbit_center_x = params.orbit_center_x
	planet.orbit_center_y = params.orbit_center_y
	planet.a = params.a
	planet.b = params.b
	planet.relative_dist = params.relative_dist 
	planet.min_dist = params.min_dist
	planet.dir = params.dir
	planet.state = 1
	return planet
end