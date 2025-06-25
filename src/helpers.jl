
"""
    isHurwitz(poles)

Returns true if all the elements are in the LHP, false otherwise
"""
function isHurwitz(poles::Vector)
mapreduce(i->real(i)<=0.0, &, poles)
end
