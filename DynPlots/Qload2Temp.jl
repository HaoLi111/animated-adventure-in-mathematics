
using Distributed
#addprocs(3-nprocs())

@everywhere using Plots
@everywhere using Makie


@everywhere include("Qload.jl")
