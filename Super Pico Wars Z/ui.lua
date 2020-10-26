--UI

--defunct game frame drawcall
function _drawgameframe()
	color(2)
	line(o.x,o.y,o.x,o.y+127)
	line(o.x+127,o.y,o.x+127,o.y+127)
	line(o.x,o.y,o.x+127,o.y)
	line(o.x,o.y+127,o.x+127,o.y+127)
	color(7)
	--debug diagonals
	--line(0,0,127,127)
	--line(0,127,127,0)
end

function _draw_battleground_bg()
	for x=0,grid-1 do
		for y=0,grid-1 do
			spr(56,gposx(x),gposy(y))
		end
	end

end
--battle borders drawcall
function _drawborders()
	rect(gxoff-1,gyoff-1,gxoff+grid*8,gyoff+grid*8)
	
end

-- defunct draw call
function _draw_messagebox()
 --bottom panel
	--[[
	line(0,127,127,127)
	line(0,96,127,96)
	line(0,96,0,127)
	line(127,96,127,127)
	--]]

	rectfill(o.x,o.y+64,o.x+127,o.y+127,1)
	color(7)
	rect(o.x,o.y+64,o.x+127,o.y+127)

	if(#log!=0) then
		for i=1,#log do
			print(log[i],o.x+4,o.y+62+(6*i))
		end
	end
end

--commands&option draw calls

function _draw_commandbox()
	--bg & color reset
	rectfill(o.x+96,o.y+96,o.x+127,o.y+127,1)
	color(7)
	--borders
	rect(o.x+96,o.y+96,o.x+127,o.y+127)
	
	if(cmd_pos==0 and not hovered.moved) then 
		print("move",o.x+98,o.y+99,8)
		color(7)
	elseif(hovered.moved) then
		print("move",o.x+98,o.y+99,0)
		color(7)

	else print("move",o.x+98,o.y+99) end
	if(cmd_pos==1 and not hovered.attacked) then
		print("attack",o.x+98,o.y+106,8)
		color(7)
	elseif(hovered.attacked) then
		print("attack",o.x+98,o.y+106,0)
		color(7)
	else print("attack",o.x+98,o.y+106) end
	if((selected.moved or selected.attacked)) then
		print("defend",o.x+98,o.y+113,0)
		color(7)
	elseif(cmd_pos==2) then
		print("defend",o.x+98,o.y+113,8)
		color(7)
	else print("defend",o.x+98,o.y+113) end
	if(cmd_pos==3) then
		print("pass",o.x+98,o.y+120,8)
		color(7)
	else print("pass",o.x+98,o.y+120) end
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
	rectfill(o.x+96,o.y+96,o.x+127,o.y+106,1)
	color(7)

	rect(o.x+96,o.y+96,o.x+127,o.y+106)

	if(opt_pos==0) then
		print("restart",o.x+98,o.y+99,8)
		color(7)
	else print("restart",o.x+98,o.y+99) end
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
	print(str,o.x+4,o.y+3)
end

function _topbar_brd()
	--bg fill
 rectfill(o.x,o.y,o.x+127,o.y+10,1)
 color(7)
	--borders
	line(o.x,o.y,o.x+127,o.y)
	line(o.x,o.y+10,o.x+127,o.y+10)
	line(o.x,o.y,o.x,o.y+10)
	line(o.x+127,o.y,o.x+127,o.y+10)
end

function show_game_over()
	if(turn==0) then
		print("you won! :D", 45, 90)
	elseif(turn==1) then
		print("You lost! D:", 44, 90)
	end

	print("press (c)onfirm to play again!", 4, 100)
end

function show_game_main_menu()
	_drawgameframe()
	spr(18,57,39)
	spr(37,49,39)
	spr(46,31,31,2,2)
	color(7)
	print("super pico", 50,32)
	print("wars z", 66, 41)
	color(6)

end