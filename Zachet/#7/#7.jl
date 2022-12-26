using HorizonSideRobots

function proxod!(robot)
    while !isborder(robot,Nord)
        move!(robot,Nord)
    end
    imax,jmax=r.situation.frame_size
    numberi=10
    side=Ost
    while isborder(robot,Nord)
        move!(robot,side)
        numberi+=1
        if (numberi>=imax)
            side=inverse(side)
            numberi=0
        end
    end
end

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)