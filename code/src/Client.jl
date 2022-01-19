include("./Params.jl")

using .Types
import .Environment
import .Mutation

for episode in 1:nEpisodes
    if (episode % 100 == 0)
        println("#################################")
        println("status: episode $episode of $nEpisodes")
    end

    # init environment
    env = Environment.changeEnv(episode)

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
