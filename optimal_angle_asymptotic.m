##  ----------------------------------------------------------------
##  phi_pd_opt = optimal_angle_asymptotic (b_big)
##  ----------------------------------------------------------------
##  Determines the asymptotic optimal launch angle (which maximises range)
##  for projectile motion where drag is proportional to the square of speed,
##  but weak.
##  Input:
##    b_big      is the dimensionless group B == (b u^2) / (m g) << 1
##  Output:
##    phi_pd_opt is the optimal launch angle phi divided by a degree,
##               i.e. phi_opt / degree
##  For more details see trajectory.m.

function phi_pd_opt = optimal_angle_asymptotic (b_big)
  
  ## Construct polynomial coefficients to second order
  p = log ((1 + 1 / sqrt (2)) / (1 - 1 / sqrt (2)));
  phi_coeffs = zeros (1, 3);
  phi_coeffs(3) = pi / 4;
  phi_coeffs(2) = - 3/32 * sqrt (2) + 1/64 * p;
  phi_coeffs(1) = - 1393/3840 + 81/512 * sqrt (2) * p + 17/2048 * p^2;
  
  ## Evaluate
  phi_pd_opt = polyval (phi_coeffs, b_big) * 180 / pi;
  
endfunction
