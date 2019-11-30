##  ----------------------------------------------------------------
##  r_big = range (b_big, phi_pd)
##  ----------------------------------------------------------------
##  Determines the range for projectile motion where drag is proportional to
##  the square of speed.
##  Input:
##    b_big  is the dimensionless group B == (b u^2) / (m g)
##    phi_pd is the launch angle phi divided by a degree, i.e. phi / degree
##  Output:
##    r_big  is the range R
##  For more details see trajectory.m.

function r_big = range (b_big, phi_pd)
  
  [~, ~, r_big] = trajectory (b_big, phi_pd);
  
endfunction