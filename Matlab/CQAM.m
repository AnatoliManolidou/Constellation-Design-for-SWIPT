%MATLAB script to plot the 16-CQAM constellation diagram

% Parameters
num_symbols_per_circle = 4;
num_circles = 4; 

% Initial radii
initial_radii = [1, 2, 3, 4];

% Calculate the scaling factor
scaling_factor = sqrt(4 / sum(initial_radii .^ 2)); %0.3651

% Scale the radii
scaled_radii = initial_radii * scaling_factor;

% Generate constellation points
constellation_points = [];

for i = 1:num_circles
    radius = scaled_radii(i);
    angles = linspace(0, 2 * pi, num_symbols_per_circle + 1);
    angles(end) = []; % remove the last angle to avoid overlapping the first point
    rotated_angles = angles + (i - 1) * pi / 4; % Rotate each circle by 45 degrees
    points = radius * exp(1j * rotated_angles);
    constellation_points = [constellation_points; points.’];
end

% Plot the constellation
figure;
hold on;
scatter(real(constellation_points), imag(constellation_points), 100, ’b’, ’filled’);

% Plot dashed circles
theta = linspace(0, 2*pi, 100);
for i = 1:num_circles
    radius = scaled_radii(i);
    x = radius * cos(theta);
    y = radius * sin(theta);
    plot(x, y, ’--k’);
end

line([-1 1], [0 0], ’Color’, ’k’); % x-axis
line([0 0], [-1 1], ’Color’, ’k’); % y-axis
xlabel(’In-Phase’);
ylabel(’Quadrature’);
title(’Circular QAM Constellation with 16 Symbols (45-degree Rotation)’);
grid on;
axis equal;

for i = 1:length(constellation_points)
    label = sprintf(’s_{%d}’, i);
    text(real(constellation_points(i)) + 0.1, imag(constellation_points(i)) + 0.1,label);
end

hold off;

% Calculate dmin
distances = [];
for i = 1:length(constellation_points)
    for j = i+1:length(constellation_points)
    distances(end+1) = abs(constellation_points(i) - constellation_points(j));
    end
end

dmin = min(distances);

% Display dmin
disp(scaled_radii)
disp([’dmin = ’, num2str(dmin)]);
sum_abs_values = sum(abs(constellation_points).^2);
Es = sum_abs_values / 16;
disp([’Sum of absolute values of each symbol = ’, num2str(sum_abs_values), ’, thus Es = ’, num2str(Es)]);