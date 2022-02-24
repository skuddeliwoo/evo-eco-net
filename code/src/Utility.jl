include("Types.jl")
include("Params.jl")
include("Environment.jl")


module Utility

export xtr, xtrl, plt, plt2, lv, xtrb, getDump

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

    return Res(x, b, Environment.changeEnv())
end

function getDump(file)
    jld = load(file)
    return jld["dump"]
end

function xtrb(file::String, gen)
    res = xtr(getDump(file), gen)
    return res.B
end 

function xtrb(dmp::Array, gen)
    res = xtr(dmp, gen)
    return res.B
end 

function xtrl(filename, relIndex=0)
    dump = getDump(filename)
    gen = size(dump)[1]
    return xtr(dump, gen - relIndex)
end

function plt2(corrcoeff)
    B = copy(corrcoeff)
    B[I(size(B)[1])] .= ω
    avg = sum(B) / *(size(B)...)
    B[I(size(B)[1])] .= avg
    avg = sum(B) / *(size(B)...)
    B[I(size(B)[1])] .= avg
    avg = sum(B) / *(size(B)...)
    B[I(size(B)[1])] .= avg
    avg = sum(B) / *(size(B)...)

    heatmap(reverse(B, dims=1), color=:bluesreds)
end

function plt(corrcoeff)
    B = copy(corrcoeff)
    B[I(size(B)[1])] .= ω
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
