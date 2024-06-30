clear all
clc 

format long
global kappa tau N % Global variables for curvature and torsion

% Initial values of the x, y, z components of r, t, n, b
% r is the position vector
% t is the tangent vector
% n is the normal vector
% b is the binormal vector

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

% Arc length and number of nodal points for discretization
N = 400;
s = linspace(0, 1, N + 1); % Discrete arc length

% Define curvature and torsion
kappa = 13.14 * sin(3 * pi * s); % Example curvature
tau = 8.094 * ones(1, length(kappa)); % Example torsion

% Ensure curvature and torsion are column vectors
kappa = kappa(:);
tau = tau(:);

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



% measuring lenght of each segment to verify if the r is arclength
% parameterized 

dl = sqrt((rx(2:end,1)-rx(1:end-1,1)).^2 + (ry(2:end,1)-ry(1:end-1,1)).^2 + (rz(2:end,1)-rz(1:end-1,1)).^2);  % each element of dl should be equal



% Post-processing: Plotting the curve
figure(1)
plot3(rx, ry, rz, 'LineWidth', 4)
box on
grid on
set(gca, 'FontSize', 25, 'LineWidth', 0.5)
set(gcf, 'color', 'w');

% Set labels
xlabel('$x$', 'FontSize', 25, 'Interpreter', 'latex');
ylabel('$y$', 'FontSize', 25, 'Interpreter', 'latex');
zlabel('$z$', 'FontSize', 25, 'Interpreter', 'latex');
title('Curve', 'FontSize', 25, 'Interpreter', 'latex');



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
