include("./Params.jl")

using .Types
import .Environment
# import .Development
# import .Mutation

for episode in 1:nEpisodes
    if (episode % 100 == 0)
        println("status: episode $episode of $nEpisodes")
    end

    # init environment
    env = Environment.changeEnv(episode)

    # evolutionary chage

    # normalise

    for ecoStep in 1:nEcoSteps
        # let ecosystem play out

        # L-V model
    end


end
