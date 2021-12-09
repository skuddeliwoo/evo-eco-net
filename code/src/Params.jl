nModules = 10
nModuleSize = 5
N = nModules * nModuleSize # Number of species # lit: 400

# interaction coeffs are init to -0.2; and -1 for diagonal (self interactions)
# if perf is decent, this can be inc to Float64 (which is default)
species = ones(Float32, N) / N
interactions = ones(Float32, N,N) * -0.2
for i in 1:N
    interactions[i,i] = -1
end

k0 = 10 # base carrying capacity for all species
kInc = 0.1 # increment / decrement of carying capacities
m = 0.5 # growth rate of all species # lit: 0.5 for all
g = 0.01 # constant of proportionality in selection-limited evolution

nEpisodes = 1000 # lit: ?
nEcoSteps = 5000 # lit: 5000
