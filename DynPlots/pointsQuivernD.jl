function pointsQuivernD!(p,x::Union{Array,UnitRange,StepRangeLen},dx::Union{Array,StepRangeLen})
    n = length(x)
    x_end = x.+ dx
    df_dx = vcat(x',x_end')
    df_dy = repeat([0],outer=(2,n))
    p=plot!(p,df_dx, df_dy,color = :blue,key = false,colorbar=true)
    return scatter(p,df_dx[2,:],df_dy[2,:],color = :purple)
end

#pointsQuivernD!(plot(),0:5,collect(0:5)/5)

function pointsQuivernD!(p,x::Union{Array,UnitRange,StepRangeLen},
                           y::Union{Array,UnitRange,StepRangeLen},
                           dx::Union{Array,StepRangeLen},
                           dy::Union{Array,StepRangeLen})
    n = length(x)
    x_end = x.+ dx;y_end = y.+ dy
    df_dx = vcat(x',x_end')
    df_dy = vcat(y',y_end)
    p=plot!(p,df_dx, df_dy,color = :blue,key = false,colorbar=true)
    return scatter(p,df_dx[2,:],df_dy[2,:],color = :purple)
end
