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

game_over=false
--0=player,1=enemy
turn=0
--0=move,1=attack,2=harden,3=pass/prep,nil=nil
command=nil
--0=pturn,1=pmove,2=patk,3=enemy
phase=0

function _init()
	init_units()
    phase=0
    turn=0
    command=nil
	check_hovered()
end

function _update()
	frame_update()]

	if(not game_over) then
		if(is_team_dead(true)) then
			turn=1
			game_over=true
		elseif(is_team_dead(false)) then
			turn=0
			game_over=true
		elseif(turn==0) then loop_player_turn()
		else loop_enemy_turn() end
	else
		if(btnp(4)) then reset_game() end
	end
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

	draw_cursor()
	
	draw_units()
	
	if(not game_over) then

		if(turn==0) then
			if(command==0) then drawmove()
			elseif(command==1) then drawfirelist()
			end
		end

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
	else
		show_game_over()
	end
end