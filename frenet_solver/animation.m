% Animation of the 3D curve with Frenet frame vectors
clear all
clc

% Load data
position = load('./position.txt');
tangent = load('./tangent.txt');
normal = load('./normal.txt');
binormal = load('./binormal.txt');

rx = position(:, 1);
ry = position(:, 2);
rz = position(:, 3);
tx = tangent(:, 1);
ty = tangent(:, 2);
tz = tangent(:, 3);
nx = normal(:, 1);
ny = normal(:, 2);
nz = normal(:, 3);
bx = binormal(:, 1);
by = binormal(:, 2);
bz = binormal(:, 3);

% Create figure
figure
hold on
grid on
axis equal
set(gca, 'FontSize', 15)
set(gcf, 'color', 'w');

% Set labels
xlabel('$x$', 'FontSize', 15, 'Interpreter', 'latex');
ylabel('$y$', 'FontSize', 15, 'Interpreter', 'latex');
zlabel('$z$', 'FontSize', 15, 'Interpreter', 'latex');

xlim([1*min(rx) 1*max(rx)])
ylim([1*min(ry) 1*max(ry)])
zlim([2*min(rz) 2*max(rz)])


title('3D Curve with Frenet Frame', 'FontSize', 15, 'Interpreter', 'latex');

% Set isometric view
   view([1,1,1])

% Plot initial curve
curve = plot3(rx, ry, rz, 'k', 'LineWidth', 3.5);

% Scale for quiver arrows
quiverScale = 0.05;

% Initialize Frenet frame vectors
hT = quiver3(rx(1), ry(1), rz(1), tx(1), ty(1), tz(1), 'r', 'LineWidth', 1.5, 'AutoScale', 'off');
hN = quiver3(rx(1), ry(1), rz(1), nx(1), ny(1), nz(1), 'g', 'LineWidth', 1.5, 'AutoScale', 'off');
hB = quiver3(rx(1), ry(1), rz(1), bx(1), by(1), bz(1), 'b', 'LineWidth', 1.5, 'AutoScale', 'off');

% Animation loop
for i = 2:length(rx)
    % Update curve
    set(curve, 'XData', rx(1:i), 'YData', ry(1:i), 'ZData', rz(1:i));
    
    % Update Frenet frame vectors
    set(hT, 'XData', rx(i), 'YData', ry(i), 'ZData', rz(i), 'UData', quiverScale * tx(i), 'VData', quiverScale * ty(i), 'WData', quiverScale * tz(i));
    set(hN, 'XData', rx(i), 'YData', ry(i), 'ZData', rz(i), 'UData', quiverScale * nx(i), 'VData', quiverScale * ny(i), 'WData', quiverScale * nz(i));
    set(hB, 'XData', rx(i), 'YData', ry(i), 'ZData', rz(i), 'UData', quiverScale * bx(i), 'VData', quiverScale * by(i), 'WData', quiverScale * bz(i));
    
    % Pause to create animation effect
    pause(0.01);
end

hold off
