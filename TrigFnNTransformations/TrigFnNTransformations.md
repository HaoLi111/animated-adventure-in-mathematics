---
author: "Hao Li"
title: "Elementary Functions & Transformations"
date: "04/20/2020"
bibliography: "biblio.bib"
---
```julia
cd("D:/animated-adventure-in-mathematics/TrigFnNTransformations")
include("D:/animated-adventure-in-mathematics/themes.jl");
using Plots
```




## Definitions and Properties


```julia
using Plots
include("themes.jl")

theta = -pi:.01:pi
```

```
Error: could not open file D:\animated-adventure-in-mathematics\TrigFnNTran
sformations\themes.jl
```



```julia
r = 1

l=3
tseq = 0:.01:(2*pi)
a=@animate for t in tseq
Plots.plot!(theme_default(),r .* sin.(theta), r .*cos.(theta),aspect_ratio=1)
Plots.plot!([0,l*cos(t)], [0,l*sin(t)])
Plots.plot!([0,-l*cos(t)], [0,-l*sin(t)])
Plots.plot!([r*cos(t),r*cos(t)],[0,r*sin(t)])
Plots.plot!([0,cos(t)],[0,0])
Plots.plot!([1,1],[0,tan(t)],xlim = [-1.5,1.5],ylim = [-1.5,1.5],key = false)
Plots.title!("Theta = $t")
end
gif(a,"1.gif")

t = 1

a=@animate for t in tseq
Plots.plot!(theme_default(),x->sin(x-t),xlim = (-pi,pi))
Plots.plot!(x->cos(x-t),xlim = (-pi,pi))
Plots.plot!(x->tan(x-t),xlim = (-pi,pi),ylim = (-2,2))
Plots.title!("y1=sin(x-t);y2=cos(x-t);y3=tan(x-t)")
end
gif(a,"2.gif")

Plots.plot(x->atan(x),xlim = (-5,5))
```

```
Error: UndefVarError: theta not defined
```





![](1.gif)


![](2.gif)


```julia
cd("D:/animated-adventure-in-mathematics/")
```

