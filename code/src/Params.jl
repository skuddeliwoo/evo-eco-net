using .Types

nModules = 10
nModuleSize = 5
N = nModules * nModuleSize # Number of species # lit: 400

# interaction coeffs are init to -0.2; and -1 for diagonal (self interactions)
# if perf is decent, this can be inc to Float64 (which is default)
species = ones(Float64, N) / N
interactions = ones(Float64, N,N) * -0.2
for i in 1:N
    interactions[i,i] = -1
end

eco = Ecosystem(species, interactions)

k0 = 10 # base carrying capacity for all species
kInc = 0.1 # increment / decrement of carying capacities
m = 0.5 # growth rate of all species # lit: 0.5 for all
g = 0.01 # constant of proportionality in selection-limited evolution
μ = 1e-5 # beneficial mutation rate # lit: 10^-5

nEpisodes = 1000 # lit: ?
nEcoSteps = 50 # lit: 5000
