--message box

log={}
log.max=9

m={s="",i=0}

log.add = function(msg)

    --if we'll be full, clear space
    if(#log>log.max+1) then
        --delete at index
        deli(log,1)
    end

    add(log,msg)
    
end

