function QExplore(x::DynSpace,FUN::Function;n=2^4,nEsc=0,ind1=1,ind2=2)
    r = dyn_collect(x,FUN,n=n,nEsc=nEsc)
    p=Plots.scatter(r[:,ind1],r[:,ind2];xlabel="x",ylabel = "y",key = false)
    Plots.plot!(p,r[:,ind1],r[:,ind2];xlabel="x",ylabel = "y",key = false)
    Plots.title!(p,annotateNames(x))
    return p
end


function QExplore_makie(x::DynSpace,FUN::Function;n=2^4,nEsc=0,ind1=1,ind2=2)
    r = dyn_collect(x,FUN,n=n,nEsc=nEsc)
    StatsMakie.scatter(r[:,ind1],r[:,ind2];xlabel="x",ylabel = "y",key = false)
end


function Qanimate_sensitivity(x::Array,y::Array,dyn_space::DynSpace;ind1=1,ind2=2)
    #y is the extracted grid
    names_extracted = extractNames(dyn_space)
    anim = return @animate for i in 1:size(x)[3]
        Plots.plot(x[:,ind1,i],x[:,ind2,i])
        Plots.scatter!(x[:,ind1,i],x[:,ind2,i])
        Plots.title!(annotateNames(names_extracted,y[i,:]))
    end
    return anim
end


function QSensitivityPlotSave(x::Array,y::Array,dyn_space::DynSpace;ind1=1,ind2=2,plt_type = ".png",dir = "")
    names_extracted = extractNames(dyn_space)
    for i in 1:size(x)[3]
        Plots.plot(x[:,ind1,i],x[:,ind2,i];key = false,colorkey = false)
        Plots.scatter!(x[:,ind1,i],x[:,ind2,i];key = false,colorkey = false)
        Plots.title!(annotateNames(names_extracted,y[i,:]))
        savefig(dir*string(i)*plt_type)
        println("saved"*dir*string(i)*plt_type)
    end
    return "Plots Saved"
end

function QSensitivityPlotSave_makie(x::Array,y::Array,dyn_space::DynSpace;titlePosition = Float32[0.0,0.0],ind1=1,ind2 =2,plt_type =:".png",dir = "")
    #fileName = string(i)*".png"
    names_extracted = extractNames(dyn_space)
    for i in 1:size(x)[3]
        fileName = dir*string(i)*plt_type
        scene = Makie.scatter(x[:,ind1,i],x[:,ind2,i];key =false)
        Makie.plot!(scene,x[:,ind1,i],x[:,ind2,i];color = :blue)
        Makie.text!(scene,".                                "*annotateNames(names_extracted,y[i,:]);textsize = 0.1)
        Makie.save(fileName,scene)
        println("saved "*fileName)
    end
end