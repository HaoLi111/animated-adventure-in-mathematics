#cgrad(:default)[1]
"cMap(x::Float,cSeq::Array) Map a value from 0 to one to a color, given a color sequence"
function cMap(x::Number,cSeq::Array)
    n = length(cSeq)
    if x>1 || x<0
        error("x should be normalized to 0-1")
    end
    ind = Int(floor(x*(n-1)))+Int(1)
    if ind ==0 # out of bound caused by 0-eps()
        ind=1
    end
    cSeq[ind]
end

function cMap(x::Number,cSeq::ColorGradient)
    cMap(x,cSeq.colors)
end

#cgrad(:default).colors




"cMap_def default c map"
function cMap_def(x::Number)
    cMap(x,cgrad(:default))
end



function cNormalize(x::Union{Array,UnitRange})
    xMin = minimum(x)
    xDiff = maximum(x) - xMin
    [(x[i]-xMin)/xDiff for i in 1:length(x)]    
end

"qcMap_def(x) x is an arraym, quick map from a numeric array to a color array"
function qcMap_def(x)
    cMap_def.(cNormalize(x))
end

#qcMap_def(0:.05:1)

"plotInit"
function plotInit()
    return Plots.plot()
end

"plotTrajectory!(x,y,z) for x,y,z as single vector, plotTrajectory(x,y) for 2 vectors, plotTrajectory(x) is a time plot if x is the only input and ncol(x) is 1, else treated as a data-frame"
function plotTrajectory!(p,x::Union{Array,UnitRange},y::Union{Array,UnitRange},z::Union{Array,UnitRange};xlab = "x",ylab = "y",zlab = "z",map_t = true,t = Missing, log_t = false,markeralpha = .5)
    if (length(x)!=length(y)) || (length(y)!=length(z))
        error("Length differ")
    end
    if map_t
        if t==Missing
            t = 1:length(x)
        end
        if log_t == true
            t = log.(t)
        end
        #return plot!(p,x,y,z;color = qcMap_def(t),markeralpha = markeralpha)
        return plot!(p,x,y,z;line_z = t,markeralpha = markeralpha)

    end
    if length(t) != length(x)
        error("Check length of t")
    end
    return plot!(p,x,y,z;markeralpha = markeralpha)
end

function plotTrajectory!(p,x::Union{Array,UnitRange},y::Union{Array,UnitRange};xlab = "x",ylab = "y",map_t = true,t = Missing, log_t = false,markeralpha = .5)
    if (length(x)!=length(y))
        error("Length differ")
    end
    if map_t
            
        if t==Missing
            
            t = 1:length(x)
        end   
        if log_t == true
            t = log.(t)
        end
        if length(t) != length(x)
            error("Check length of t")
        end
        #return plot!(p,x,y;color = qcMap_def(t),markeralpha = markeralpha)
        return plot!(p,x,y;line_z = t,markeralpha = markeralpha)
    end
    return plot!(p,x,y;markeralpha = markeralpha)
end

function plotTrajectory!(p,x::Union{Array,UnitRange};xlab = "t",ylab = "x",map_t = true,t = Missing,log_t = false,markeralpha = .5)

    if t==Missing           #  need t anyway
            
        t = 1:length(x)
    end   
    if log_t == true
        t = log.(t)
    end
    if map_t    
        #return plot!(p,x;color = qcMap_def(t),markeralpha = markeralpha)
        return plot!(p,x;line_z = t,markeralpha = markeralpha)
    end
    return plot!(p,t,x;markeralpha = markeralpha)
end


# plotScatter

"plotScatter!(x,y,z) for x,y,z as single vector, plotScatter(x,y) for 2 vectors, plotScatter(x) is a time plot if x is the only input and ncol(x) is 1, else treated as a data-frame"
function plotScatter!(p,x::Union{Array,UnitRange},y::Union{Array,UnitRange},z::Union{Array,UnitRange};xlab = "x",ylab = "y",zlab = "z",map_t = false,t = Missing,
     log_t = false,alpha = .5)
    if (length(x)!=length(y)) || (length(y)!=length(z))
        error("Length differ")
    end
    if map_t
        if t==Missing
            t = 1:length(x)
        end
        if log_t == true
            t = log.(t)
        end
        return Plots.scatter!(p,x,y,z;color = qcMap_def(t),alpha = alpha)
    end
    if length(t) != length(x)
        error("Check length of t")
    end
    return Plots.scatter!(p,x,y,z;alpha = alpha)
end

function plotScatter!(p,x::Union{Array,UnitRange},y::Union{Array,UnitRange};xlab = "x",ylab = "y",map_t = false,t = Missing, log_t = false,alpha = .5)
    if (length(x)!=length(y))
        error("Length differ")
    end
    if map_t
            
        if t==Missing
            
            t = 1:length(x)
        end   
        if log_t == true
            t = log.(t)
        end
        if length(t) != length(x)
            error("Check length of t")
        end
        return Plots.scatter!(p,x,y;color = qcMap_def(t),alpha = alpha)
    end
    return Plots.scatter!(p,x,y;alpha = alpha)
end

function plotScatter!(p,x::Union{Array,UnitRange};xlab = "t",ylab = "x",map_t = false,t = Missing,log_t = false,alpha = .5)
 
    if t==Missing           #  need t anyway
            
        t = 1:length(x)
    end   
    if log_t == true
        t = log.(t)
    end
    if map_t        
        return Plots.scatter!(p,x;color = qcMap_def(t),alpha = alpha)
    end
    return Plots.scatter!(p,t,x;alpha = alpha)
end


"plotTrace!(x,y,z) similar to plotScatter, plotTrajectory with predefined plts"
function plotTrace!(p,x,y,z;t = Missing,log_t = false)
    plotTrajectory!(p,x,y,z;t=t,log_t = log_t)
    plotScatter!(p,x,y,z;t=t,log_t = log_t)
end


function plotTrace!(p,x,y;t = Missing,log_t = false)
    plotTrajectory!(p,x,y;t=t,log_t = log_t)
    plotScatter!(p,x,y;t=t,log_t = log_t)    
end


function plotTrace!(p,x;t = Missing,log_t = false)
    plotTrajectory!(p,x;t=t,log_t = log_t)
    plotScatter!(p,x;t=t,log_t = log_t)    
end
