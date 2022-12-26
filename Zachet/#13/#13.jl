using HorizonSideRobots

function ch!(robot)
    numSud,numWest=tocorner!(robot)
    snake!(robot, (Ost,Nord))
    tocorner!(robot)
    firstplace!(robot,Nord,numSud)
    firstplace!(robot,Ost,numWest)
end

function firstplace!(robot,side,num_steps)
    for _ in 1:num_steps
        move!(robot,side)
    end
end

function tocorner!(robot)
    numvert=0
    numhori=0
    while !isborder(robot,West) || !isborder(robot,Sud)
        if isborder(robot,West)
            move!(robot,Sud)
            numvert+=1
        else
            move!(robot,West)
            numhori+=1
        end
    end
    return numvert, numhori
end

function along!(robot, side)
    a=0
    while try_move!(robot, side) 
        if (a%2==0)
            putmarker!(robot)
        end
        a+=1
    end
end

function snake!(robot,(side,side1))
    along!(robot, side)
    while try_move!(robot, side1)
        side = inverse(side)
        along!(robot, side)
    end
end
function try_move!(robot, side)
    if isborder(robot, side)
       return false
    else 
        move!(robot, side)
        return true
    end
end
function snake!(stop_condition::Function, robot, (move_side, next_row_side)::NTuple{2,HorizonSide} = (Nord, Ost))
    along!(stop_condition, robot, move_side)
    while !stop_condition(move_side) && try_move!(robot, next_row_side)
        move_side = inverse(move_side)
        along!(stop_condition, robot, move_side)
    end
end

try_move!(robot, direct) = (!isborder(robot, direct) && (move!(robot, direct); return true); false)
inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)
snake!(robot, (side, side1)::NTuple{2,HorizonSide}=(Ost, Nord)) = snake!(() -> false, robot, (side1, side))