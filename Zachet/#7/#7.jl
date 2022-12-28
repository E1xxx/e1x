using HorizonSideRobots

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
