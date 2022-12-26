using HorizonSideRobots

function cross!(robot)
    putmarker!(robot)
    for side in (Nord,West,Sud,Ost)
        n=markperimeter!(robot,side)
        along!(robot, inverse(side), n)
    end    
end 

function markperimeter!(robot,side)
    num_steps=0
    while !isborder(robot,side)
        move!(robot,side)
        num_steps+=1
        putmarker!(robot)
    end 
    return num_steps
end

function along!(robot,side,num_steps)
    for _i in 1:num_steps
        move!(robot,side)
    end    
end    

inverse(side::HorizonSide) = HorizonSide((Int(side) +2)% 4)