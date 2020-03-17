b_big_values = [ ...
  0 : 0.1 : 1, ...
  2 : 1 : 10, ...
  15, 20, 50, 100, 200, 500, ...
  10 .^ [3, 4, 6, 8]
]';

phi_pd_opt_values = optimal_angle (b_big_values);

csvwrite (
  "table_b_phi.csv",
  [b_big_values, phi_pd_opt_values],
  "precision", 3
);


small_b_indices = b_big_values <= 2;
b_big_values = b_big_values(small_b_indices);
phi_pd_opt_values = phi_pd_opt_values(small_b_indices);
phi_pd_opt_asy_values = optimal_angle_asymptotic (b_big_values);
percent_error_values = (phi_pd_opt_asy_values ./ phi_pd_opt_values - 1) * 100;

csvwrite (
  "table_b_phi_asymptotic.csv",
  [b_big_values, phi_pd_opt_asy_values, percent_error_values],
  "precision", 3
);
