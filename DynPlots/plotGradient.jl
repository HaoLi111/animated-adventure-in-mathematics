"plotVF!(fx,fy,x,y) plot vector field"
function plotVF!(p,fx::Function,fy::Function,xbase::Union{Array,UnitRange,StepRangeLen},ybase::Union{Array,UnitRange,StepRangeLen};map_speed = true,log_speed = false)


    dxbase = xbase[2] - xbase[1]
    dybase = ybase[2] - ybase[1]
    dxybase = sqrt(dxbase^2+dybase^2)
    cprod = collect.(collect(Base.product(xbase,ybase))) # not writing for-loop, use Cartesian product of x base and y base, cprod is a permutation set
    cprod = vec(cprod)
    x = map(x->x[1],cprod)
    y = map(x->x[2],cprod)
    dx=map(x->fx(x[1],x[2]),cprod)
    dy=map(x->fy(x[1],x[2]),cprod)
    speed = sqrt.(dx.^2 .+ dy.^2)#[sqrt(dx[i]^2+dy[i]^2) for i in 1:length(dx)]

    if log_speed
        speed = log.(speed)
        dx=log.(dx)
        dy = log.(dy)
    end

    #normalization
    dx ./=maximum(abs.(dx))
    dx .*=dxbase
    dy ./=maximum(abs.(dy))
    dy .*=dybase
    #show(dx);show(dy)
    #how(speed)

    if map_speed
        return quiver!(p,x,y,quiver = (dx,dy))#;markerstrokecolor = qcMap_def(speed))
    end
    return quiver!(p,x,y,quiver = (dx,dy))
end


#fx(x,y)=x;fy(x,y)=y
#plotVF!(plot(),fx,fy,collect(-3:1.0:3),collect(-3:1.0:3))

#quiver(1:10,1:10,quiver=(10:-1:1,10:-1:1),markerstrokecolor = qcMap_def(1:10))

"plotGradient!(p,x) - autonomous"
function plotGradient!(p,fx::Function,xbase;t = 0:1.0:5,map_speed = true,log_speed = false,normalize = true)
    if t==Missing
        t = 1:1.0:length(x)
    end
    dt = t[2]-t[1]
    dx = xbase[2] - xbase[1]



    if isinteger(t[1])
        t = Float64.(t)
    end
    if isinteger(xbase[1])
        xbase = Float64.(xbase)
    end
    
    dtbase = t[2] - t[1]
    dxbase = xbase[2] - xbase[1]
    dbase = sqrt(dt^2+dt^2)
    cprod = collect.(collect(Base.product(t,xbase))) # not writing for-loop, use Cartesian product of x base and y base, cprod is a permutation set
    cprod = vec(cprod)
    x = map(x->x[2],cprod)
    t = map(x->x[1],cprod)
    dt= repeat([dtbase],length(t))
    dx=map(x->fx(x[2]),cprod)
    speed = sqrt.(dt.^2 .+ dx.^2)#[sqrt(dt[i]^2+dx[i]^2) for i in 1:length(dt)]
    
    if log_speed
        speed = log.(speed)
        dt=log.(dt)
        dx = log.(dx)
    end
    
    #normalization
    if normalize
        dx ./=maximum(abs.(dx))
        dx .*=dxbase
        #shrinks t vec also so that gradient is preserved

        dt ./=maximum(abs.(dx))
        dt .*-dtbase
    end
    #show(dt);show(dx)
    #how(speed)
    
    if map_speed
        return quiver!(p,t,x,quiver = (dt,dx))#;markerstrokecolor = qcMap_def(speed))
    end
    return quiver!(p,t,x,quiver = (dt,dx))    
end


"plotNullCline(fx,fy)"
function    plotNullCline!(p,fx::Function,fy::Function,xbase,ybase;tol = 1e-3)
    p=contour!(p,xbase,ybase,[fx(xi,yi) for yi in ybase, xi in xbase],levels = [-tol,tol],color = :red,alpha = .3)#,key = "x NullCline est")
    p=contour!(p,xbase,ybase,[fy(xi,yi) for yi in ybase, xi in xbase],levels = [-tol,tol],color =:blue ,alpha = .3)#,key = "y NullCline est")
    return p
end

#contour(1:2,1:2,[.11 .02;.1 0],levels = [-.1,.1])



"plotValongCycle!(p,fx::Function,fy::Function,cycle with r) works for 2d system only"
function plotValongCycle!(p,fx::Function,fy::Function,Cycle::Function;theta = 0.0:.3:2*pi,s=1.0)
    xl = zeros(length(theta))
    yl = similar(xl)
    dxl =similar(yl)
    dyl =similar(dxl)
    for i in 1:length(theta)
        err = ""
        try
            x,y = Cycle(theta[i])
            xl[i] = x
            yl[i] = y
            dxl[i] = fx(x,y)
            dyl[i] = fy(x,y)
        catch err
            println("Singularity?")
        end
    end

    for i in 1:length(dxl)
        dd = sqrt(dxl[i]^2+dyl[i]^2)
        if dd>eps()
            dxl[i]/=dd/s
            dyl[i]/=dd/s
        end
    end#scale vectors dx,dy around the cycle

    p = quiver!(p,xl,yl,quiver = (dxl,dyl))
    p = plot!(p,xl,yl;alpha = .3,key = false)
    return p
end

function circularCycle(theta;center = (0.0,0.0),r = 1.0)
    [center[1]+ r * cos(theta), center[2] + r * sin(theta) ]
end

function plotValongCycle!(p,fx::Function,fy::Function;r = 1.0,center = (0.0,0.0),theta = .3:.3:2*pi,s=1.0)
    cycle(theta) = circularCycle(theta;center = center,r=r)
    return plotValongCycle!(p,fx,fy,cycle;theta = .3:.3:2*pi,s=s)
end


