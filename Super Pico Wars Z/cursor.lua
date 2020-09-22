--cursor
cursor_spr = 13

function draw_cursor()
	spr(cursor_spr,gposx(px),gposy(py))
end

function cursor_moved()
	if(btnp(0) or btnp(1) or btnp(2) or btnp(3)) do return true
	else return false
	end
end

function update_cursor()
	update_cursor_spr()
	move_cursor()
	
	if(cursor_moved()) do
		--check if unit underneath
		hovered=nil
		
		check_hovered()
	end
		
	if(phase==0) then
		if(btnp(4) and hovered!=nil and hovered.player and not hovered.idle) then
		 selected=hovered
		 phase=1
		 get_movelist()
		end
	elseif(phase==1) then
		if(btnp(4) and contains_move(px,py)) then
			selected.x=px
			selected.y=py
			
			movelist=nil
			
			getfirelist(true)
			
			check_hovered()
			phase=2
		elseif(btnp(5)) then
			selected=nil
			phase=0
			hovered=nil
			movelist=nil
			check_hovered()
		end
	elseif(phase==2) then
		--selecting own self for dmg
		--ends ship selection, no dmg
		if(btnp(4) and hovered==selected) then
			selected.idle=true
			selected=nil
			hovered=nil
			check_hovered()
			if(check_if_out_of_moves(true)==true) then phase=3
			else
				phase=0
			end
		elseif(btnp(4) and contains_target(hovered)) then
			hovered.hp-=selected.wepdmg
			if(not is_unit_alive(hovered)) then
				del(units,hovered)
			end
			
			selected.idle=true
			selected=nil
			hovered=nil
			movelist=nil
			
			check_hovered()
			if(check_if_out_of_moves(true)==true) then phase=3
			else
				phase=0
			end
		end
	end
end

function update_cursor_spr()
	if frame==0 then cursor_spr = 13
	elseif frame==8 then cursor_spr = 12
	end
end

function move_cursor()
	if btnp(1) and px<grid then px+=1
	elseif btnp(0) and px>0 then px-=1
	end
	
	if btnp(2) and py>0 then py-=1
	elseif btnp(3) and py<grid then py+=1
	end
end

function check_hovered()
	for u in all(units) do
		if(u.x==px and u.y==py) hovered=u
	end
end