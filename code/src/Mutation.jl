module Mutation

using LinearAlgebra: I
using ..Types
using ..Params

# update interaction matrix according to Eq. 3, then normalise.
function mutate(eco::Ecosystem, env)::Ecosystem
    # (Eq. 3)
    V = ((m ./ env) * g * μ .* eco.x) * eco.x'

    # diagonal elements should not be updated
    V[I(N)] .= 0.0

    # update interaction matrix, but keep diagonal elements
    M = eco.Ω + V

    # normalise Ω
    eco.Ω = copy(normalise(M))
    return eco
end

# apply row- and col_normalisation until squared difference of matrix converges
# below 10^-5
function normalise(M)
    M2 = copy(M)
    while true
        row_norm(M2)
        col_norm(M2)

        ssq = sum((M2 - M)^2)

        if (isnan(ssq))
            println("fn normalise: sum of squared diff is NaN")
            return ErrorException("fn normalise: sum of squared diff is NaN")
        end

        if (ssq < 1e-5)
            return M2
        end

        M = copy(M2)
    end
end

# normalisation of interaction matrix:
# entries in the diagonal (self interactions) remain unchanged. the rest of the
# rows (or cols) are beeing normalised (getting devided by their sum)
function row_norm(M)
    for i in 1:N
        div = (sum(M[i,:]) - M[i,i]) / (ω * (N - 1))

        M[i,1:(i-1)] = M[i,1:(i-1)] ./ div
        M[i,(i+1):end] = M[i,(i+1):end] ./ div
    end
end

function col_norm(M)
    for i in 1:N
        div = (sum(M[:,i]) - M[i,i]) / (ω * (N - 1))

        M[1:(i-1),i] = M[1:(i-1),i] ./ div
        M[(i+1):end,i] = M[(i+1):end,i] ./ div
    end
end

end  # module Mutation
