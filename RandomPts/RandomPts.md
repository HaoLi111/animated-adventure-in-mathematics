---
author: "Hao Li"
title: "Random Points"
date: "05/25/020"
bibliography: "biblio.bib"
---




## Gaussian Distribution

### Random Points


$$
X ~ N(0,1)
$$


```julia
cd("D:/animated-adventure-in-mathematics/RandomPts")# state working directory to save

include("D:/animated-adventure-in-mathematics/themes.jl");

using Plots     # load package
#using Pkg;Pkg.add("Distributions")
using Distributions


n = 1000        # number of pts
r_x = randn(n)  # rand with normal distribution
r_y = zeros(n)  # we have to specify y location, otherwise the plot package thinks we are plotting time series
Plots.scatter!(theme_dark(),r_x,r_y;alpha = .2,ylim = (-.5,.5))
savefig("ch1-1-1dscatter.png")
```

```
Error: could not open file D:\animated-adventure-in-mathematics\RandomPts\t
hemes.jl
```



```julia

#r_x = randn(n)  # rand with normal distribution
r_y = randn(n)  # we have to specify y location, otherwise the plot package thinks we are plotting time series

Plots.scatter!(theme_dark(),r_x,r_y;alpha = .2, aspect_ratio = [1 1])
savefig("2dscatter3.png")
```

```
Error: UndefVarError: n not defined
```



```julia
r_z = randn(n)  # we have to specify y location, otherwise the plot package thinks we are plotting time series
Plots.scatter!(theme_dark(),r_x,r_y,r_z;alpha = .2,aspect_ratio = 1)
savefig("3dscatter.png")
```

```
Error: UndefVarError: n not defined
```



```julia
cd("D:/animated-adventure-in-mathematics/")
```




## Area with Monte-Carlo




## Central Limit Thrm 
To Do


## Diffusions

```julia

n = 16

nStep = 2^7
x = zeros(Float64,nStep,3,n)
for i in 1:3, j in 1:n
    x[:,i,j] = cumsum(rand(Cauchy(),nStep))
end

using Plots
t1=time()
gr()
a = @animate for i in 1:nStep
    p=Plots.plot(x[1:i,1,:],x[1:i,2,:],x[1:i,3,:];xlabel = "x",ylabel = "y",zlabel = "z",
    key = false,colorkey =true,grid=(1, 0.9),bg_color=:black,fg_color = RGB(.7,.7,1),size=(1080,720),dpi=150)
    Plots.title!(p,"Step $i")
end

gif(a,"Levy_FlightMult.gif",fps=12)
time()-t1
```

```
Error: UndefVarError: Cauchy not defined
```

![](Levy_FlightMult.gif)





```julia
n = 16
nStep = 2^7
x = zeros(Float64,nStep,3,n)
for i in 1:3, j in 1:n
    x[:,i,j] = cumsum(randn(nStep));
end

using Plots
t1=time()
gr()
a = @animate for i in 1:nStep
    p=Plots.plot(x[1:i,1,:],x[1:i,2,:],x[1:i,3,:];xlabel = "x",ylabel = "y",zlabel = "z",
    key = false,colorkey =true,grid=(1, 0.9),bg_color=:black,fg_color = RGB(.7,.7,1),size=(1080,720),dpi=150)
    Plots.title!(p,"Step $i")
end

gif(a,"Brownian_FlightMult.gif",fps=12)
time()-t1
```

```
19.555000066757202
```




![](Brownian_FlightMult.gif)