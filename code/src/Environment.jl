module Environment

using ..Types
include("./Params.jl")

export changeEnv

env1 = ones(N) * (k0 - kInc)
env2 = ones(N) * (k0 - kInc)
#
# for i in 1:N
#     if (rand(Float16) > 0.5)
#         env1[i] = (k0 + kInc)
#     end
#     if (rand(Float16) > 0.5)
#         env2[i] = (k0 + kInc)
#     end
# end

env1[1:Int(N/2) + 1] .= (k0 + kInc)
env2[Int(N/2) + 1:end] .= (k0 + kInc)

function changeEnvDual(episode)
    if (episode % 2 == 0)
        return env1
    end
    return env2
end

function changeEnvModular(nModules=nModules)
    # env is represented through elevated or depressed carrying capacities
    # init as depressed for all
    env = ones(N) * (k0 - kInc)

    # for each module: roll if this module (group of species) has elevated or
    # depressed carrying capacity
    for i in 1:nModules
        roll = rand(Float16)
        if (roll > 0.5)
            env[((i - 1) * nModuleSize) + 1:i*nModuleSize] .= k0 + kInc
        end
    end

    return env

end

changeEnv = changeEnvDual

end  # module Environment
