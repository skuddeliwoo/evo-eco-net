include("Types.jl")
include("Params.jl")
include("Environment.jl")


module Utility

export xtr, xtrl, plt, lv

using LinearAlgebra: I
using Plots: heatmap
using JLD: load
using ..Types
using ..Params
using ..Environment

struct Res
    x
    B
    env
end

function xtr(dump, gen)
    x = copy(dump[gen][1])
    b = copy(dump[gen][2])

    return Res(x, b, Environment.changeEnv(gen))
end

function xtrl(filename, relIndex=0)
    jld = load(filename)
    gen = size(jld["dump"])[1]
    return xtr(jld["dump"], gen - relIndex)
end

function plt(corrcoeff)
    B = copy(corrcoeff)
    B[I(N)] .= ω
    # heatmap(B, color=:bluesreds)
    heatmap(reverse(B, dims=1), color=:bluesreds)
end

function lv(x, b, env, reps=1000)
    for i in 1:reps
        xdot = m * (x ./ env) .* (env + b * x)
        x = x + xdot
    end
    return x
end

end  # module Utility
