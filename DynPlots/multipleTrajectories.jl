function plotTrajectoryMatrix!(p,x::Array,t=Missing,map_t = true)
    l = length(size(x))
    if l == 1
        return plotTrajectory!(p,x;t=t,map_t = map_t)
    elseif l==2
        return plotTrajectory!(p,x[:,1],x[:,2];t=t,map_t = map_t)
    elseif l==3
        return plotTrajectory!(p,x[:,1],x[:,2],x[:,3];t=t,map_t = map_t)
    end

end

function plotScatterMatrix!(p,x::Array,t=Missing,map_t = true)
    l = length(size(x))
    if l == 1
        return plotScatter!(p,x;t=t,map_t = map_t)
    elseif l==2
        return plotScatter!(p,x[:,1],x[:,2];t=t,map_t = map_t)
    elseif l==3
        return plotScatter!(p,x[:,1],x[:,2],x[:,3];t=t,map_t = map_t)
    end

end


function plotMultipleTrajectoryMatrix!(p,x,t=Missing,map_t = true)
    for i in 1:(size(x)[3])
        p = plotTrajectoryMatrix!(p,x[:,:,i])#;t=t,map_t = map_t)
    end
    return p
end


