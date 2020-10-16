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
		
		check_hovered()
	end
end

function update_cursor_spr()
	if frame==0 then cursor_spr = 13
	elseif frame==8 then cursor_spr = 12
	end
end

function move_cursor()
	if btnp(1) and px<grid-1 then 
		px+=1
		o.x+=gxy
		camera(o.x,o.y)
	elseif btnp(0) and px>0 then 
		px-=1
		o.x-=gxy
		camera(o.x,o.y)	
	end
	
	if btnp(2) and py>0 then 
		py-=1
		o.y-=gxy
		camera(o.x,o.y)
	elseif btnp(3) and py<grid-1 then 
		py+=1
		o.y+=gxy
		camera(o.x,o.y)
	end
end

function check_hovered()
	hovered=nil
	
	for u in all(units) do
		if(u.x==px and u.y==py) hovered=u
	end
end