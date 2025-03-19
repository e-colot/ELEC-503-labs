clear; close all; clc;

fs = 16000; % Sampling frequency
excFreq = [4 1000]; % Excited frequencies in Hz
rmsVal = 0.5; % RMS value
N = 4000; % Number of samples

freqAxis = (0:N-1)*fs/N; % Frequency axis in Hz

m = excFreq(1)*N/fs : excFreq(2)*N/fs; % Excited frequencies in bins
K = length(m); % Number of excited frequencies

shroedPhase = m.*(m+1) * pi / K;
signalFreq = zeros(1, N);

signalFreq(m + 1) = exp(1j*shroedPhase);
% m + 1 because the index starts from 1 in MATLAB


signalTime = 2*N*real(ifft(signalFreq)); % Generate the signal
signalTime = signalTime*rmsVal/rms(signalTime); % Normalize the signal

save('periodicMultisineSignal.mat', 'signalTime');

figure;
subplot(3, 1, 1);
plot((0:length(signalTime)-1)/fs, signalTime);
title('Signal in time domain');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3, 1, 2);
plot(freqAxis, abs(fft(signalTime)));
title('DFT - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(3, 1, 3);
plot(freqAxis, angle(fft(signalTime)));
title('DFT - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');


