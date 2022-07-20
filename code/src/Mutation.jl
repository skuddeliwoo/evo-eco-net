module Mutation

using LinearAlgebra: I
using JLD: save
using ..Types
using ..Params

# update interaction matrix according to Eq. 3, then normalise.
function mutate(eco::Ecosystem)::TInteraction
    # copy interaction matrix
    mutant::TInteraction = copy(eco.Ω)

    # mutate one entry per species; choose which ones
    mutIndex = rand((1:N), N)
    mutIndex = collect(0:N-1) .* N + mutIndex

    # add mutational increments ϵ [-μ, +μ]
    # μ should be dependent on species density TODO
    mutant[mutIndex] += rand(N) * (μ * 2) .- μ

    return mutant
end

# apply row- and col_normalisation until squared difference of matrix converges
# below 10^-5
function normalise(M)
    M2 = copy(M)
    while true
        row_norm(M2)
        col_norm(M2)

        sq = (M2 - M)^2
        ssq = sum(sq)

        if (isnan(ssq))
            println("fn normalise: sum of squared diff is NaN:")
            println(M)
            println(M2)

            save("run crash N$N epi$nEpisodes crash.jld", "dump", ecoDump)

            throw(ErrorException("fn normalise: sum of squared diff is NaN"))
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
