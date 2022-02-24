include("Utility.jl")

using ..Utility
using Plots
using JLD: load

# create heatmap shortcut with reversed y-axis for better matrix representation
heat(m) = heatmap(reverse(m, dims=1), color=:bluesreds)

# create schematic selection pressures of environments on the correlation coefficients
function combEnv()
    e1 = Environment.env1
    e2 = Environment.env2
    
    E1 = (e1 * e1') / 100 * -0.2
    E2 = (e2 * e2') / 100 * -0.2
    
    a = [10.1 9.9]
    A = a' * a / 100 * -0.2
    
    E1[E1 .== A[1,1]] .= 2
    E1[E1 .== A[2,2]] .= 2
    E1[E1^2 .< 0] .= 1
    E1
    
    E2[E2 .== A[1,1]] .= 2
    E2[E2 .== A[2,2]] .= 2
    E2[E2^2 .< 0] .= 1
    
    return E1, E2
end

# general tests for the evolved matrix under a dual-alternating environment
function analyseDualEnvEvolution()
    E = .*(combEnv()...)
    
    E = E ./ 4 * 0.2
    E
    min((E .+ 0.075)...)
    
    heat((E .+ 0.075))
    
    src = "/home/andi/dev/evo-eco-net/code/src/"
    
    res = Utility.xtrl(join([src, "run_2022-01-19T18:11:10.702 N 16 epi800 dur 1423928 milliseconds.jld"]))
    res = Utility.xtrl(join([src, "run_2022-01-19T18:11:10.702 N 16 epi800 dur 1423928 milliseconds.jld"]), 1)
    
    Utility.plt(res.B)
end

src = "/home/andi/dev/evo-eco-net/code/src/logs/"
file = join([src, "run_2022-02-23T10:00:58.985 N 12 epi100000 dur 11176053 milliseconds.jld"])

# last = Utility.xtrl(file)

dmp = Utility.getDump(file)

k10 = Utility.xtrb(dmp, Int(1e4))
k20 = Utility.xtrb(dmp, Int(2e4))
k30 = Utility.xtrb(dmp, Int(3e4))
k40 = Utility.xtrb(dmp, Int(4e4))
k50 = Utility.xtrb(dmp, Int(5e4))
k60 = Utility.xtrb(dmp, Int(6e4))
k70 = Utility.xtrb(dmp, Int(7e4))
k75 = Utility.xtrb(dmp, Int(7.5e4))
k80 = Utility.xtrb(dmp, Int(8e4))
k90 = Utility.xtrb(dmp, Int(9e4))

Utility.plt2(k75)

last.B
