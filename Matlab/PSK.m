%MATLAB script to plot the 16-PSK constellation diagram

% Number of levels in PSK (M-PSK)
M = 16; % Example for 4-PSK

% Symbol Energy Es
Es = 1; % Set the desired symbol energy

% Generate M-PSK constellation points
% The PSK constellation points are uniformly distributed on the unit circle.
theta = (0:M-1) * (2 * pi / M); % Angles for PSK points
constellation_points = exp(1i * theta); % Complex exponentials for PSK points

% Normalize the constellation to have the desired symbol energy Es
normalized_constellation = constellation_points * sqrt(Es);

% Display the constellation points
disp('Normalized PSK Constellation Points:');
disp(normalized_constellation);

% Plot the constellation
figure;
hold on; % Hold the plot for multiple plotting commands
title(sprintf('%d-PSK Constellation', M));
xlabel('In-Phase Component');
ylabel('Quadrature Component');
grid on;
axis equal;
axis([-1.5 1.5 -1.5 1.5]);

% Annotate each point with its symbol label
for i = 1:M
    % Plot each point as a dot
    plot(real(normalized_constellation(i)), imag(normalized_constellation(i)), 'o', 'MarkerSize', 8, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');
    % Label with only the symbol index
    label = sprintf('s_{%d}', i);
    text(real(normalized_constellation(i)), imag(normalized_constellation(i)), label, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10, 'FontName', 'Helvetica');
end

hold off; % Release the plot hold