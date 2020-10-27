--font
font={}
font.w=4
font.h=6
--characters per line
font.chl=32

--text cursor
txc={}
txc.x=0
txc.y=0

--frames, current and max
fr={}
fr.c=0
fr.m=31

--c = cursor pos table
c={x=0,y=0}
--o = camera offset table
o={x=0,y=0}

gxy=8
gxoff=32
gyoff=20

--unit prefabs
u_fabs={}

u_fabs.rnd = function()
    return copy(u_fabs[flr(rnd(#u_fabs))+1])
end

--corvette, low hp med shields but fast
add(u_fabs,unit.new("corv",20,4,2,4,2,2))
--frigate, high hp/shields, low damage/move, high range
add(u_fabs,unit.new("frig",20,6,10,2,5,2))