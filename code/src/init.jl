using .Types
include("./Params.jl")

# interaction coeffs are init to -0.2; and -1 for diagonal (self interactions)
# if perf is decent, this can be inc to Float64 (which is default)
species = ones(Float64, N) * 0.1
# species = species / sum(species)
interactions = ones(Float64, N,N) * ω
for i in 1:N
    interactions[i,i] = -1
end

eco = Ecosystem(species, interactions)

ecoDump = []
push!(ecoDump, [copy(eco.x), copy(eco.Ω)])
