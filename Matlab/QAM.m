%MATLAB script to plot the 16-QAM constellation diagram

% Define the 16-QAM modulation order
M = 16; % Modulation order for 16-QAM

% Generate the symbol indices
symbolIndices = 0:M-1;

% Generate 16-QAM constellation points using MATLAB’s qammod function
constellation_points = qammod(symbolIndices, M, ’UnitAveragePower’, true);

% Plot the constellation diagram
figure;

%plot(real(constellation_points), imag(constellation_points), ’bo’, ’MarkerSize’, 10,’LineWidth’, 2);
scatter(real(constellation_points), imag(constellation_points), 100, ’b’, ’filled’);
title(’16-QAM Constellation Diagram (E_s = 1)’);
xlabel(’In-Phase (I)’);
ylabel(’Quadrature (Q)’);
grid on;
axis equal;

% Label the constellation points
for i = 1:length(constellation_points)
    label = sprintf(’s_{%d}’, i);
    text(real(constellation_points(i)) + 0.1, imag(constellation_points(i)) + 0.1,label);
end

% Display the plot
hold off;