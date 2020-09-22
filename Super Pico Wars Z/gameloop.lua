--Game Loop

function test_enemy_turn()
	if(frame==8) then
		if(check_if_out_of_moves(false)) then
			end_eturn()
		else
			enemy_move_closest()
		end
	end
end

function pturn_loop()
	update_cursor()
end

function pturn_end()
	for u in all(units) do
		if(not u.player) then u.idle=false end
	end
	
	phase=3
end

function eturn_loop()
	test_enemy_turn()
	--if(check_if_out_of_moves(false)) end_eturn()
	--enemy_move_closest()
	--if(check_if_out_of_moves(false)) then end_eturn() end
end

function end_eturn()
	for u in all(units) do
		if(u.player) u.idle=false
	end
	
	phase=0
end