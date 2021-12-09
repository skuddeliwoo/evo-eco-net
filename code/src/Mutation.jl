module Mutation

using ..Types
include("./Params.jl")

function mutate(ecosystem::Ecosystem, env)
    # (Eq. 3)
    V = ((m ./ env) * g * μ .* x) * x'

    M = ecosystem.Ω + V

    # normalise Ω
    while true
        print("normalising...")
        M2 = copy(M)
        row_norm(M2)
        col_norm(M2)
        if (sum((M2 - M)^2) < 1e-5)
            break
        end
        M = copy(M2)
    end

    return ecosystem
end

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
