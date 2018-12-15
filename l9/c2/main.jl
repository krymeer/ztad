include("maths.jl")

function readfile(filename::String)
    columns     = Pair[]
    datanext    = false

    for line in eachline(ARGS[1])
        if occursin("@attribute", line)
            attr = replace(line, r"(@attribute\s?|\s?numeric|')" => "")
            attr = replace(attr, r"\s?\{.*\}" => "")

            push!(columns, attr => [])
        elseif occursin("@data", line)
            datanext = true
        elseif datanext
            prepline    = replace(line, r"('\\'|\\'')" => "")  
            cells       = split(prepline, ",")

            if length(cells) != length(columns)
                println(stderr, "\nBlad: liczba kolumn jest rozna od liczby atrybutow\n")
                exit()
            end

            for k = 1 : length(cells)
                push!(columns[k][2], cells[k])
            end
        end
    end

    return columns
end

if length(ARGS) < 2
    println(stderr, "\nUzycie: julia main.jl nazwa_pliku_wejsciowego indeks_klasy podstawa_logarytmu_(ew.)\n")
else
    cols    = readfile(ARGS[1])
    colnum  = length(cols)
    gratios = Tuple[]
    
    index   = try
        parse(Int64, ARGS[2])
    catch
        1
    end

    logbase = try
        parse(Float64, ARGS[3])
    catch
        Float64(MathConstants.e)
    end

    if index > colnum || 1 > index
        index = 1
    end

    for k = 1 : colnum
        if k == index
            continue
        end

        push!(gratios, ((cols[k][1], k), gainratio(cols[index][2], cols[k][2], logbase)))
    end

    sort!(gratios, by = gr -> gr[2], rev = true)

    println("\nWybrana klasa: ", cols[index][1], "\n\nRanking atrybutow:")

    for k = 1 : colnum-1
        if gratios[k][2] == 0.0
            println(" ", gratios[k][2], "       ", gratios[k][1][2], " ", gratios[k][1][1])
        else
            println(" ", round(gratios[k][2], digits = 5), "   ", gratios[k][1][2], " ", gratios[k][1][1])
        end
    end

    println()
end