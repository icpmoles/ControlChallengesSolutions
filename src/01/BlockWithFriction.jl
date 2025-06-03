using ControlSystems
using Plots
using LinearAlgebra
# System parameters
g = 9.81
α = 0.0 # slope
μ = 1.0 # friction coefficient
x_0 = -2.0 # starting position
dx_0 = 0.0 # starting velocity
τ = 20.0 # torque constant 

# State Space Matrix
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

p = -[10 15 12];
observability(A, C)
controllability(A, B)


L = place(sys, p, :c)


# L = place(A', C', 5*p, opt=:c) # error, let's use kalman
R1 = diagm([0.01, 0.02, 0.03])
R2 = diagm([0.005, 0.002])
K = kalman(sys, R1, R2; direct = false)

cont = observer_controller(sys, L, K; direct=false)


closedLoop = feedback(sys,cont)

clpoles = poles(closedLoop)
setPlotScale("dB")

gangoffourplot(sys, cont; minimal=true)

bodeplot(closedLoop[1,1],0.1:40)