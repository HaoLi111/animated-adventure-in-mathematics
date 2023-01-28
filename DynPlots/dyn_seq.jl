function dyn_update_seq(init::Array,params::Union{Tuple,Array},FUN::Function;n = 2^5,nEsc=0)
    flowData = copy(init)'
    r = zeros(Float64,n,length(init))
    for i in 1:nEsc
        flowData = FUN(flowData,params)
    end
    for i in 1:n
        flowData = FUN(flowData,params)
        r[i,:] = flowData
    end
    return r
end

function dyn_update_seq(init::Tuple,params::Tuple,FUN::Function;n = 2^5,nEsc=0)
    return dyn_update_seq(transpose(collect(init)),transpose(collect(params)),FUN::Function;n = 2^5,nEsc=0)
end
function dyn_update_seq(init::Tuple,params::Array,FUN::Function;n = 2^5,nEsc=0)
    #flowData = collect((init))
    flowData = collect(map(x->x.second,init))
    r = zeros(Float64,n,length(init))
    for i in 1:nEsc
        flowData = FUN(flowData,params)
    end
    for i in 1:n
        flowData = FUN(flowData,params)
        r[i,:] = flowData
    end
    return r
end



function hcat_seq(x::Matrix)
    nrow =size(x)[1]
    return hcat(collect(1:nrow,x))
end

function hcat_seq(x::Array)
    if length(size(x))==2
        nrow = size(x)[1]
        return(hcat(collect(1:nrow,x)))
    elseif length(size(x))==1
        return(hcat(collect(1:length(x)),x))
    else
        println(stderr,"Invalid x size")
    end
end
