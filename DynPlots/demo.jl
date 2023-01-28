t = 1:20
x = 1:20
y=x;z=y
xseq = collect(x)
yseq = collect(y)
zseq = collect(z)
#using Plots
include("D:/animated-adventure-in-mathematics/themes.jl");
cd("D:/animated-adventure-in-mathematics/DynPlots/")
using Distributed
include("sourcing.jl")

A = [1. .5;
    0 1]
f(x,y) = (A*[x,y])[1]
g(x,y) = (A*[x,y])[2]

xbase_c = -5:.5:5
ybase_c = -5:.5:5
xbase = -5:.1:5
ybase = -5:.1:5
p=plotVF!(theme_default(),f,g,xbase_c,ybase_c)
p=plotNullCline!(p,f,g,xbase,ybase)

p=plotValongCycle!(p,f,g,r=1,center = (0.0,0.0);s=.3)

👾 = DynSpace(tuple('x'=>-5:1:5,'y'=>ybase_c),tuple('C'=>[1]))

F(X,K) = K[1]*[f(X[1],X[2]), g(X[1],X[2])]
δt = .0001
ϕ(X,K) = dyn_grad_Euler(X,K,F,δt)

@time result = dyn_collect(👾,ϕ,n=2000)

#result[:,:,1]


plotTrajectoryMatrix!(plot(legend=false,colorbar = true),result[:,:,1])

p=plotMultipleTrajectoryMatrix!(plot!(p,legend=false,colorbar = true,xlims = (-5,5),ylims = (-5,5)),result[:,:,:])

savefig("DynPlots.png")
