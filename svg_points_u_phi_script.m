u_per_c_values = (0 : 0.1 : 4)';
b_big_values = u_per_c_values .^ 2;
phi_pd_opt_values = optimal_angle (b_big_values);

## Scale u/c and negate phi for SVG
u_per_c_values *= 5;
phi_pd_opt_values *= -1;

csvwrite (
  "svg_points_u_phi.csv",
  [u_per_c_values, phi_pd_opt_values],
  "precision", 4
);
