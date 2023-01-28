#include("dyn_seq.jl")


mutable struct DynSpace{T1,T2}
    initSpace::T1
    paramSpace::T2
end

mutable struct Dyn{T1,T2}
    init::T1
    params::T2
end
#function DynSpace(initSpace::Array,paramSpace::Array)
#    return(DynSpace(Tuple("x"=>initSpace),Tuple("λ"=>paramSpace)))
#end

function dyn_update_seq(x::Dyn,FUN::Function;n = 2^5,nEsc=0)
    return dyn_update_seq(x.init,x.params,FUN;n=n,nEsc=nEsc)
end

# all origional vars & consts in column major arrays!

function expandSpace(x::Tuple)
    nCol = length(x)
    Lengths = collect(map((x->length(x.second)),x))
    #println(Lengths)
    CumProd = cumprod(Lengths)
    #println(CumProd)
    #nRow = CumProd[end]
    if nCol==1
        return collect(x[1].second)
    end#1d do not need expand but need to converted to an array
    r = x[1].second
    for j in 2:nCol
        r = hcat(repeat(r,inner = (Lengths[j],1)), repeat(x[j].second,outer = CumProd[j-1]))
    end
    return r
end


function expandSpace(x::Array,y::Array)
    return hcat(repeat(x,inner = (size(y)[1],1)),repeat(y,outer = (size(x)[1],1)))
    #y =
    #return hcat(x,y)
end

#expandSpace(("x"=>collect(1:10),"y"=>collect(1:10),"z"=>1:2))
function expandSpace(x::DynSpace)
    init_expanded = expandSpace(x.initSpace)
    params_expanded = expandSpace(x.paramSpace)
    return expandSpace(init_expanded,params_expanded)
end

function extractNames(x::Tuple)
    return collect(map(x->x.first,x))
end



function extractNames(x::DynSpace)
    return(append!(extractNames(x.initSpace),extractNames(x.paramSpace)))
end


function annotateNames(x::Array,y::Array)
    str = ":"
    for i in 1:length(x)
        str *="|"*x[i]*"="*string(y[i])
    end
    return(str)
end

function Cut_Vec(x::Vector;n=3)
    if length(x)>3
        return vcat(x[1:n],x[end])
    end
    return x
end
function annotateNames(x::DynSpace)
    str = "(1):"
    for i in 1:length(x.initSpace)
        str *="|"*x.initSpace[i].first*"="*string(Cut_Vec(x.initSpace[i].second))
    end
    for i in 1:length(x.paramSpace)
        str *= "|"*x.paramSpace[i].first*"="*string(Cut_Vec(x.paramSpace[i].second))
    end
    return(str)
end

function getDyn(x::Array,nVars::Int64)
    return Dyn(reshape(x[1:nVars],1,nVars),reshape(x[nVars+1:end],1,length(x) - nVars))
end

function getDyn(x::DynSpace)
    return Dyn( map(x->x.second[1],x.initSpace),map(x->x.second[1],x.paramSpace))
end


function dyn_collect(x::DynSpace,FUN::Function;n=2^5,nEsc=0)
    # initialize collection and memory allocation  w. format of:
    # ([time,vars,sensitivity space])
    nVars = length(extractNames(x.initSpace))
    space_expanded = expandSpace(x)
    size_space =size(space_expanded)
    m = zeros(n,nVars,size_space[1])
    # Loop or Par sequences with Xtracted vars , pars
    for i in 1:size_space[1]
        m[:,:,i] = dyn_update_seq(getDyn(space_expanded[i,:],nVars),FUN;n = n,nEsc=nEsc)
    end
    return m
end


function dyn_collect(x::Array,nVars::Int64,FUN::Function;n=2^5,nEsc=0)
    size_space =size(x)
    m = zeros(n,nVars,size_space[1])
    # Loop or Par sequences with Xtracted vars , pars
    for i in 1:size_space[1]
        m[:,:,i] = dyn_update_seq(getDyn(x[i,:],nVars),FUN;n = n,nEsc=nEsc)
    end
    return m
end



function dyn_parCollect(x::Array,nVars::Int64,FUN::Function;n=2^5,nEsc=0)
    size_space =size(x)
    m = zeros(n,nVars,size_space[1])
    # Loop or Par sequences with Xtracted vars , pars
    @distributed for i in 1:size_space[1]
        m[:,:,i] = dyn_update_seq(getDyn(x[i,:],nVars),FUN;n = n,nEsc=nEsc)
    end
    return m
end
function dyn_parCollect(x::DynSpace,FUN::Function;n=2^5,nEsc=0)
    # initialize collection and memory allocation  w. format of:
    # ([time,vars,sensitivity space])
    nVars = length(extractNames(x.initSpace))
    space_expanded = expandSpace(x)
    size_space =size(space_expanded)
    m = zeros(n,nVars,size_space[1])
    # Loop or Par sequences with Xtracted vars , pars
    @distributed for i in 1:size_space[1]
        m[:,:,i] = dyn_update_seq(getDyn(space_expanded[i,:],nVars),FUN;n = n,nEsc=nEsc)
    end
    return m
end
function dyn_parCollect(x::DynSpace,space_expanded::Array,FUN::Function;n=2^5,nEsc=0)
    # initialize collection and memory allocation  w. format of:
    # ([time,vars,sensitivity space])
    nVars = length(extractNames(x.initSpace))
    #space_expanded = expandSpace(x)
    size_space =size(space_expanded)
    m = zeros(n,nVars,size_space[1])
    # Loop or Par sequences with Xtracted vars , pars
    @distributed for i in 1:size_space[1]
        m[:,:,i] = dyn_update_seq(getDyn(space_expanded[i,:],nVars),FUN;n = n,nEsc=nEsc)
    end
    return m
end
