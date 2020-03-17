##  ----------------------------------------------------------------
##  [t_sol, z_sol, r_big] = trajectory (b_big, phi_pd)
##  ----------------------------------------------------------------
##  Determines the trajectory and range for projectile motion where drag is
##  proportional to the square of speed.
##  Input:
##    b_big  is the dimensionless group B == (b u^2) / (m g)
##    phi_pd is the launch angle phi divided by a degree, i.e. phi / degree
##  Output:
##    t_sol  is the column of solution t values
##    z_sol  is the matrix of solution (xdot, ydot, x, y) values
##    r_big  is the range R
##  Note that
##    b   is the drag coefficient
##    g   is the gravitational field strength
##    m   is the mass of the projectile
##    u   is the launch speed
##    phi is the launch angle.
##  The dimensionless group B == (b u^2) / (m g) is the initial drag-to-weight
##  ratio. After scaling by L == u^2 / g and T == u / g (which are the length
##  and time scales in the absence of drag), we get in scaled variables:
##    d/dt (xdot) ==    - B xdot sqrt (xdot^2 + ydot^2), xdot(0) == cos (phi)
##    d/dt (ydot) == -1 - B ydot sqrt (xdot^2 + ydot^2), xdot(0) == sin (phi)
##    d/dt (x)    ==        xdot                       ,    x(0) == 0
##    d/dt (y)    ==        ydot                       ,    y(0) == 0.
##  This is solved using ode45.

function [t_sol, z_sol, r_big] = trajectory (b_big, phi_pd)
  
  ## Right hand side of system of ODEs in z == (xdot, ydot, x, y)
  fun = @(t, z) [
       - b_big * z(1) * sqrt(z(1)^2 + z(2)^2)
    -1 - b_big * z(2) * sqrt(z(1)^2 + z(2)^2)
                 z(1)
                 z(2)
  ];
  
  ## Initial values
  t_init = 0;
  z_init = [cosd(phi_pd), sind(phi_pd), 0, 0];
  
  ## Do not solve system of ODEs in the degenerate case phi == 0
  if (phi_pd == 0)
    t_sol = t_init;
    z_sol = z_init;
    r_big = z_init(3);
    return;
  endif
  
  ## Suppress termination warning
  warning ("off", "integrate_adaptive:unexpected_termination");
  
  ## Subfunction event_y_zero is defined below (for detecting y == 0 crossing)
  ## ----------------------------------------------------------------
  ## 1ST PASS: Determine flight time approximately
  ## ----------------------------------------------------------------
  
  ## Zero-drag flight time 2 sin (phi) is an upper bound
  t_end = 2 * sind (phi_pd);
  
  ## Time interval for ODE
  t_range = [t_init, t_end];
  
  ## ODE options structure (keep default time step)
  ode_struct = odeset ("Events", @event_y_zero);
  
  ## Solve system of ODEs
  [t_sol, z_sol] = ode45 (fun, t_range, z_init, ode_struct);
  
  ## Flight time
  t_end = t_sol(end);
  
  ## ----------------------------------------------------------------
  ## 2ND PASS: Use finer step size
  ## ----------------------------------------------------------------
  
  ## True flight time will probably be within 2/n of the rough flight time
  ## above, where n is the number of steps in the coarse solution above
  t_end = (1 + 2 / length (t_sol)) * t_end;
  
  ## Time interval for ODE
  t_range = [t_init, t_end];
  
  ## Maximum time step
  t_step = (t_end - t_init) / 100;
  
  ## ODE options structure
  ode_struct = odeset ("Events" , @event_y_zero, "MaxStep", t_step);
  
  ## Solve system of ODEs
  [t_sol, z_sol] = ode45 (fun, t_range, z_init, ode_struct);
  
  ## Range
  r_big = z_sol(end,3);
  
  ## Restore termination warning
  warning ("on", "integrate_adaptive:unexpected_termination");
  
endfunction

## Event function which detects y == 0 decreasing crossing

function [value, is_terminal, direction] = event_y_zero (t, z)
  
  value = z(4);
  is_terminal = true;
  direction = -1;
  
endfunction
