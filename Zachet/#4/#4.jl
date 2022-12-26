using HorizonSideRobots

function crest!(robot)
    putmarker!(robot)
    for side in (Nord,West,Sud,Ost)
        n=mark_crest!(robot,side)
        (robot,inverse(side),n)
    end
end

function mark_crest!(robot,side)
    num_steps=0
    while !isborder(robot,side) && !isborder(robot,next(side))
        move!(robot,side)
        move!(robot,next(side))
        putmarker!(robot)
        num_steps+=1
    end
    return num_steps
end

function along!(robot,side,num_steps)
    for _ in 1:num_steps
        move!(robot,side)
        move!(robot,next(side))
    end
end

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)
next(side::HorizonSide)=HorizonSide((Int(side)+1)%4)