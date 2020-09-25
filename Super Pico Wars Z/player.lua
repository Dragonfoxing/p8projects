--player controls?

function player_update()
    --[[If we're not doing anything,
    and the cancel button is hit,
    bring up the options menu
    ]]
    if(command==nil and btnp(4) and hovered!=nil and not show_opts and not is_unit_idle(hovered)) then
        if(not hovered.player) then return end
        show_cmds=true
        selected=hovered
        if(selected.moved) then cmd_pos=1 end
    elseif(command==nil and btnp(5) and not show_cmds) then
        show_opts=true
    end
    --[[
    if(not show_opts and not show_cmds and btnp(5)) then
        show_opts=true
    elseif(command==nil and not show_opts and hovered!=nil and btnp(4)) then
        --if(is_unit_idle(hovered)) then return end
        show_cmds=true
        if(hovered.moved) then cmd_pos=1 end
    end
    ]]
    --[[when program flow calls this after
    the options or command menu, we can act
    on the commands
    ]]
    if(command==0) then
        if(btnp(4) and contains_move(px,py)) then
            move_unit(selected,px,py)
            px=selected.x
            py=selected.y
            selected=nil
            movelist=nil
            command=nil

            cmd_pos=0
            check_hovered()
        elseif(btnp(5)) then
            px=selected.x
            py=selected.y

            selected=nil
            movelist=nil
            command=nil

            cmd_pos=0
            check_hovered()
        end
    elseif(command==1) then
        if(btnp(4) and contains_target(hovered)) then
            damage_unit(hovered, selected.wepdmg)
            selected.attacked=true
            px=selected.x
            py=selected.y
            selected=nil
            movelist=nil
            command=nil

            cmd_pos=0
            check_hovered()
        elseif(btnp(5)) then
            selected=nil
            movelist=nil
            command=nil

            cmd_pos=0
            check_hovered()
        end
    elseif(command==2) then
        
    elseif(command==3) then

    end
end

function handle_commands_menu()
    if(btnp(3) and cmd_pos<cmd_pos_max) then
        if(cmd_pos==0 and selected.attacked) then cmd_pos+=3
        elseif(cmd_pos==1 and (selected.attacked or selected.moved)) then cmd_pos+=2
        else cmd_pos+=1 end
    elseif(btnp(3) and cmd_pos==cmd_pos_max) then
        if(selected.moved) then cmd_pos=1
        else cmd_pos=0 end
    elseif(btnp(2) and cmd_pos>0) then
        if(cmd_pos==1 and selected.moved) then return
        elseif(cmd_pos==2 and selected.attacked) then cmd_pos-=2
        elseif(cmd_pos==3 and selected.attacked) then cmd_pos-=3
        else cmd_pos-=1 end
    elseif(btnp(2) and cmd_pos==0) then cmd_pos=cmd_pos_max
    end
    
    if(btnp(5)) then
        show_cmds=false
        selected=nil
        command=nil
        return
    end

    if(btnp(4)) then
        show_cmds=false
        if(cmd_pos==0 and selected.moved) then
            cmd_pos=1
            return
        elseif(cmd_pos==1 and selected.attacked) then
            cmd_pos=0
            return
        elseif(cmd_pos==2 and (selected.moved or selected.attacked)) then
            cmd_pos=3
            return
        end

        command=cmd_pos
        
        if(command==0) then
            get_movelist()
        elseif(command==1) then
            getfirelist(true)
        elseif(command==2) then
            harden_shields(selected)
            selected=nil
            command=nil
            cmd_pos=0
            check_hovered()
        elseif(command==3) then
            --just doing "pass" for now
            selected.moved=true
            selected.attacked=true
            selected=nil
            command=nil
            cmd_pos=0
            check_hovered()
        end

        return
    end
    --TODO: handle doing commands
end

function handle_options_menu()
    if(btnp(5)) then show_opts=false end
end