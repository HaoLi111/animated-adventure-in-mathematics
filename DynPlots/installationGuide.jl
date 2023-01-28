

using Pkg

Pkg.add(["DelayEmbeddings", "RecurrenceAnalysis", "DynamicalSystemsBase", "ChaosTools"])
Pkg.status(["DelayEmbeddings", "RecurrenceAnalysis", "DynamicalSystemsBase", "ChaosTools"])
Pkg.add("DynamicalSystems.jl")
Pkg.add("OrdinaryDiffEq")
Pkg.add("DynamicalSystems")