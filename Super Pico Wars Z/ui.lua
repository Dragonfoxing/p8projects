--UI

--defunct game frame drawcall
function _drawgameframe()
	ro(0,0,127,127,2)
	col(7)
end

function _draw_battleground_bg()
	rf(gxoff,gyoff,gptox(grid),gptoy(grid),1)
	col(7)

end
--battle borders drawcall
function _drawborders()
	r(gxoff-1,gyoff-1,gptox(grid),gptoy(grid))
end

function _draw_messagebox()
	--bg
	rfo(0,64,127,127,1)
	--border
	ro(0,64,127,127,7)

	if(#log!=0) then
		for i=1,#log do
			po(log[i],4,62+(6*i))
		end
	end
end

--commands&option draw calls

function _draw_commandbox()
	--bg
	rfo(96,96,127,127,1)
	--borders
	ro(96,96,127,127,7)
	--move cmd
	if(cmd_pos==0 and not hovered.moved) then po("move",98,99,8)
	elseif(hovered.moved) then po("move",98,99,0)
	else po("move",98,99,7) end
	--atk cmd
	if(cmd_pos==1 and not hovered.attacked) then po("attack",98,106,8)
	elseif(hovered.attacked) then po("attack",98,106,0)
	else po("attack",98,106,7) end
	--def cmd
	if((selected.moved or selected.attacked)) then po("defend",98,113,0)
	elseif(cmd_pos==2) then po("defend",98,113,8)
	else po("defend",98,113,7) end
	--pass cmd
	if(cmd_pos==3) then po("pass",98,120,8)
	else po("pass",98,120,7) end
	--col reset
	col(7)
end

function _draw_optionbox()
	--bg
	rfo(96,96,127,106,1)
	--border
	ro(96,96,127,106,7)

	if(opt_pos==0) then
		po("restart",98,99,8)
		col(7)
	else po("restart",98,99,7) end
end

--combat draw calls

function drawmove()
	for pos in all(movelist) do
		spr(61,gptox(pos[1]),gptoy(pos[2]))
	end
end



function drawfirelist()
	for e in all(movelist) do
		spr(43,gptox(e.x),gptoy(e.y))
	end
end

--topbar UI
--Hovered/Selected unit stats

function _display_topbar()
	local u = nil
	
	if(hovered!=nil) then u=hovered
	elseif(selected!=nil) then u=selected
	end
	
	if(u==nil) then return end
	
	_topbar_brd()
	
	local team=""
	if(u.player) then team="(pl)"
	else team="(en)"
	end
	
	str=u.name..team..";hp:"..u.sh.."/"..u.hp..";mv:"..u.move..";r/d:"..u.weprng.."/"..u.wepdmg
	po(str,4,3,7)
end

function _topbar_brd()
	--bg
	rfo(0,0,127,10,1)
	--border
	rect(o.x,o.y,o.x+127,o.y+10,7)
end

function show_game_over()
	if(turn==0) then
		po("you won! :D",45,90,7)
	elseif(turn==1) then
		po("You lost! D:",44,90,7)
	end

	po("press (c)onfirm to play again!",4,100,7)
end

function show_game_main_menu()
	_drawgameframe()
	spr(18,57,39)
	spr(37,49,39)
	spr(46,31,31,2,2)
	po("super pico",50,32,7)
	po("wars z", 66, 41,7)
	color(6)

end