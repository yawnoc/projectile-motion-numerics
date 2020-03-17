##  ----------------------------------------------------------------
##  phi_pd_opt = optimal_angle (b_big, abs_tol)
##  ----------------------------------------------------------------
##  Determines the optimal launch angle (which maximises range) for projectile
##  motion where drag is proportional to the square of speed.
##  Input:
##    b_big      is the dimensionless group B == (b u^2) / (m g)
##               or a list of such values
##    abs_tol    is the absolute tolerance in phi_pd (default 0.01)
##  Output:
##    phi_pd_opt is the optimal launch angle phi divided by a degree,
##               i.e. phi_opt / degree
##               or the list of such values corresponding to b_big 
##  For more details see trajectory.m.

function phi_pd_opt = optimal_angle (b_big, abs_tol)
  
  ## Set default abs_tol if not supplied
  if (nargin < 2)
    abs_tol = 0.01;
  endif
  
  ## Number of values of B:
  n_values = numel (b_big);
  
  ## Single value
  if n_values == 1
    
    ## Range as a function of launch angle divided by a degree
    range_fun = @(phi_pd) range (b_big, phi_pd);
    
    ## Search interval
    phi_pd_range = [0, 90];
    
    ## Determine optimal angle using bisection
    phi_pd_opt = arg_max_bisection (range_fun, phi_pd_range, abs_tol);
    
    return;
  
  ## Multiple values
  else
    
    ## Initialise array for values
    phi_pd_opt = zeros (size (b_big));
    
    ## Timer on
    tic;
    
    ## Initialise progress indicator
    handle = waitbar (0, "Computing optimal launch angles");
    
    ## Compute values
    for n = 1 : n_values
      
      ## Optimal launch angle per degree
      phi_pd_opt(n) = optimal_angle (b_big(n));
      
      ## Progress indicator
      waitbar (n / n_values, handle);
      
    endfor
    
    ## Close progress indicator
    close (handle);
    
    ## Timer off
    toc;
    
    return;
    
  endif
  
endfunction
