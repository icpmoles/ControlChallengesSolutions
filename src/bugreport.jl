using ControlSystems
#
# n = 2 
#

A2 = [ 0.0 1.0; 0.0 -20.0];
B2 = [ 0.0; 4.0]
C2 = [1.0 0.0]
plant2  = ss(A2, B2, C2, 0) 

observability(A2, C2)   # OK
controllability(A2, B2) # OK

poles2 = [-20 -20.1]
L2 = place(plant2, poles2, :c);
L2matrices = place(A2, B2, poles2, :c);
K2 = place(plant2, poles2, :o)';                    # Observer Flag on state space function: OK
K2opt = place(plant2, poles2, opt =:o)';            # OPT Observer Flag on state space function: OK
K2matrices = place(A2', C2', 5.0*poles2, opt=:o)'   # Using the observer flag: OK
K2matrices_transpose = place(A2', C2', 5.0*poles2)' # Just using place with the matrices transposed: OK

#
# n = 3
#

A = [0.0   1.0    0.0
    0.0  -1.0    1.0
    0.0   0.0  -20.0]
B = [ 0; 0; 1]
C = [1.0  0.0  0.0
    0.0  1.0  0.0]
plant = ss(A,B,C,0);

controllability(A,B) # OK
observability(A, C)  # OK

poles = [-40 -40.1 -39]
# Controller Vector
L3 = place(plant, poles, opt=:c)         # Success 
L3matrices = place(A, B, poles, opt=:c)  # Success
# Observer Vector
K3matrices_transpose = place(A', C', 5.0*poles)'  # Just using place with the matrices transposed: FAIL
K3matrices = place(A', C', 5.0*poles, opt=:o)'    # Place with the matrices transposed and the observer flag: FAIL
K3 = place(plant, 5.0*poles, :o)';                # Observer Flag on state space function: FAIL
K3opt = place(plant, 5.0*poles, opt=:o)'          # OPT Observer Flag on state space function: OK
