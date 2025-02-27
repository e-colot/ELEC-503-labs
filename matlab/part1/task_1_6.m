clear; close all; clc;

%% Task 1.6.1

N = 1000;

noise = randn(N, 1);
noise_fft = fft(noise);

figure;
subplot(3,1,1);
plot(noise);
title('Signal in time domain - Noise');
xlabel('Samples');
ylabel('Amplitude');
subplot(3,1,2);
plot(abs(noise_fft));
title('DFT - magnitude - Noise');
xlabel('Frequency (bins)');
ylabel('Magnitude');
subplot(3,1,3);
plot(angle(noise_fft));
title('DFT - phase - Noise');
xlabel('Frequency (bins)');
ylabel('Phase');

%% Task 1.6.2

% parameters
fs = 100;
cheb_order = 5;
ripple = 2; % dB
passband_freq = 5;

% filter
[b, a] = cheby1(cheb_order, ripple, passband_freq/(fs/2)); % using normalized frequency

% noise
noiseFiltered = filter(b, a, noise);
noiseFiltered_fft = fft(noiseFiltered);

time = (0:N-1)/fs;
freqAxis = (0:N-1)*fs/N;

figure;
subplot(3,1,1);
plot(time, noiseFiltered);
title('Signal in time domain - Noise filtered');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,1,2);
plot(freqAxis, 20*log10(abs(noiseFiltered_fft)));
hold on;
plot([passband_freq passband_freq], [0 max(20*log10(abs(noiseFiltered_fft)))], 'r--', 'LineWidth', 2);
hold off;
title('DFT - magnitude (dB) - Noise filtered');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
subplot(3,1,3);
plot(freqAxis, angle(noiseFiltered_fft));
title('DFT - phase - Noise filtered');
xlabel('Frequency (Hz)');
ylabel('Phase');

%% Task 1.6.3


X_filtered_digitally_fft = noise_fft .* (freqAxis <= passband_freq)';
x_filtered_digitally = 2 * real(ifft(X_filtered_digitally_fft));



figure;
subplot(3,2,1);
plot(time, x_filtered_digitally);
title('Signal in time domain - Noise filtered digitally');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,2,3);
plot(freqAxis, abs(X_filtered_digitally_fft));
title('DFT - magnitude - Noise filtered digitally');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(3,2,5);
plot(freqAxis, angle(X_filtered_digitally_fft));
title('DFT - phase - Noise filtered digitally');
xlabel('Frequency (Hz)');
ylabel('Phase');

%repetition of the time domain signal
repNbr = 5;
x_filtered_digitally_rep = repmat(x_filtered_digitally, repNbr, 1);

rep_fft = fft(x_filtered_digitally_rep);

subplot(3,2,2);
plot(x_filtered_digitally_rep);
title('Signal in time domain - Noise filtered digitally - Repetition');
xlabel('Samples');
ylabel('Amplitude');
subplot(3,2,4);
plot(abs(rep_fft));
title('DFT - magnitude - Noise filtered digitally - Repetition');
xlabel('Frequency (bins)');
ylabel('Magnitude');
subplot(3,2,6);
plot(angle(rep_fft));
title('DFT - phase - Noise filtered digitally - Repetition');
xlabel('Frequency (bins)');
ylabel('Phase');


