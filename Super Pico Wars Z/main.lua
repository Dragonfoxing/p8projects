--MAIN
--64x64 = center
px=0
py=0

gxy=8
gxoff=32
gyoff=20
frame=0

grid=8

hovered=nil
selected=nil
movelist=nil

err=false
debug=false

show_opts=false
show_cmds=false

cmd_pos=0
cmd_pos_max=3
opt_pos=0
opt_pos_max=0

--0=player,1=enemy
turn=0
--0=nothing,1=move,2=attack,3=defend?
command=0
--0=pturn,1=pmove,2=patk,3=enemy
phase=0

function _init()
	init_units()
    phase=0
    turn=0
    command=0
	check_hovered()
end

function _update()
	frame_update()
	
	if(turn==0) then loop_player_turn()
	else loop_enemy_turn() end

	--[[
    if(phase<3) then loop_player_turn()
	else loop_enemy_turn()
	end
	]]
end

function frame_update()
	--frame stuff
	if frame==15 then frame=0
	else frame+=1
	end
end

function _draw()
	cls()

	_drawborders()
	draw_units()
	
	if(turn==0) then
		if(command==1) then drawmove()
		elseif(command==2) then drawfirelist()
		end
	end

	--[[
	if(phase<3) then
		if(phase==1) then drawmove()
		elseif(phase==2) then drawfirelist()
		end
	end
 ]]

	draw_cursor()
	
	_display_topbar()
	
	if(debug) then
		local e_idle=0
	
		for u in all(units) do
			if(not u.player and not u.idle) then e_idle+=1 end
		end

		print("phase:"..phase)
		print("units:"..#units)
		print("idle enemies:"..e_idle)
		if(err) print("error encountered!")
		if(movelist) print("moves:"..#movelist)
	end
	
	--_draw_commandbox()
    if(show_opts) then _draw_optionbox()
    elseif(show_cmds) then _draw_commandbox() end
	--display_unit_data()
end