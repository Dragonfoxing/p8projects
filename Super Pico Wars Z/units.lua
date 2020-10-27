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
unit.moved=false
unit.attacked=false
unit.hardened=false
unit.damaged=false
unit.move=2
unit.wepdmg=2
unit.weprng=6
unit.dist=0
unit.close=nil

unit.new = function(name,spr,hp,sh,move,rng,dmg)
	_u = copy(unit)
	_u.name=name
	_u.spr=spr
	_u.hp=hp
	_u.sh=sh
	_u.move=move
	_u.weprng=rng
	_u.wepdmg=dmg

	return _u
end

ini_coords={}

units={}

unit_count=4

--init

function init_units()
	local coords=init_unit_coords()
	--get our coords
	for i=0,unit_count-1,1 do
		local u=u_fabs.rnd()
		u.player=true
		u.name=u.name..(i+1)
		u.teamspr=29
		local c=del(coords,coords[1])
		u.x=flr(c/grid)
		u.y=flr(c%grid)
		u.facing=flr(rnd(4))
		add(units,u)
	end
	
	for i=0,unit_count-1,1 do
		local u=u_fabs.rnd()
		u.player=false
		u.teamspr=28
		u.name=u.name..(i+1)
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
		
		if(not has(coords,pos)) then
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
		
		spr(u.teamspr, gptox(u.x), gptoy(u.y))
		if(u==selected) spr(11,gptox(u.x),gptoy(u.y))
		if(not is_unit_idle(u) and u.player) spr(27,gptox(u.x),gptoy(u.y))
		if(u.hardened) spr(59,gptox(u.x),gptoy(u.y))
	end
end

function draw_unit_vert(u)
	local sp=u.spr
	local flp=false
	if(u.facing==2) flp=true
	
	spr(sp,gptox(u.x),gptoy(u.y),1,1,false,flp)
end

function draw_unit_horiz(u)
	local sp=u.spr+1
	local flp=false
	if(u.facing==3) flp=true
	
	spr(sp,gptox(u.x),gptoy(u.y),1,1,flp,false)
end

--misc functions

function damage_unit(u,n)
	-- set up damage value and message string
	msg=""
	dmg=0

	-- if there's shields, do damage to them
	if(u.sh>0) then
		-- do less damage if hardened
		--backslash = int div
		if(u.hardened) then 
			dmg=n\2
		else dmg=n
		end
		-- do damage
		u.sh-=dmg
		-- set up message
		msg=get_unit_name_str(u).."took "..tostr(dmg).." to shields."
		-- if shields were broken by this attack,
		-- set them to 0 and change the message
		if(u.sh<=0) then 
			u.sh=0
			msg=get_unit_name_str(u).." was stripped of shields!"
		end
	-- else do damage to hp
	else 
		u.hp -= n 
		msg=get_unit_name_str(u).." took "..tostr(dmg).." to its hull."
	end
	u.damaged=true
	if(not is_unit_alive(u)) then 
		del(units,u)
		msg=get_unit_name_str(u).." was destroyed!"
	end

	-- add the results to the log
	log.add(msg)
end

function move_unit(u,x,y)
	u.x=x
	u.y=y
	u.moved=true
end

function is_unit_alive(e)
	if(e.hp<=0) then return false
	else return true
	end
end

function is_unit_idle(u)
	if(not u.moved or not u.attacked) then return false
	else return true end
end

function get_next_ready_unit(player)
	for u in all(units) do
        if(u.player==player and not is_unit_idle(u)) then 
            return u 
        end
    end
end

function get_unit_name_str(u)
	local team=""
	if(u.player) then team="(pl)"
	else team="(en)"
	end

	return u.name..team
end

function is_team_dead(player)
	for u in all(units) do
		if(u.player==player) return false
	end

	return true
end

function ready_units(player)
	for u in all(units) do
		if(u.player==player) then
			u.moved=false
			u.attacked=false
			u.hardened=false
			if(not u.damaged and u.sh<8) then u.sh+=1
			elseif(u.damaged) then u.damaged=false end
		end
	end
end

function harden_shields(u)
	u.moved=true
	u.attacked=true
	u.hardened=true
end