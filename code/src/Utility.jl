module Utility

export xtr, xtrl, plt

using LinearAlgebra: I
using ..Types
using ..Params

function xtr(gen)
    println(size(ecoDump))
    x = copy(ecoDump[gen][1])
    xm = copy(ecoDump[gen][2])
    xmp = copy(xm)
    xmp[I(N)] .= ω

    return x, xm, xmp
end

function xtrl()
    return xtr(size(ecoDump)[1])
end

function plt(m, heatmap)
    heatmap(reverse(m, dims=1), color=:bluesreds)
end

end  # module Utility
