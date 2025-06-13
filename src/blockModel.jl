module blockModel

export csys, dsys

using ControlSystems, RobustAndOptimalControl


"""
    csys(; g::Real=9.81, α::Real=1, μ::Real=0, τ::Real=0)::AbstractStateSpace{<:Continuous}

given the parameters, returns a continuos time system.

If g = 0, u is monodimensional. Otherwise u_2 := 1 simulates the gravitational disturbance
"""
function csys(; g::Real=9.81, α::Real=1, μ::Real=0, τ::Real=0)::Core.Any
    τ<0.0 && error("τ must be non-negative")
    α<0.0 && error("α must be non-negative")
    μ<0.0 && error("μ must be non-negative")
    g<0.0 && error("g must be non-negative")
    A = Real[0 1 0
        0 -μ 1
        0 0 -τ
    ];
    if g ≈ 0
        B = Real[0 ; 0; τ]
        u_names = [:u]
    else
        grav = -sin(α)*g;
        B = Real[0 0
                0  grav
                0 0]
        u_names = [:u,:dG]
    end
    C = Real[1 0 0
                0 1 0];
    return named_ss(ss(A, B, C, 0), x = [:xS,:xV,:xF], u = u_names , y = [:S,:V])
end

"""
dsys(; g::Real=9.81, α::Real=1, μ::Real=0, τ::Real=0, Ts::Real=0.02)

given the parameters, returns a discrete time system.

If g = 0, u is monodimensional. Otherwise u_2 := 1 simulates the gravitational disturbance
"""
function dsys(; g::Real=9.81, α::Real=1, μ::Real=0, τ::Real=0, Ts::Real=0.02)::Core.Any
    cont = csys(;g = g, α = α, μ = μ, τ = τ);
    return c2d(cont, Ts, :zoh)
end

end # module
