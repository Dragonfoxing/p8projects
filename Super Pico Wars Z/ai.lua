--AI

function check_if_out_of_moves(player)
	local b=true
	for u in all(units) do
		if(u.player==player and not is_unit_idle(u)) b=false
	end
	
	return b
end

function get_movelist()
	local ml={}
	local x=selected.x
	local y=selected.y
	local move=selected.move
	local xstep=0
	for i=x-move,x+move,1 do
		if(i>-1 and i<grid) then
			--diamond shape
			xstep=move-abs(x-i)
			
			--reverse diamond
			--xstep=abs(x-i)
			for j=y-xstep,y+xstep,1 do
				if(j>-1 and j<grid) then
					--spr(61,gptox(i),gptoy(j))
					
					add(ml,{i,j})
				end
			end
		end
	end
	
	movelist=check_valid_moves(ml)
end

function check_valid_moves(moves)
	local x=selected.x
	local y=selected.y
	
	for m in all(moves) do
		for u in all(units) do
				if(m[1]==x and m[2]==y) then del(moves,m)
				elseif (m[1]==u.x and m[2]==u.y) then del(moves,m)
			end
		end
	end
	
	return moves
end

function has_move(x,y)
	for m in all(movelist) do
		if(m[1]==x and m[2]==y) return true
	end
	
	return false
end

function getfirelist(player)
	local o = selected
	ml = {}
	for e in all(units) do
		if(not e.player==o.player) then
			b = checkfirerange(o,e)
			if(b==true) add(ml,e)
		end
	end
	
	movelist=ml
end

function has_target(e)
	for m in all(movelist) do
		if(e==m) return true
	end
	
	return false
end

function checkfirerange(e1,e2)
	if(e1==e2) return false
	local xstep=e1.weprng-abs(e1.x-e2.x)
	local ystep=e1.weprng-abs(e1.y-e2.y)
	if(abs(e1.x-e2.x)<=ystep
	and abs(e1.y-e2.y)<=xstep) then
		return true
	else return false
	end
end


function enemy_move_closest()
	--unit and enemy unit
	u = get_next_ready_unit(false)

	if(u==nil) then
		err=true
		return 
	end
	--if(u==nil) then return end
	eu = nil
	for _u in all(units) do
		if(_u.player) then
			_u.dist=get_unit_dist(u,_u)
			if(eu==nil) then eu=_u
			else
				if(_u.dist<eu.dist) then
					eu.dist=0
					eu=_u
				end
			end
		end
	end

	--now we have closest enemy unit
	--if we aren't in range, move
	if(not e_chk_rng(u,eu)) then
		local x=sgn(eu.x-u.x)*u.move
		local y=sgn(eu.y-u.y)*u.move
		
		move_unit(u,x,y)

		--if we aren't still in range,
		--do nothing
		if(not e_chk_rng(u,eu)) then
			u.attacked=true
			return
		else damage_unit(eu,u.wepdmg)
		end
	else damage_unit(eu,u.wepdmg)
	end
	
	u.moved=true
	u.attacked=true
end

-- if target in range then true
-- else false
function e_chk_rng(u,eu)
    local xstep=u.weprng-abs(u.x-eu.x)
    local ystep=u.weprng-abs(u.y-eu.y)
    if(sgn(xstep)<0 or sgn(ystep)<0) then return false
    else return true
    end
end