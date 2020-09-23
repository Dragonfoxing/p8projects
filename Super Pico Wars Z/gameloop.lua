--Game Loop

function test_enemy_turn()
	if(frame==8) then
		if(check_if_out_of_moves(false)) then
			end_enemy_turn()
		else
			enemy_move_closest()
		end
	end
end

function loop_player_turn()
	if(not show_cmds) then
		update_cursor()
		player_update()
	else if(show_cmds) then handle_commands_menu() end
end

function end_player_turn()
	ready_units(false)

	phase=3
	turn=1
	command=0
end

function loop_enemy_turn()
	test_enemy_turn()
	--if(check_if_out_of_moves(false)) end_eturn()
	--enemy_move_closest()
	--if(check_if_out_of_moves(false)) then end_eturn() end
end

function end_enemy_turn()
	ready_units(true)
	
	phase=0
	turn=0
	command=0
end