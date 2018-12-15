include("maths.jl")

alphabet    = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
ent         = entropy(alphabet, 2.0)
println("\nEntropia (26 liter alfabetu):\n\t", ent, "\t", 8*ent)

jobstat = ["employed", "unemployed", "employed", "employed", "employed", "unemployed", "unemployed", "unemployed", "employed", "employed"]
sex     = ["male", "male", "male", "male", "male", "female", "female", "female", "female", "female"]
econd   = entropycond(jobstat, sex, 2.0)
println("\nEntropia warunkowa (zatrudnienie a plec):\n\t", econd)

println()

println(gainratio(sex, jobstat, "a"))