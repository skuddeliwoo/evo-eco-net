module Types

export Ecosystem, TPop, TInteraction

TPop = Vector{Float64}
TInteraction = Array{Float64,2}
# Type for the evolving ecosystem:
# vector x containing population densities
# matrix Ω containing interaction coefficients
mutable struct Ecosystem
    x::TPop
    Ω::TInteraction
end

end  # module Types
