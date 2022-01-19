module Utility

using LinearAlgebra: I
using ..Types
using ..Params

function extractFromDump(gen)
    println(size(ecoDump))
    x = copy(ecoDump[gen][1])
    xm = copy(ecoDump[gen][2])
    xmp = copy(xm)
    xmp[I(N)] .= ω

    return x, xm, xmp
end

end  # module Utility
