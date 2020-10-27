--common library

cam = camera
r = rect
ro = function(x1,y1,x2,y2,z)
	rect(o.x+x1,o.y+y1,o.x+x2,o.y+y2,z)
end
rf = rectfill
rfo = function(x1,y1,x2,y2,z)
	rectfill(o.x+x1,o.y+y1,o.x+x2,o.y+y2,z)
end

p=print

po=function(s,x,y,z)
	p(s,o.x+x,o.y+y,z)
end

col=color
--distance function - replace args with x1,y1,x2,y2
function get_unit_dist(u,e)
	return sqrt((u.x-e.x)^2+(u.y-e.y)^2)
end

function copy(o)
	local c
	if type(o) == 'table' then
		c = {}
		for k, v in pairs(o) do
			c[k] = copy(v)
		end
	else
		c = o
	end
	return c
end

--for sequences only!
function has(t,o)
	if(type(o) == 'table') return false
	for i in all(t) do
		if(i==o) return true
	end
	
	return false
end

--project-specific
--grid-to-display conversion
function gptox(x)
	return gxoff+x*gxy
end

function gptoy(y)
	return gyoff+y*gxy
end