b_big = 3;
phi_pd = atand (2);

[~, z_sol, r_big] = trajectory (b_big, phi_pd);

x_sol = z_sol(:, 3);
y_sol = z_sol(:, 4);

## Scale to order 10 and negate y coordinates for SVG
len = r_big / 10;
x_sol =  x_sol / len;
y_sol = -y_sol / len;

csvwrite ("svg-points-trajectory.csv", [x_sol, y_sol], "precision", 3);
