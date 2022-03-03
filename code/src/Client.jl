using Dates: now
using ..Types
using ..Params
import ..Environment
import ..Mutation

println("starting simulation...")
startTime = now()

for episode in 1:nEpisodes
    if (episode % 10 == 0)
        println("#################################")
        println("status: episode $episode of $nEpisodes")
    end

    # init environment
    env = Environment.changeEnv()

    # calc fitness -> old fitness
    fitness = Environment.calcFitness(env, eco.x, eco.Ω)

    for ecoStep in 1:nEcoSteps
        # apply evolutionary chage & normalise
        mutantΩ = Mutation.mutate(eco)

        # calc mutant fitness
        fitnessMutant = Environment.calcFitness(env, eco.x, mutantΩ)

        ### Compare fitness and accept mutations
        indexedFitter = fitnessMutant .> fitness

        fitness[indexedFitter] = fitnessMutant[indexedFitter]

        indexedFitter = repeat(indexedFitter, outer=[1,N])

        eco.Ω[indexedFitter] = mutantΩ[indexedFitter]

        # let ecosystem play out
        # L-V model
        xdot = m * (eco.x ./ env) .* (env + eco.Ω * eco.x)

        eco.x = eco.x + xdot

    end
    if (episode % 200 == 0 || episode==1 || episode==nEpisodes)
        push!(ecoDump, [copy(eco.x), copy(eco.Ω), copy(env)])
    end

end

using JLD: save

runTime = now() - startTime

save("run_$startTime lmb$λ N $N epi$nEpisodes.jld", "dump", ecoDump, "duration", runTime)
