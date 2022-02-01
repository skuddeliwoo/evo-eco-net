module Params

using ..Types

export nModules, nModuleSize, N, k0, kInc, m, g, μ, ω, nEpisodes, nEcoSteps, eco, ecoDump

nModules = 3
nModuleSize = 4
N = nModules * nModuleSize # Number of species # lit: 400

k0 = 10 # base carrying capacity for all species
kInc = 0.1 # increment / decrement of carying capacities # lit: 0.1
m = 0.5 # growth rate of all species # lit: 0.5 for all
g = 0.01 # constant of proportionality in selection-limited evolution # lit: 0.01
μ = 1e-5 # beneficial mutation rate # lit: 10^-5
ω = -0.2 # initial interaction strength

nEpisodes = 5000 # lit: 800
nEcoSteps = 3000 # lit: 5000

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

end  # module Params
