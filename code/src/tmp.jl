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
file01 = join([src, "run_2022-02-24T01:08:06.422 lmb01 N 9 epi80000 dur 13696781 milliseconds.jld"])
file03 = join([src, "run_2022-02-24T01:08:55.346 lmb03 N 9 epi80000 dur 13650117 milliseconds.jld"])
file05 = join([src, "run_2022-02-24T01:09:21.274 lmb05 N 9 epi80000 dur 13658364 milliseconds.jld"])
file07 = join([src, "run_2022-02-24T01:09:58.903 lmb07 N 9 epi80000 dur 13578731 milliseconds.jld"])
file10 = join([src, "run_2022-02-24T10:44:40.207 lmb1 N 9 epi80000.jld"])
file15 = join([src, "run_2022-02-24T10:45:29.356 lmb1.5 N 9 epi80000.jld"])
file20 = join([src, "run_2022-02-24T10:45:43.765 lmb2 N 9 epi80000.jld"])
file30 = join([src, "run_2022-02-24T10:45:59.679 lmb3 N 9 epi80000.jld"])
file50 = join([src, "run_2022-02-24T10:45:59.679 lmb3 N 9 epi80000.jld"])
file70 = join([src, "run_2022-02-24T10:45:59.679 lmb3 N 9 epi80000.jld"])
file100 = join([src, "run_2022-02-24T12:48:51.451 lmb10 N 9 epi80000.jld"])
file150 = join([src, "run_2022-02-24T12:49:14.771 lmb15 N 9 epi80000.jld"])

# last = Utility.xtrl(file)

# dmp = Utility.getDump(file)

b01 = Utility.xtrl(file01).B
b03 = Utility.xtrl(file03).B
b05 = Utility.xtrl(file05).B
b07 = Utility.xtrl(file07).B
b10 = Utility.xtrl(file10).B
b15 = Utility.xtrl(file15).B
b20 = Utility.xtrl(file20).B
b30 = Utility.xtrl(file30).B

Utility.plt2(b1)
Utility.plt2(b3)
Utility.plt2(b5)
Utility.plt2(b7)
Utility.plt2(b10)
Utility.plt2(b15)
Utility.plt2(b20)
Utility.plt2(b30)

last.B
