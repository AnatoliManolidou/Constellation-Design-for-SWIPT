% Parameters
M = 16;
N = 4; % Number of circles for CQAM
SNR_dB = 0:2:60; % Extended SNR range to reach higher values
num_symbols = 1e5; % Total number of symbols for simulation

% Define the constellation points for 16-PAM, 16-PSK, and 16-QAM
constellation_pam = pammod(0:(M-1), M, 0, 'gray');  % 16-PAM
constellation_psk = pskmod(0:(M-1), M, 0, 'gray');  % 16-PSK
constellation_qam = qammod(0:(M-1), M, 'gray');     % 16-QAM
constellation_cqam = generate_16CQAM(M, N);

% Function to generate 16-CQAM constellation
function constellation = generate_16CQAM(M, N)
    n = M / N;
    R1 = 1; % Smallest radius
    constellation = [];
    for i = 1:N
        Ri = R1 * i; % Increasing radius for each circle
        base_angle = pi/4 * (i-1); % Rotate each circle by 45 degrees more than the previous one
        angles = (0:n-1) * (2 * pi / n) + base_angle;
        constellation = [constellation, Ri * exp(1i * angles)]; % Append points
    end
end

% Function to calculate theoretical SEP for 16-PAM
function sep = sep_pam(SNR)
    M = 16;
    sep = 2 * (M - 1) / M * qfunc(sqrt(6 * SNR / (M^2 - 1)));
end

% Function to calculate theoretical SEP for 16-PSK
function sep = sep_psk(SNR)
    M = 16;
    sep = 2 * qfunc(sqrt(2 * SNR) * sin(pi / M));
end

% Function to calculate theoretical SEP for 16-QAM
function sep = sep_qam(SNR)
    M = 16;
    Ps_M = 2 * (1 - 1/sqrt(M)) * qfunc(sqrt(3 / (M - 1) * SNR));
    sep = 1 - (1 - Ps_M)^2;
end

% Function to calculate theoretical SEP for 16-CQAM
function sep = sep_cqam(SNR)
    M = 16;
    R = 1; % Smallest radius
    N = 4;
    sum_sq = sum((1:N).^2);
    Es_avg = (4 / M) * R^2 * sum_sq;
    SNR_eff = SNR * Es_avg;
    sep = 2 * (M - 1) / M * qfunc(sqrt(6 * SNR_eff / (M^2 - 1)));
end

% Calculate SEP vs SNR for each modulation scheme
SEP_vs_SNR = zeros(length(SNR_dB), 4);

for i = 1:length(SNR_dB)
    SNR_linear = 10^(SNR_dB(i)/10);
    SEP_vs_SNR(i, 1) = sep_pam(SNR_linear);
    SEP_vs_SNR(i, 2) = sep_psk(SNR_linear);
    SEP_vs_SNR(i, 3) = sep_qam(SNR_linear);
    SEP_vs_SNR(i, 4) = sep_cqam(SNR_linear);
end

% Plot SEP vs SNR
figure;
semilogy(SNR_dB, SEP_vs_SNR(:, 1), 'c-', 'LineWidth', 2); % Cyan solid line
hold on;
semilogy(SNR_dB, SEP_vs_SNR(:, 2), 'm--', 'LineWidth', 2); % Magenta dashed line
semilogy(SNR_dB, SEP_vs_SNR(:, 3), 'k-', 'LineWidth', 2); % Black dash-dot line
semilogy(SNR_dB, SEP_vs_SNR(:, 4), 'r:', 'LineWidth', 2); % Yellow dotted line
xlabel('E_b/N_0 (dB)');
ylabel('SEP');
legend('16-PAM', '16-PSK', '16-QAM', '16-CQAM');
title('SEP vs SNR for 16-PAM, 16-PSK, 16-QAM, and 16-CQAM');
grid on;