module Types

export Ecosystem

# Type for the evolving ecosystem:
# vector x containing population densities
# matrix Ω containing interaction coefficients
mutable struct Ecosystem
    x::Vector{Float64}
    Ω::Array{Float64,2}
end

end  # module Types
