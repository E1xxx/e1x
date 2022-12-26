#6(а)
function mark_perimetr_with_inner_border!(r::Robot)
    path = get_left_down_angle_modified!(r)
    mark_perimetr!(r)
    make_way_back!(r, path)
end

function moves_if_possible!(r::Robot, side::HorizonSide, n_steps::Int)::Bool
    
    while n_steps > 0 && move_if_possible!(r, side)
        n_steps -= 1
    end

    if n_steps == 0
        return true
    end

    return false
end

#6(б)

function mark_four_cells!(r::Robot) 
    path = get_left_down_angle_modified!(r)
    n_steps_to_sud = 0
    n_steps_to_west = 0
    for step in path
        if step[1] == Sud
            n_steps_to_sud += step[2]
        else
            n_steps_to_west += step[2]
        end
    end

    moves!(r, Ost, n_steps_to_west)
    putmarker!(r)
    move_until_border!(r, Ost)
    moves!(r, Nord, n_steps_to_sud)
    putmarker!(r)
    get_left_down_angle_modified!(r)

    moves!(r, Nord, n_steps_to_sud)
    putmarker!(r)
    move_until_border!(r, Nord)
    moves!(r, Ost, n_steps_to_west)
    putmarker!(r)
    get_left_down_angle_modified!(r)

    make_way_back!(r, path)
end

#7

function find_space!(r::Robot, side::HorizonSide)
    n_steps = 1
    ort_side = HorizonSide((Int(side) + 1) % 4)
    while isborder(r, side)
        moves!(r, ort_side, n_steps)
        n_steps += 1
        ort_side = inverse_side(ort_side)
    end
end

function move_through!(r::Robot, side::HorizonSide)
    find_space!(r, side)
    move!(r, side)
end

#8


function move_if_not_marker!(r::Robot, side::HorizonSide)::Bool
    
    if !ismarker(r)
        move!(r, side)
        return false
    end

    return true
end

function moves_if_not_marker!(r::Robot, side::HorizonSide, n_steps::Int)::Bool

    for _ in 1:n_steps
        if move_if_not_marker!(r, side)
            return true
        end
    end
    
    return false
end

function next_side(side::HorizonSide)::HorizonSide
    return HorizonSide( (Int(side) + 1 ) % 4 )
end


function move_snake_until_marker!(r::Robot)
    n_steps = 1
    cur_side = Ost
    counter = 1
    while true

        if moves_if_not_marker!(r, cur_side, n_steps)
            return
        end 

        cur_side = next_side(cur_side)

        if counter % 2 == 0
            n_steps += 1
        end

        counter += 1
    end
end

#9


function mark_chess!(r::Robot)
    
    steps = get_left_down_angle!(r)
    to_mark = (steps[1] + steps[2]) % 2 == 0
    steps_to_ost_border = move_until_border!(r, Ost)
    move_until_border!(r, West)
    last_side = steps_to_ost_border % 2 == 1 ? Sud : Nord

    side = Nord

    while !isborder(r, Ost)
        
        while !isborder(r, side)
            if to_mark
                putmarker!(r)
            end

            move!(r, side)
            to_mark = !to_mark
        end

        if to_mark
            putmarker!(r)
        end

        move!(r, Ost)
        to_mark = !to_mark
        
        side = inverse_side(side)
    end

    while !isborder(r, last_side)
        
        while !isborder(r, side)
            if to_mark
                putmarker!(r)
            end

            move!(r, side)
            to_mark = !to_mark
        end

        if to_mark
            putmarker!(r)
        end

    end

    get_left_down_angle!(r)
    get_to_origin!(r, steps)
end

#10


function mark_square!(r::Robot, n::Int)
    
    counter1 = 1
    counter2 = 1

    while counter1 <= n && !isborder(r, Ost)

        while counter2 < n && !isborder(r, Nord)
            putmarker!(r)
            move!(r, Nord)
            counter2 += 1
        end

        putmarker!(r)
        moves!(r, Sud, counter2 - 1)
        counter2 = 1

        move!(r, Ost)
        counter1 += 1
    end

    if isborder(r, Ost) && counter1 <= n
        while counter2 < n && !isborder(r, Nord)
            putmarker!(r)
            move!(r, Nord)
            counter2 += 1
        end

        putmarker!(r)
        moves!(r, Sud, counter2 - 1)
    end

    moves!(r, West, counter1 - 1)
end

function moves_if_possible_numeric!(r::Robot, side::HorizonSide, n_steps::Int)::Int
    
    while n_steps > 0 && move_if_possible!(r, side)
        n_steps -= 1
    end

    return n_steps
end


function mark_chess!(r::Robot, n::Int)
    
    steps = get_left_down_angle!(r)
    side = Nord
    to_mark = true

    steps_to_ost_border = move_until_border!(r, Ost)
    move_until_border!(r, West)
    last_side = steps_to_ost_border % 2 == 1 ? Sud : Nord
    last_n_steps = 0

    while !isborder(r, Ost)
        while !isborder(r, side)
            if to_mark
                mark_square!(r, n)
            end

            last_n_steps = moves_if_possible_numeric!(r, side, n)
            if last_n_steps == 0 && !isborder(r, side)
                to_mark = !to_mark
            end
        end

        if to_mark
            mark_square!(r, n)
        end

        to_mark = !to_mark

        moves_if_possible!(r, Ost, n)
        moves!(r,inverse_side(side), n - last_n_steps)
        side = inverse_side(side)
    end

end

