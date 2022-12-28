function find_marker!(r::Robot)
    tmp = (side::HorizonSide) -> ismarker(r)
    spiral!( tmp, r)
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
