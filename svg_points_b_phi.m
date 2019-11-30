b_big_values = (0 : 0.1 : 5)';
phi_pd_opt_values = optimal_angle (b_big_values);

## Scale B and negate phi for SVG
b_big_values *= 4;
phi_pd_opt_values *= -1;

csvwrite (
  "svg-points-b-phi.csv",
  [b_big_values, phi_pd_opt_values],
  "precision", 4
);