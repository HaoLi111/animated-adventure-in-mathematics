function theme_cutie()
    p=plot(bg_color=:pink,fg_color = RGB(.7,.7,1),grid=(1, 0.9),size=(1e3,1e3),dpi=150,color = :red,markerstrokecolor = :red,key =false)
    return p
end

function theme_dark()
    p = Plots.plot(markerstrokewidth=.01,bg_color=:black,size=[1e3,1e3],dpi=150,xlabel = "x",
    ylabel = "y",zlabel = "z",fg_color = RGB(.7,.7,1),grid=(1, 0.9));
    return p
end
#aspect ratio need to be added later
theme_default = theme_dark