--unit
--vars
unit={}
unit.player=false
unit.name="ship name here"
--0=north,1=east,2=south,3=west
unit.facing=0
unit.x=0
unit.y=0
unit.spr=20
unit.teamspr=28
unit.hp=8
unit.sh=4
unit.move=2
unit.wepdmg=2
unit.weprng=6
unit.idle=false
unit.dist=0
unit.close=nil

ini_coords={}

units={}

unit_count=4

--init

function init_units()
	local coords=init_unit_coords()
	--get our coords
	for i=0,unit_count-1,1 do
		local u=copy(unit)
		u.player=true
		u.name="ship "..(i+1)
		u.teamspr=29
		local c=del(coords,coords[1])
		u.x=flr(c/grid)
		u.y=flr(c%grid)
		u.facing=flr(rnd(4))
		add(units,u)
	end
	
	for i=0,unit_count-1,1 do
		local u=copy(unit)
		u.player=false
		u.teamspr=28
		u.name="ship "..(i+1)
		local c=del(coords,coords[1])
		u.x=flr(c/grid)
		u.y=flr(c%grid)
		u.facing=flr(rnd(4))
		add(units,u)
	end
end

function init_unit_coords()
	coords={}
	local n=0
	
	while n<unit_count*2 do
		local pos=flr(rnd(grid^2))
		local uniq=true
		
		if(not contains(coords,pos)) then
			add(coords,pos)
			n+=1
		end
	end
	
	return coords
end

--draw

function draw_units()
	for u in all(units) do
		if(u.facing==0 or u.facing==2) then draw_unit_vert(u)
		else draw_unit_horiz(u)
		end
		
		spr(u.teamspr, gposx(u.x), gposy(u.y))
		if(u==selected) spr(11,gposx(u.x),gposy(u.y))
		if(not u.idle and u.player) spr(27,gposx(u.x),gposy(u.y))
	end
end

function draw_unit_vert(u)
	local sp=u.spr
	local flp=false
	if(u.facing==2) flp=true
	
	spr(sp,gposx(u.x),gposy(u.y),1,1,false,flp)
end

function draw_unit_horiz(u)
	local sp=u.spr+1
	local flp=false
	if(u.facing==3) flp=true
	
	spr(sp,gposx(u.x),gposy(u.y),1,1,flp,false)
end

--misc functions

function is_unit_alive(e)
	if(e.hp<=0) then return false
	else return true
	end
end