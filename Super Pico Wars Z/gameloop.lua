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
	if(check_if_out_of_moves(true)) then end_player_turn() end
	if(not show_cmds and not show_opts) then
		update_cursor()
		player_update()
	elseif(show_cmds) then handle_commands_menu()
	elseif(show_opts) then handle_options_menu() end
end

function end_player_turn()
	ready_units(false)

	turn=1
	command=nil
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
	command=nil
end