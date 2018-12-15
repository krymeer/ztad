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

function entropy(xarr::Array{}, logbase::Float64)
    xdone   = []
    esum    = 0.0
    nx      = length(xarr)

    for x in xarr
        if !any(v -> (v == x), xdone)
            push!(xdone, x)

            numx    = count(v -> (v == x), xarr)
            px      = numx / nx
            esum    += px * log(logbase, px)
        end
    end

    return -esum
end

function entropycond(xarr::Array{}, yarr::Array{}, logbase::Float64)
    nx      = length(xarr)
    ny      = length(yarr)
    ydone   = []
    xydone  = []
    etotal  = 0.0

    if nx != ny
        return -1
    end

    for k = 1 : ny
        if !any(v -> (v == yarr[k]), ydone)
            push!(ydone, yarr[k])

            numy    = count(v -> (v == yarr[k]), yarr) 
            py      = numy / ny
            sumxy   = 0.0

            for j = 1 : nx
                if yarr[j] == yarr[k] && !any(xy -> (xy[1] == xarr[j] && xy[2] == yarr[k]), xydone)
                    push!(xydone, (xarr[j], yarr[k]))

                    numxy   = countpairs(xarr, yarr, xarr[j], yarr[k])
                    pxy     = (numxy / nx) / py 
                    sumxy   += pxy * log(logbase, pxy)
                end
            end
            
            etotal -= py * sumxy
        end
    end

    return etotal
end

function gainratio(classarr::Array{}, attrarr::Array{}, logbase = nothing)
    if length(classarr) != length(attrarr)
        return -1
    end

    if !isa(logbase, Number)
        logbase = try
            parse(Float64, logbase)
        catch
            Float64(MathConstants.e)
        end
    elseif typeof(logbase) != Float64
        logbase = Float64(logbase)
    end

    ec  = entropy(classarr, logbase)
    eca = entropycond(classarr, attrarr, logbase)
    ea  = entropy(attrarr, logbase)

    #println("\nH(C)\t= ", ec, "\nH(C|A)\t= ", eca, "\nH(A)\t= ", ea)

    if ea == 0.0
        return 0.0
    else
        return (ec - eca)/ea 
    end
end