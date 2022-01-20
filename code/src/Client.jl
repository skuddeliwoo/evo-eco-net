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

    for ecoStep in 1:nEcoSteps
        # apply evolutionary chage & normalise
        Mutation.mutate(eco, env)

        # let ecosystem play out
        # L-V model
        xdot = m * (eco.x ./ env) .* (env + eco.Ω * eco.x)

        eco.x = eco.x + xdot

    end
    push!(ecoDump, [copy(eco.x), copy(eco.Ω)])

end

using JLD: save

runTime = now() - startTime

save("run_$startTime N $N epi$nEpisodes dur $runTime.jld", "dump", ecoDump)
