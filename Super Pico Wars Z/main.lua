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

--0=player,1=enemy
turn=0
--0=move,1=attack,2=harden
command=0
--0=pturn,1=pmove,2=patk,3=enemy
phase=0

function _init()
	init_units()
    phase=0
    turn=0
	check_hovered()
end

function _update()
	frame_update()
	
    if(phase<3) then loop_player_turn()
	else loop_enemy_turn()
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
	draw_units()
	
	if(phase<3) then
		if(phase==1) then drawmove()
		elseif(phase==2) then drawfirelist()
		end
	end
	
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
	_draw_optionbox()
	--display_unit_data()
end