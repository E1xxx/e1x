using HorizonSideRobots

function n17!(robot)
    spiral!(robot,_->ismarker(robot))
end

function spiral!(robot, stop_condition::Function)
    side=Nord
    n=1
    along!(robot, side,n)
    while !stop_condition(robot)
        for _ in 1:2
            along!(robot, side, n)
            side = next(side)
        end
        n += 1
    end
end

function try_move!(robot,side, stop_condition::Function)
    if !isborder(robot,side) && !stop_condition(robot)
        move!(robot,side)
        return true
    else
        return false
    end
end

function along!(robot, side,max_num_steps)
    
    num_steps=0
    while try_move!(robot,side, _ -> ismarker(robot)) && num_steps<max_num_steps
        num_steps+=1
    end
end

function aroundline!(robot,side,n)
    for _ in 1:n
        move!(robot,side)
    end
end


next(side::HorizonSide)=HorizonSide((Int(side)+1)%4)