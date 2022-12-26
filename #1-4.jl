#1
function mark_kross!(r::Robot) 
    for side in (HorizonSide(i) for i=0:3) 
        putmarkers!(r,side)
        move_by_markers(r,inverse(side))
    end
    putmarker!(r)
end


putmarkers!(r::Robot,side::HorizonSide) = 
while isborder(r,side)==false 
    move!(r,side)
    putmarker!(r)
end


move_by_markers(r::Robot,side::HorizonSide) = 
while ismarker(r)==true 
    move!(r,side) 
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))
#2

function mark_perimetr!(r::Robot)
    steps_to_left_down_angle = [0, 0]
    steps_to_left_down_angle[1] = move_until_border!(r, Sud) #шаг вниз
    steps_to_left_down_angle[2] = move_until_border!(r, West) #шаг вправо
    for side in (Nord, Ost, Sud, West)
        putmarkers_until_border!(r, side)
    end
    moves!(r, Ost, steps_to_left_down_angle[2])
    moves!(r, Nord, steps_to_left_down_angle[1])
end


function get_left_down_angle!(r::Robot)::NTuple{2, Int} #в левый нижний
    steps_to_left_border = move_until_border!(r, West)
    steps_to_down_border = move_until_border!(r, Sud)
    return (steps_to_down_border, steps_to_left_border)
end

function get_to_origin!(r::Robot, steps_to_origin::NTuple{2, Int})
    for (i, side) in enumerate((Nord, Ost))
        moves!(r, side, steps_to_origin[i])
    end
end
#3

function mark_fild!(r::Robot)
    steps_to_origin = get_left_down_angle!(r) #идёт в левый нижний угол
    putmarker!(r)
    while !isborder(r, Ost)
        putmarkers_until_border!(r,Nord) #ставит маркеры вверх до упора
        move!(r, Ost)
        putmarker!(r)
        putmarkers_until_border!(r, Sud)
    end
    get_left_down_angle!(r)
    get_to_origin!(r, steps_to_origin)
end


function putmarkers_until_border!(r::Robot, sides::NTuple{2, HorizonSide})::Int #ставит маркеры до границы
    n_steps = 0
    while !isborder(r, sides[1]) && !isborder(r, sides[2])
        n_steps += 1
        move!(r, sides)
        putmarker!(r)
    end
    return n_steps
end

function moves!(r::Robot, sides::NTuple{2, HorizonSide}, n_steps::Int) 
    for _ in 1:n_steps
        move!(r, sides)
    end
end

function move!(r::Robot, sides::NTuple{2, HorizonSide})
    for side in sides
        move!(r, side)
    end
end

function inverse_side(sides::NTuple{2, HorizonSide})
    new_sides = (inverse_side(sides[1]), inverse_side(sides[2]))
    return new_sides
end

#4

function X_mark_the_spot!(r::Robot) 
    sides = (Nord, Ost, Sud, West)
    for i in 1:4
        first_side = sides[i] 
        second_side = sides[i % 4 + 1]
        direction = (first_side, second_side)
        n_steps = putmarkers_until_border!(r, direction)
        moves!(r, inverse_side(direction), n_steps)
    end
    putmarker!(r)
end
