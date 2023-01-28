#dyn_gradient converter

function dyn_grad_Euler(x,params::Array,FUN::Function,delta_t)
    return x .+ FUN(x,params).* delta_t
end

function dyn_grad_Euler_B2(x,params,GRAD_FUN::Function,delta_t;FEED_FUN = dyn_grad_Euler)
	return x .+ GRAD_FUN(FEED_FUN(x,params,GRAD_FUN,delta_t),params).*delta_t
end
#use Eulers' method to find forward 1st soln

function dyn_grad_Runge_Kutta2_Euler_Cauchy(x,params,GRAD_FUN::Function,delta_t)
	x_halfStep = x .+ .5 .* GRAD_FUN(x,params) .*delta_t
	return x .+ delta_t  .* GRAD_FUN(x_halfStep,params)
end

function dyn_grad_Runge_Kutta4(x,params,GRAD_FUN::Function,delta_t)
	k1 = GRAD_FUN(x,params)
	k2 = GRAD_FUN(x.+delta_t./2 .*k1,params)
	k3 = GRAD_FUN(x.+delta_t./2 .*k2,params)
	k4 = GRAD_FUN(x.+delta_t.*k3,params)
	return x.+delta_t/6 .*(k1 .+ 2 .*k2 .+ 2 .*k3 .+k4)
end

