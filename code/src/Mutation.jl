module Mutation

using ..Types
include("./Params.jl")

# update interaction matrix according to Eq. 3, then normalise.
function mutate(ecosystem::Ecosystem, env)
    # (Eq. 3)
    V = ((m ./ env) * g * μ .* x) * x'

    M = ecosystem.Ω + V

    # normalise Ω
    normalise(M)

    ecosystem.Ω = copy(M)

    return ecosystem
end

# apply row- and col_normalisation until squared difference of matrix converges
# below 10^-5
function normalise(M)
    while true
        println("normalising...")
        M2 = copy(M)
        println(M2[1,1])
        row_norm(M2)
        col_norm(M2)
        if (sum((M2 - M)^2) < 1e-5)
            return M2
        end
        M = copy(M2)
    end
end

# normalisation of interaction matrix:
# entries in the diagonal (self interactions) remain unchanged. the rest of the
# rows (or cols) are beeing normalised (getting devided by their sum)
function row_norm(M)
    for i in 1:size(M, 1)
        div = sum(M[i,:]) - M[i,i]

        M[i,1:(i-1)] = M[i,1:(i-1)] ./ div
        M[i,(i+1):end] = M[i,(i+1):end] ./ div
    end
end

function col_norm(M)
    for i in 1:size(M, 2)
        div = sum(M[:,i]) - M[i,i]

        M[1:(i-1),i] = M[1:(i-1),i] ./ div
        M[(i+1):end,i] = M[(i+1):end,i] ./ div
    end
end

end  # module Mutation
