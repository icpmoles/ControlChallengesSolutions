using FMI, Plots, DifferentialEquations, BenchmarkTools
fmu = loadFMU(pwd()*raw"\modelica\ControlChallenges\WithFriction.fmu") 
simData = simulateME(fmu, (0.0, 5.0); recordValues=["blockOnSlope.x","blockOnSlope.xd"]);
plot(simData, states=false)
# p = plot(simData, series_keyword = 5)
simDatau = simulateME(fmu, (0.0, 5.0); recordValues=["blockOnSlope.usat"]);
plot(simDatau, states=false)


unloadFMU(fmu)