clear; close all; clc;

%% Task 1.3.1

N = 1000; % Number of samples
K = 10; % Excited frequencies

n = 0:N-1;

Am = 1; % Amplitude

multisine = 0;

for k = 1:K
    f_k = randi([0, N])/N; % Random frequency
    phi_k = unifrnd(-pi, pi);
    multisine = multisine + Am*cos(2*pi*f_k*n + phi_k);
end

dft_multisine = fft(multisine);

figure;
subplot(3,1,1);
plot(n, multisine);
title('Multisine wave with K = ' + string(K) + ' excited frequencies');
xlabel('Samples');
ylabel('Amplitude');
subplot(3,1,2);
plot(20*log10(abs(dft_multisine)));
title('DFT - magnitude in dB');
xlabel('Frequency (bins)');
ylabel('Magnitude');
subplot(3,1,3);
plot(angle(dft_multisine));
title('DFT - phase');
xlabel('Frequency (bins)');
ylabel('Phase');


%% Task 1.3.2

fs = 100; % Sampling frequency
omega_1 = fs/N;

freqAxis = n*omega_1;

figure;
subplot(2,1,1);
plot(freqAxis, 20*log10(abs(dft_multisine)));
title('DFT - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2,1,2);
plot(freqAxis, angle(dft_multisine));
title('DFT - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');

%% Task 1.3.3

frequencies = 4*(1:6); % Excited frequencies
fs = 200; % Sampling frequency
t = 1/fs:1/fs:N/fs;

multisine = 0;

for k = 1:length(frequencies)
    phi_k = unifrnd(-pi, pi);
    multisine = multisine + Am*cos(2*pi*frequencies(k)*t + phi_k);
end

dft_multisine = fft(multisine);

omega_1 = fs/N;
freqAxis = n*omega_1;

figure;
subplot(3,1,1);
plot(t, multisine);
title('Multisine wave with excited frequencies: [' + join(string(frequencies), ', ') + '] Hz');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,1,2);
plot(freqAxis, 20*log10(abs(dft_multisine)));
title('DFT - magnitude in dB');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(3,1,3);
plot(freqAxis, angle(dft_multisine));
title('DFT - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');

