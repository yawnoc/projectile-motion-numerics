##  ----------------------------------------------------------------
##  phi_pd_opt = optimal_angle (b_big, abs_tol)
##  ----------------------------------------------------------------
##  Determines the optimal launch angle (which maximises range) for projectile
##  motion where drag is proportional to the square of speed.
##  Input:
##    b_big      is the dimensionless group B == (b u^2) / (m g)
##    abs_tol    is the absolute tolerance in phi_pd
##  Output:
##    phi_pd_opt is the optimal launch angle phi divided by a degree,
##               i.e. phi_opt / degree (default 0.01)
##  For more details see trajectory.m.

function phi_pd_opt = optimal_angle (b_big, abs_tol)
  
  ## Set default abs_tol if not supplied
  if (nargin < 2)
    abs_tol = 0.01;
  endif
  
  ## Range as a function of launch angle divided by a degree
  range_fun = @(phi_pd) range (b_big, phi_pd);
  
  ## Search interval
  phi_pd_range = [0, 90];
  
  ## Determine optimal angle using bisection
  phi_pd_opt = arg_max_bisection (range_fun, phi_pd_range, abs_tol);
  
endfunction