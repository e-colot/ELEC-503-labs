clear; close all; clc;

fs = 16000; % Sampling frequency in Hz
rmsVal = 0.5; % RMS value
N = 40*4000; % Number of samples

signalTime = randn(1, N); % Generate a random signal
signalTime = signalTime*rmsVal/rms(signalTime); % Normalize the signal

save('aperiodicNoiseSignal.mat', 'signalTime');

figure;
subplot(3, 1, 1);
plot((0:length(signalTime)-1)/fs, signalTime);
title('Signal in time domain');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3, 1, 2);
plot((0:length(signalTime)-1)/fs, abs(fft(signalTime)));
title('DFT - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(3, 1, 3);
plot((0:length(signalTime)-1)/fs, angle(fft(signalTime)));
title('DFT - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');

