function through!(r::Robot, side::HorizonSide, n_steps::Int = 0)
    if isborder(r, side)
        move!(r, next_side(side))
        n_steps += 1
        through!(r, side, n_steps)
    else
        move!(r, side)
        along!(r, inverse_side(next_side(side)), n_steps)
    end
end

function inverse_side(side::HorizonSide)::HorizonSide
    inv_side = HorizonSide((Int(side) + 2) % 4)
    return inv_side
end

function next_side(side::HorizonSide)::HorizonSide
    return HorizonSide( (Int(side) + 1 ) % 4 )
end
