function countpairs(xarr::Array{}, yarr::Array{}, _x, _y)
    resultsum   = 0
    nx          = length(xarr)
    ny          = length(yarr)

    if nx != ny
        return -1
    end

    for k = 1 : nx
        if xarr[k] == _x && yarr[k] == _y
            resultsum += 1
        end
    end

    return resultsum
end

function entropycond(xarr::Array{}, yarr::Array{})
    nx      = length(xarr)
    ny      = length(yarr)
    ydone   = []
    xydone  = []
    etotal  = 0

    if nx != ny
        return -1
    end

    # Kroki:
    # 1. Wyznaczam liczbe unikalnych x
    # 2. Obliczam prawdopodobienstwo wystapienia kazdego unikalnego x
    # 3. Wyznaczam liczbe unikalnych par xy
    # 4. Obliczam prawdopodobienstwo wystapienia kazdej unikalnej pary (wzgledem wszystkich par)

    for k = 1 : ny
        if !any(v -> (v == yarr[k]), ydone)
            push!(ydone, yarr[k])

            numy    = count(v -> (v == yarr[k]), yarr) 
            py      = numy / ny
            sumxy   = 0

            for j = 1 : nx
                if !any(xy -> (xy[1] == xarr[j] && xy[2] == yarr[k]), xydone)
                    push!(xydone, (xarr[j], yarr[k]))

                    numxy   = countpairs(xarr, yarr, xarr[j], yarr[k])
                    pxy     = numxy / nx
                    sumxy   += pxy * log(2, pxy)
                end
            end
            println(sumxy)

            etotal -= py * sumxy
        end
    end

    return etotal
end



struct UniqueElem
    val
    num::Int64
end

function entropy(dataarr::Array{})
    resultsum   = 0
    uniqarr     = UniqueElem[]
    datalen     = length(dataarr)

    # Ustalanie licznosci tych samych elementow (wartosci)
    for a in dataarr
        if !any(x -> x.val == a, uniqarr)
            cnt     = count(x -> x == a, dataarr)
            elem    = UniqueElem(a, cnt)
            push!(uniqarr, elem) 
        end
    end

    # Obliczanie prawdopodobienstwa wystapienia danego elementu
    for u in uniqarr
        p = u.num / datalen
        resultsum += p * log(2, p)
    end

    resultsum *= -1

    return resultsum
end

dataset = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
dataset = ["r", "o"]
ent     = entropy(dataset)

jobstat = ["employed", "unemployed", "employed", "employed", "employed", "unemployed", "unemployed", "unemployed", "employed", "employed"]
sex     = ["male", "male", "male", "male", "male", "female", "female", "female", "female", "female"]

println(ent, "\t", ent*8)

econd   = entropycond(jobstat, sex)
println(econd)
