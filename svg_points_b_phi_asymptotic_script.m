b_big_values = (0 : 0.05 : 2.05)';
phi_pd_opt_values = optimal_angle_asymptotic (b_big_values);

## Scale B and negate phi for SVG
b_big_values *= 4;
phi_pd_opt_values *= -1;

csvwrite (
  "svg_points_b_phi_asymptotic.csv",
  [b_big_values, phi_pd_opt_values],
  "precision", 4
);
