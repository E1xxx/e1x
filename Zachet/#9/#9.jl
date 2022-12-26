using HorizonSideRobots

function chess!(robot)
    numSud,numWest=tocorner!(robot)
    side=Ost
    if numSud%2==1 || numWest%2==1
        while !isborder(robot,side)
            move!(robot,side)
            putmarker!(robot)
            if !isborder(robot,side)
                move!(robot,side)
            end
            if isborder(robot,side) && !isborder(robot,Nord)
                side=inverse(side)
                move!(robot,Nord)
            end
        end
    else
        while !isborder(robot,side)
            putmarker!(robot)
            move!(robot,side)
            if !isborder(robot,side)
                move!(robot,side)
            end
            if isborder(robot,side) && !isborder(robot,Nord)
                side=inverse(side)
                move!(robot,Nord)
                putmarker!(robot)
            end
        end
    end
    tocorner!(robot)
    firstplace!(robot,Nord,numSud)
    firstplace!(robot,Ost,numWest)
end

function tocorner!(robot)
    numvert=0
    numhori=0
    while !isborder(robot,West)||!isborder(robot,Sud)
        if  isborder(robot,West)
            move!(robot,Sud)
            numvert+=1
        else
            move!(robot,West)
            numhori+=1
        end
    end
    return numvert,numhori
end

function firstplace!(robot,side,num_steps)
    for _ in 1:num_steps
        move!(robot,side)
    end
end

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)