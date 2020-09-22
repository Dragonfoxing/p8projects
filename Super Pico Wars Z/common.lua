--common library

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
function contains(t,o)
	if(type(o) == 'table') return false
	for i in all(t) do
		if(i==o) return true
	end
	
	return false
end