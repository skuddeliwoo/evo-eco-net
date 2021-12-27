include("./Params.jl")

using .Types
import .Environment
# import .Development
import .Mutation

for episode in 1:nEpisodes
    # if (episode % 100 == 0)
    println("status: episode $episode of $nEpisodes")
    # end

    # init environment
    env = Environment.changeEnv(episode)

    # apply evolutionary chage & normalise
    Mutation.mutate(eco, env)

    for ecoStep in 1:nEcoSteps
        println("ecoStep $ecoStep")
        # let ecosystem play out
        # L-V model
        xdot = m * (eco.x ./ env) + env + eco.Ω * eco.x
        eco.x = eco.x + xdot
    end

end
