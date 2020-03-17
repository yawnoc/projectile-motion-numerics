##  ----------------------------------------------------------------
##  x_opt = arg_max_bisection (fun, x_range, abs_tol)
##  ----------------------------------------------------------------
##  Determines maximising argument using the bisection algorithm.
##  Input:
##    fun     is the unimodal function to be maximised
##    x_range is the row of endpoints of the initial search interval in x
##    abs_tol is the absolute tolerance in x (default 1e-4 of the width of
##               x_range)
##  Output:
##    x_opt   is the optimal x
##  At each step, the function is evaluated at the five equally spaced points
##    x_a, x_b, x_c, x_d, x_e
##  to obtain function values
##    f_a, f_b, f_c, f_d, f_e
##  from which the width of the search interval is narrowed by half.

function x_opt = arg_max_bisection (fun, x_range, abs_tol)
  
  ## Midpoint function
  mid = @(x_1, x_2) (x_1 + x_2) / 2;
  
  ## Initialise endpoints and midpoint of interval
  x_a = min (x_range);
  x_e = max (x_range);
  x_c = mid (x_a, x_e);
  
  ## Initialise function values at these points
  f_a = fun (x_a);
  f_e = fun (x_e);
  f_c = fun (x_c);
  
  ## Set default abs_tol if not supplied
  if (nargin < 3)
    abs_tol = (x_e - x_a) * 1e-4;
  endif
  
  ## Iterate
  while (abs (x_e - x_a) >= abs_tol)
    
    ## Quarter and three-quarter points of search interval
    x_b = mid (x_a, x_c);
    x_d = mid (x_c, x_e);
    
    ## Function values at these points
    f_b = fun (x_b);
    f_d = fun (x_d);
    
    ## Location (index) where function is maximised among the five points
    ##  ind     ==    1    2    3    4    5
    [~, ind] = max ([f_a, f_b, f_c, f_d, f_e]);
    
    ## Halve width of search interval. There are three cases:
    
    ## Maximum lies to the left half
    if (ind <= 2) 
      [x_c, x_e] = {x_b, x_c}{:};
      [f_c, f_e] = {f_b, f_c}{:};
    ## Maximum lies to the right half
    elseif (ind >= 4)
      [x_a, x_c] = {x_c, x_d}{:};
      [f_a, f_c] = {f_c, f_d}{:};
    ## Maximum lies in the central half
    else
      [x_a, x_e] = {x_b, x_d}{:};
      [f_a, f_e] = {f_b, f_d}{:};
    endif
    
  endwhile
  
  ## Maximising argument
  x_opt = x_c;
  
endfunction
