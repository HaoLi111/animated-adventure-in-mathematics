function theme_cutie()
    p=plot(aspect_ratio=1,bg_color=:pink,fg_color = RGB(.7,.7,1),grid=(1, 0.9),size=(800,800),dpi=150,color = :red,markerstrokecolor = :red,key =false)
    return p
end

function theme_dark()
    p = Plots.plot(markerstrokewidth=.01,aspect_ratio=1,bg_color=:black,size=[800,800],dpi=150,xlabel = "x",
    ylabel = "y",zlabel = "z",fg_color = RGB(.7,.7,1),grid=(1, 0.9));
    return p
end
