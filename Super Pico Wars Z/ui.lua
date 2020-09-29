--UI

--defunct game frame drawcall
function _drawgameframe()
	line(0,0,0,127)
	line(127,0,127,127)
	line(0,0,127,0)
	line(0,127,127,127)
	--debug diagonals
	--line(0,0,127,127)
	--line(0,127,127,0)
end
    
--battle borders drawcall
function _drawborders()
	--battlefield horizontal
	line(gxoff,gyoff-1,gxoff+gxy*8,gyoff-1)
	line(gxoff,gyoff+gxy*8,gxoff+gxy*8,gyoff+gxy*8)
	--battlefield vertical
	line(gxoff-1,gyoff-1,gxoff-1,gyoff+gxy*8)
	line(gxoff+gxy*8,gyoff-1,gxoff+gxy*8,gyoff+gxy*8)
end

-- defunct draw call
function _draw_messagebox()
 --bottom panel
	line(0,127,127,127)
	line(0,96,127,96)
	line(0,96,0,127)
	line(127,96,127,127)
end

--commands&option draw calls

function _draw_commandbox()
	--bg & color reset
	rectfill(96,96,127,127,1)
	color(7)
	--borders
	line(96,96,127,96)
	line(96,96,96,127)
	line(127,96,127,127)
	line(96,127,127,127)
	
	if(cmd_pos==0 and not hovered.moved) then 
		print("move",98,99,8)
		color(7)
	elseif(hovered.moved) then
		print("move",98,99,0)
		color(7)

	else print("move",98,99) end
	if(cmd_pos==1 and not hovered.attacked) then
		print("attack",98,106,8)
		color(7)
	elseif(hovered.attacked) then
		print("attack",98,106,0)
		color(7)
	else print("attack",98,106) end
	if((selected.moved or selected.attacked)) then
		print("defend",98,113,0)
		color(7)
	elseif(cmd_pos==2) then
		print("defend",98,113,8)
		color(7)
	else print("defend",98,113) end
	if(cmd_pos==3) then
		print("pass",98,120,8)
		color(7)
	else print("pass",98,120) end
end

function _draw_optionbox()
	--bg & color reset
	--[[ leaving this here for when
	--I have more options
	rectfill(96,96,127,127,1)
	color(7)
	--borders
	line(96,96,127,96)
	line(96,96,96,127)
	line(127,96,127,127)
	line(96,127,127,127)
	]]
	rectfill(96,96,127,106,1)
	color(7)

	rect(96,96,127,106)

	if(opt_pos==0) then
		print("restart",98,99,8)
		color(7)
	else print("restart",98,99) end
	--print("",98,106)
	--print("harden",98,113)
	--print("prepare",98,120)
end

--combat draw calls

function drawmove()
	for pos in all(movelist) do
		spr(61,gposx(pos[1]),gposy(pos[2]))
	end
end



function drawfirelist()
	for e in all(movelist) do
		spr(43,gposx(e.x),gposy(e.y))
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
	
	str=u.name..team..";sh:"..u.sh..";hp:"..u.hp..";move:"..u.move
	print(str,4,3)
end

function _topbar_brd()
	--bg fill
 rectfill(0,0,127,10,1)
 color(7)
	--borders
	line(0,0,127,0)
	line(0,10,127,10)
	line(0,0,0,10)
	line(127,0,127,10)
end

function show_game_over()
	if(turn==0) then
		print("you won! :D", 45, 90)
	elseif(turn==1) then
		print("You lost! D:", 44, 90)
	end

	print("press (c)onfirm to play again!", 4, 100)
end