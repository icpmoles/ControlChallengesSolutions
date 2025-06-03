using ControlSystems
using Plots
# System parameters
g = 9.81
α = 0.0 # slope
μ = 1.0 # friction coefficient
x_0 = -2.0 # starting position
dx_0 = 0.0 # starting velocity
τ = 20.0 # torque constant 


A = [ 0  1 0 
    0 -μ 1
    0  0  -τ
];
B = [ 0
     0
    τ];
C = [ 1 0 0
0 1 0];




sys = ss(A, B, C, 0)      # Continuous

bodeplot(tf(sys))
current_poles = poles(sys)

p = -[10.0 20.0 40.0];
C_full = Matrix{Float64}(I, 3, 3)

# L = place(sys, 2*p, :o)
K = place(sys, p, :c)

controller = ss([0 0; 0 0],[0 0; 0 0],[0 0],K[1:2]')

closedLoop = feedback(sys, controller)

clpoles = poles(closedLoop)

gangoffourplot(sys, controller; minimal=true)

bodeplot(closedLoop)