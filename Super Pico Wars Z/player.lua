--player controls?

function player_update()
    --[[If we're not doing anything,
    and the cancel button is hit,
    bring up the options menu
    ]]
    if(not show_opts and not show_cmds and btnp(5)) then
        show_opts=true
    elseif(command==0 and not show_opts and hovered!=nil and btnp(4)) then
        show_cmds=true
        if(hovered.moved) then cmd_pos=1 end
    end

    --[[when program flow calls this after
    the options or command menu, we can act
    on the commands
    ]]
    if(command==0) then

    elseif(command==1) then

    elseif(command==2) then

    end
end

function handle_commands_menu()
    if(btnp(3) and cmd_pos<cmd_pos_max) then
        if(cmd_pos==0 and hovered.attacked) then cmd_pos+=2
        else cmd_pos+=1 end
    elseif(btnp(2) and cmd_pos>0) then
        if(cmd_pos==1 and hovered.moved) then return
        elseif(cmd_pos==2 and hovered.attacked) then
            cmd_pos-=2
        else cmd_pos-=1 end
    end

    if(btnp(5)) then
        show_cmds=false
        command=0
        return
    end

    if(btnp(4)) then
        show_cmds=false
        command=cmd_pos
        selected=hovered
        return
    end
    --TODO: handle doing commands
end