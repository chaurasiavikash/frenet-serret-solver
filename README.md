
# Frenet-Serret Frame Solver and Animator

This repository contains MATLAB scripts for solving the Frenet-Serret equations and visualizing the resulting 3D curve along with the Frenet frame vectors (tangent, normal, and binormal).

## Overview

The solver uses the `ode45` function to solve the Frenet-Serret equations using the Runge-Kutta 4 method. The results are saved in text files and can be visualized using an animation script.

## Files

- `main_solver.m`: Main script to solve the Frenet-Serret equations.
- `fun_rk4.m`: Function to define the Frenet-Serret equations.
- `animation.m`: Script to visualize the 3D curve and Frenet frame vectors.
- `position.txt`, `tangent.txt`, `normal.txt`, `binormal.txt`: Output files containing the solved vectors.

## Instructions

### 1. Setting Initial Conditions

In `main_solver.m`, specify the initial conditions for the position vector `r`, tangent vector `t`, normal vector `n`, and binormal vector `b`.

Example:
```matlab
% Initial position vector
rx0 = 0;
ry0 = -0.1276;
rz0 = 0;

% Initial tangent vector (must be a unit vector)
tx0 = 0.9280;
ty0 = 0;
tz0 = -0.3726;

% Initial normal vector (must be a unit vector)
nx0 = 0.3726;
ny0 = 0;
nz0 = 0.9280;

% Initial binormal vector (must be a unit vector, b = t x n)
bx0 = ty0 * nz0 - tz0 * ny0;
by0 = tz0 * nx0 - tx0 * nz0;
bz0 = tx0 * ny0 - ty0 * nx0;

% Initial condition vector
in_rk = [rx0 ry0 rz0 tx0 ty0 tz0 nx0 ny0 nz0 bx0 by0 bz0];
```
 
### 2. Discretization and Curvature/Torsion
```
% Number of nodal points for discretization
N = 400;
s = linspace(0, 1, N + 1); % Discrete arc length

% Define curvature and torsion
kappa = 13.14 * sin(3 * pi * s); % Example curvature
tau = 8.094 * ones(1, length(kappa)); % Example torsion

% Ensure curvature and torsion are column vectors
kappa = kappa(:);
tau = tau(:);
```


###  3. Solve the Equations
Run main_solver.m to solve the Frenet-Serret equations using ode45. The results will be saved in the current directory as text files (position.txt, tangent.txt, normal.txt, binormal.txt).

```
% Set ODE solver options
opts = odeset('RelTol', 1e-16, 'AbsTol', 1e-16);

% Solve ODE
[t, y] = ode45(@fun_rk4, s, in_rk, opts);

% Extract position, tangent, normal, and binormal vectors
rx = y(:, 1);
ry = y(:, 2);
rz = y(:, 3);
tx = y(:, 4);
ty = y(:, 5);
tz = y(:, 6);
nx = y(:, 7);
ny = y(:, 8);
nz = y(:, 9);
bx = y(:, 10);
by = y(:, 11);
bz = y(:, 12);

% Save data to text files
save_to_file('./position.txt', [rx, ry, rz]);
save_to_file('./tangent.txt', [tx, ty, tz]);
save_to_file('./normal.txt', [nx, ny, nz]);
save_to_file('./binormal.txt', [bx, by, bz]);

% Function to save data to a text file
function save_to_file(filename, data)
    fileID = fopen(filename, 'w');
    fprintf(fileID, '%30.16E %30.16E %30.16E \r\n', data');
    fclose(fileID);
end 
```

### 4. Visualize the Results
Run animation.m to visualize the 3D curve and the Frenet frame vectors. The animation will show the evolution of the curve along with the tangent, normal, and binormal vectors.
