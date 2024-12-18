% MATLAB script to plot the 16-PAM constellation diagram 

% Number of levels in PAM (M-PAM)
M = 16; % Example for 4-PAM

% Symbol Energy Es
Es = 1; % Set the desired symbol energy

% Generate M-PAM constellation points
% The PAM constellation points for M-PAM are centered around zero and spaced by 2.
constellation_points = -(M-1):2:(M-1);

% Calculate the average energy of the generated constellation
average_energy = mean(constellation_points.^2);

% Normalize the constellation to have the desired symbol energy Es
normalized_constellation = constellation_points * sqrt(Es / average_energy);

% Display the constellation points
disp('Normalized PAM Constellation Points:');
disp(normalized_constellation);

% Plot the constellation
figure;
stem(normalized_constellation, zeros(size(normalized_constellation)), 'filled');
title(sprintf('%d-PAM Constellation', M));
xlabel('In-Phase Component');
ylabel('Quadrature Component');
grid on;
axis([-M M -1 1]);

% Annotate each point with its symbol label
for i = 1:M
    % Label with symbol's index
    label = sprintf('s_{%d}', i);
    text(normalized_constellation(i), 0, label, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10, 'FontName', 'Helvetica');
end