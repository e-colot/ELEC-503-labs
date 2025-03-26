clear; close all; clc;

fs = 10e3;
N = 4096;
f = 100; % sine frequency in Hz

k = f*N/fs;

%% Sampling frequency correction

fs_corr = f*N/round(k);

t = (0:N-1)/fs_corr;
u = sin(2*pi*f*t);

u_fft = db(fft(u));

figure;
subplot(3, 1, 1);
plot(u_fft);
title(['sampling frequency correction, fs\_corr = ', num2str(fs_corr), 'Hz']);
xlabel('frequency (bins)');
ylabel('amplitude');

%% Number of samples correction

N_corr = fs*round(k)/f;

t = (0:N_corr-1)/fs;
u = sin(2*pi*f*t);

u_fft = db(fft(u));

subplot(3, 1, 2);
plot(u_fft);
title(['number of samples correction, N\_corr = ', num2str(N_corr)]);
xlabel('frequency (bins)');
ylabel('amplitude');

%% Signal frequency correction

f_corr = fs*round(k)/N;

t = (0:N-1)/fs;
u = sin(2*pi*f_corr*t);

u_fft = db(fft(u));

subplot(3, 1, 3);
plot(u_fft);
title(['signal frequency correction, f\_corr = ', num2str(f_corr), 'Hz']);
xlabel('frequency (bins)');
ylabel('amplitude');

