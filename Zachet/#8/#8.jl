using HorizonSideRobots

function findmarker!(robot)
    num_steps=1
    side=Nord
    while !ismarker(robot)
        for _ in 1:2
            marker!(robot,side,num_steps)
            side=next(side)
        end
        num_steps=num_steps+1
    end
end

function marker!(robot,side,num_steps)
    for _ in 1:num_steps
        if !ismarker(robot)
            move!(robot,side)
        else
            break
        end
    end
end

next(side::HorizonSide)=HorizonSide((Int(side)+1)%4)