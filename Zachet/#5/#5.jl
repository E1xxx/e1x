using HorizonSideRobots

function fas!(robot)
    num_West1, num_Sud1=tocorner!(robot)
    for side in (Ost,Nord,West,Sud)
        Out!(robot,side)
    end
    findborder!(robot,Nord,Ost)
    In!(robot)
    tocorner!(robot)
    moves!(robot,Nord,num_Sud1)
    moves!(robot,Ost,num_West1)
end

function In!(robot)
    side=Ost
    while !isborder(robot,side) && isborder(robot,next(side))
        putmarker!(robot)
        move!(robot,side)
        if !isborder(robot,side) && !isborder(robot,next(side))
            putmarker!(robot)
            side=next(side)
            move!(robot,side)
            if side==Ost
                break
            end
        end
    end
    while isborder(robot,next(side))
        putmarker!(robot)
        move!(robot,side)
    end
end

function Out!(robot,side)
    while !isborder(robot,side)
        putmarker!(robot)
        move!(robot,side)
    end
end

function findborder!(robot,sideb,sidem)
    while isborder(robot,sideb)==false
        if isborder(robot,sidem)==false
            move!(robot,sidem)
        else
            move!(robot,sideb)
            sidem=inverse(sidem)
        end
    end
end

function tocorner!(robot)
    num_West=0
    num_Sud=0
    while !isborder(robot,West)||!isborder(robot,Sud)
        if isborder(robot,West)
            move!(robot,Sud)
            num_Sud+=1
        else
            move!(robot,West)
            num_West+=1
        end
    end
    return num_West, num_Sud
end

function moves!(robot,side,num_steps)
    for _ in 1:num_steps
        move!(robot,side)
    end
end

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)
next(side::HorizonSide)=HorizonSide((Int(side)+1)%4)