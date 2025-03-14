clear; close all; clc;

fs = 16000; % Sampling frequency
excFreq = [4 1000]; % Excited frequencies in Hz
rmsVal = 0.5; % RMS value
N = 4000; % Number of samples

freqAxis = (0:N-1)*fs/N; % Frequency axis in Hz

K = (excFreq(2) - excFreq(1))*N/fs; % Number of excited frequencies

signalFreq = zeros(1, N);

for i = 1:length(freqAxis)
    if (freqAxis(i) >= excFreq(1) && freqAxis(i) <= excFreq(2))
        schroederPhase = (i*(i+1)*pi)/(K);
        signalFreq(i) = exp(1j*schroederPhase);
    end
end


signalTime = N*real(ifft(signalFreq)); % Generate the signal
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


