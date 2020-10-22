--cursor
cursor_spr = 13

function draw_cursor()
	spr(cursor_spr,gposx(c.x),gposy(c.y))
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
		
		check_hovered()
	end
end

function update_cursor_spr()
	if fr.c==0 then cursor_spr = 13
	elseif fr.c>fr.m\2 then cursor_spr = 12
	end
end

function move_cursor()
	if btnp(1) and c.x<grid-1 then 
		c.x+=1
		o.x+=gxy
		camera(o.x,o.y)
	elseif btnp(0) and c.x>0 then 
		c.x-=1
		o.x-=gxy
		camera(o.x,o.y)	
	end
	
	if btnp(2) and c.y>0 then 
		c.y-=1
		o.y-=gxy
		camera(o.x,o.y)
	elseif btnp(3) and c.y<grid-1 then 
		c.y+=1
		o.y+=gxy
		camera(o.x,o.y)
	end
end

function check_hovered()
	hovered=nil
	
	for u in all(units) do
		if(u.x==c.x and u.y==c.y) hovered=u
	end
end