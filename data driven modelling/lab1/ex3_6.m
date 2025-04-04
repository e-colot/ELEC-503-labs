clear; close all; clc;

hidePlots = 0;
if hidePlots
    disp('Plots hidden !');
    set(0, 'DefaultFigureVisible', 'off');
end


%% Exact model
bandpass = [0.3 0.6];
ripple = 3; % dB
order = 2;

[b, a] = cheby2(order, ripple, bandpass, 'bandpass');
sys = tf(b, a, 1);
[imp impTime] = impulse(sys);

n_h = 35;
imp = imp(1:n_h);
impTime = impTime(1:n_h);

n_p = 1:100; % number of parameters of the estimated model
V_LS = zeros(length(n_p), 100); % variance of the estimation error
V_AIC = zeros(length(n_p), 100); % variance of the estimation error
V_VAL = zeros(length(n_p), 100); % variance of the estimation error

for j = 1:100

    %% Excitation and output signals


    SNR = 6; % dB

    N_e = 15 * n_h; % estimation signal length
    N_v = N_e; % validation signal length

    u_0e = randn(N_e, 1);
    u_0v = randn(N_v, 1);

    y_0e = filter(b, a, u_0e);
    y_0v = filter(b, a, u_0v);

    y_0ePower = mean(y_0e.^2);
    y_0vPower = mean(y_0v.^2);

    y_e = y_0e + sqrt(y_0ePower * 10^(-SNR/10)) * randn(N_e, 1);
    y_v = y_0v + sqrt(y_0vPower * 10^(-SNR/10)) * randn(N_v, 1);

    %% Least squares for varying n

    for n = n_p
        % Create the Toeplitz matrix
        u_0ePadded = [zeros(n-1, 1); u_0e].';
        H = toeplitz(fliplr(u_0ePadded));
        H = H(1:N_e, end-n+1:end);
        
        % Estimate the parameters
        theta_est = H\y_e;
        
        % Compute the variance of the estimation error
        V_LS(n, j) = 1/(N_e * y_0ePower * 10^(-SNR/10)) * norm(y_e - H*theta_est).^2;

        %% AIC
        V_AIC(n, j) = V_LS(n, j) * (1 + 2*n/N_e);
        %% Validation
        u_0vPadded = [zeros(n-1, 1); u_0v].';
        H_val = toeplitz(fliplr(u_0vPadded));
        H_val = H_val(1:N_e, end-n+1:end);

        V_VAL(n, j) = 1/(N_v * y_0vPower * 10^(-SNR/10)) * norm(y_v - H_val*theta_est).^2;

    end
end

mean_V_LS = mean(V_LS, 2);
mean_V_AIC = mean(V_AIC, 2);
mean_V_VAL = mean(V_VAL, 2);

figure;
plot(n_p, mean_V_LS, 'LineWidth', 2);
hold on;
plot(n_p, mean_V_AIC, 'LineWidth', 2);
hold on;
plot(n_p, mean_V_VAL, 'LineWidth', 2);
hold on;
legend('V_{LS}', 'V_{AIC}', 'V_{VAL}');
title('Variance of the estimation error for varying n');
xlabel('Number of parameters n');

% Find optimal n for each criterion across 100 repetitions
n_opti_AIC = zeros(1, 100);
n_opti_VAL = zeros(1, 100);

for j = 1:100
    [~, n_opti_AIC(j)] = min(V_AIC(:, j));
    [~, n_opti_VAL(j)] = min(V_VAL(:, j));
end

% Plot histograms
figure;

% Subplot for AIC
subplot(2, 1, 1);
histogram(n_opti_AIC, 'FaceColor', 'b', 'EdgeColor', 'k');
title('Histogram of n_{opti} (AIC)');
xlabel('Optimal number of parameters n');
ylabel('Frequency');

% Subplot for Validation
subplot(2, 1, 2);
histogram(n_opti_VAL, 'FaceColor', 'r', 'EdgeColor', 'k');
title('Histogram of n_{opti} (Validation)');
xlabel('Optimal number of parameters n');
ylabel('Frequency');



