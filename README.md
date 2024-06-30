
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
