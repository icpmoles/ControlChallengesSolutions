using CCS: blockModel
using ControlSystems
using Test

cs = blockModel.csys(; g = 0, α = 0, μ = 1, τ = 100//5)

@testset "Nominal Behaviour" begin
    @test controllability(cs).iscontrollable == true
    @test observability(cs).isobservable == true
    @test all(real(poles(cs)).<=0)
    @test all(<=(0),real(poles(cs)))
    @test all(i -> real(i)<=0,poles(cs))
end
