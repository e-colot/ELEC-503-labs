clear; close all; clc;

freq_res = 1;   % Frequency resolution in Hz
fs = 8000;      % Sampling frequency in Hz
rep = 1;       % Number of periods

T = 1/freq_res; % period
t = 0:1/fs:T; % Time axis
N = length(t); % Number of samples

K = 500; % Excited frequencies

RMS_sig = 0.1; % RMS value of the signal

X_schr = zeros(N, 1); % Initialize the spectrum
X_const = zeros(N, 1); % Initialize the spectrum
X_unif = zeros(N, 1); % Initialize the spectrum
X_rand = zeros(N, 1); % Initialize the spectrum
for k = 1:K*T
    phi_schr = (k*(k+1)*pi)/K; % Schroeder phase
    phi_const = 0; % Constant phase
    phi_unif = unifrnd(-pi, pi); % Uniform phase
    phi_rand = unifrnd(-pi, pi); % Random phase
    A_rand = randn(1); % Random amplitude
    X_schr(k) = exp(1j*phi_schr);
    X_const(k) = exp(1j*phi_const);
    X_unif(k) = exp(1j*phi_unif);
    X_rand(k) = A_rand*exp(1j*phi_rand);
end

x_schr = N*real(ifft(X_schr)); % Generate the signal
x_const = N*real(ifft(X_const)); % Generate the signal
x_unif = N*real(ifft(X_unif)); % Generate the signal
x_rand = N*real(ifft(X_rand)); % Generate the signal

x_schr = x_schr*RMS_sig/rms(x_schr); % Normalize the signal
x_const = x_const*RMS_sig/rms(x_const); % Normalize the signal
x_unif = x_unif*RMS_sig/rms(x_unif); % Normalize the signal
x_rand = x_rand*RMS_sig/rms(x_rand); % Normalize the signal

save("x_schr_2_7.mat", "x_schr");
save("x_const_2_7.mat", "x_const");
save("x_unif_2_7.mat", "x_unif");
save("x_rand_2_7.mat", "x_rand");


% Plot (time domain)
figure;
plot((0:length(x_schr)-1)/fs, x_schr);
title('Signal in time domain - Schroeder phase');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot (frequency domain)
figure;
f = 0:freq_res:(N-1)*freq_res;
subplot(2, 1, 1);
plot(f, abs(X_schr(1:length(f))));
title('DFT - magnitude - Schroeder phase');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2, 1, 2);
plot(f, angle(X_schr(1:length(f))));
title('DFT - phase - Schroeder phase');
xlabel('Frequency (Hz)');
ylabel('Phase (rad)');
