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

figure;
subplot(1, 2, 1);
bode(sys);
subplot(1, 2, 2);
[imp impTime] = impulse(sys);

n_h = 35;
imp = imp(1:n_h);
impTime = impTime(1:n_h);

plot(impTime, imp);
title('Impulse response of the system');
xlabel('time (s)');
ylabel('amplitude');


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

n_p = 1:250; % number of parameters of the estimated model
V_LS = zeros(length(n_p), 1); % variance of the estimation error
V_AIC = zeros(length(n_p), 1); % variance of the estimation error
V_VAL = zeros(length(n_p), 1); % variance of the estimation error

for n = n_p
    % Create the Toeplitz matrix
    u_0ePadded = [zeros(n-1, 1); u_0e].';
    H = toeplitz(fliplr(u_0ePadded));
    H = H(1:N_e, end-n+1:end);
    
    % Estimate the parameters
    theta_est = H\y_e;

    if n == 30
        figure;
        subplot(211);
        y = H * theta_est;
        plot(y, 'linewidth', 1.1, 'color', [0 0.5 0]);
        hold on;
        plot(y_e, 'linewidth', 1.1, 'LineStyle', '--');
        legend('Estimated output', 'Real output');
        title('Estimated output for n = 30');
        subplot(212);
        H2 = eye(N_e);
        H2 = H2(:, 1:n);
        y2 = H2 * theta_est;
        plot(y2(1:n_h), 'linewidth', 1.1, 'color', [0 0.5 0]);
        hold on;
        plot(imp, 'linewidth', 1.1, 'LineStyle', '--');
        legend('Estimated impulse response', 'Real impulse response');
        title('Estimated impulse response for n = 30');
    end
    
    % Compute the variance of the estimation error
    V_LS(n) = 1/(N_e * y_0ePower * 10^(-SNR/10)) * norm(y_e - H*theta_est).^2;

    %% AIC
    V_AIC(n) = V_LS(n) * (1 + 2*n/N_e);
    %% Validation
    u_0vPadded = [zeros(n-1, 1); u_0v].';
    H_val = toeplitz(fliplr(u_0vPadded));
    H_val = H_val(1:N_e, end-n+1:end);

    V_VAL(n) = 1/(N_v * y_0vPower * 10^(-SNR/10)) * norm(y_v - H_val*theta_est).^2;

end

figure;
plot(n_p, V_LS, "LineWidth", 1.5);
xlabel('n');
ylabel('Cost');
hold on;
plot(n_p, V_AIC, "LineWidth", 1.5);
plot(n_p, V_VAL, "LineWidth", 1.5);

[minAIC, idxAIC] = min(V_AIC(1:5*n_h));
plot(n_p(idxAIC), minAIC, 'rx', 'MarkerSize', 10, 'LineWidth', 2);
disp('Optimal n according to AIC: ');
disp(n_p(idxAIC));

[minVAL, idxVAL] = min(V_VAL(1:5*n_h));
plot(n_p(idxVAL), minVAL, 'mx', 'MarkerSize', 10, 'LineWidth', 2);
disp('Optimal n according to validation: ');
disp(n_p(idxVAL));

legend('LS cost', 'AIC cost', 'Validation dataset based', 'Optimal n according to AIC', 'Optimal n according to validation');
title('LS cost function for varying number of parameters n');



