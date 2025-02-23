clear; close all; clc;

%% Task 1.2.1

N = 1000; % Number of samples
phi = unifrnd(-pi, pi); % random phase

n = 0:N-1;

% cos has a period of 2*pi so to have 3 periods in 1000 samples, we need a period of:
T_3 = N/3;
f_3 = 1/T_3;
cos_3 = cos(2*pi*f_3*n + phi);
dft_3 = fft(cos_3);

figure;
subplot(3,1,1);
plot(n, cos_3);
title('Cosine wave with f = 3 bins and phase = ' + string(phi) + ' rad');
xlabel('Samples');
ylabel('Amplitude');
subplot(3,1,2);
plot(abs(dft_3));
title('DFT - magnitude');
xlabel('Frequency');
ylabel('Magnitude');
subplot(3,1,3);
plot(angle(dft_3));
title('DFT - phase');
xlabel('Frequency');
ylabel('Phase');

%% Task 1.2.2

figure;
dft_3_dB = 20*log10(abs(dft_3));
plot(dft_3_dB);
title('DFT - magnitude in dB');
xlabel('Frequency');
ylabel('Magnitude (dB)');

%% Task 1.2.5

fs = 100; % Sampling frequency

omega_1 = fs/N;

freqAxis = n*omega_1;


figure;
subplot(2,1,1);
plot(freqAxis, abs(dft_3));
title('DFT - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2,1,2);
plot(freqAxis, angle(dft_3));
title('DFT - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');