using .Types

nModules = 2
nModuleSize = 3
N = nModules * nModuleSize # Number of species # lit: 400

k0 = 10 # base carrying capacity for all species
kInc = 0.1 # increment / decrement of carying capacities # lit: 0.1
m = 0.5 # growth rate of all species # lit: 0.5 for all
g = 0.01 # constant of proportionality in selection-limited evolution # lit: 0.01
μ = 1e-5 # beneficial mutation rate # lit: 10^-5
ω = -0.2 # initial interaction strength

nEpisodes = 80 # lit: 800
nEcoSteps = 5000 # lit: 5000
