clear; close all; clc;

%% Task 1.4.2

N = 1000; % Number of samples
K = 30; % Excite the 30 first bins

A = 1; % Amplitude (temporal)

X_k = zeros(N, 1);
for k = 1:K
    phi = unifrnd(-pi, pi);
    X_k(k) = A*exp(1j*phi).';
end

x_n = N*real(ifft(X_k));

figure;
subplot(3,1,1);
plot(x_n);
title('Signal in time domain');
xlabel('Samples');
ylabel('Amplitude');
subplot(3,1,2);
plot(abs(X_k));
title('DFT - magnitude');
xlabel('Frequency (bins)');
ylabel('Magnitude');
subplot(3,1,3);
plot(angle(X_k));
title('DFT - phase');
xlabel('Frequency (bins)');
ylabel('Phase');


%% Task 1.4.3

N = 150;
fs = 50;

freqBand = [5 15];

A = 1; % Amplitude (temporal)
K = 30; % Excite 30 bins

freqAxis = (0:N-1)*fs/N;
numberOfExcitedBins = 0;

X_k = zeros(N, 1);
for k = 1:length(freqAxis)
    if freqAxis(k) >= freqBand(1)
        if freqAxis(k) > freqBand(2)
            break;
        end
        phi = unifrnd(-pi, pi);
        X_k(k) = A*exp(1j*phi).';
        numberOfExcitedBins = numberOfExcitedBins + 1;
    end
end

disp('Number of excited bins: ' + string(numberOfExcitedBins));

x_n = N*real(ifft(X_k));

figure;
subplot(3,1,1);
plot(x_n);
title('Signal in time domain');
xlabel('Samples');
ylabel('Amplitude');
subplot(3,1,2);
plot(freqAxis, abs(X_k));
title('DFT - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(3,1,3);
plot(freqAxis, angle(X_k));
title('DFT - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');

%% test for verification of a period of 3 seconds

fs = 200; % Sampling frequency

N = 6 * fs; % Number of samples for 6 seconds
freqBand = [5 15];
freqStep = 1/3; % Frequency step of 1/3 Hz

A = 1; % Amplitude (temporal)

freqAxis = (0:N-1)*fs/N;
X_k = zeros(N, 1);

for freq = freqBand(1):freqStep:freqBand(2)
    k = round(freq * N / fs) + 1;
    phi = unifrnd(-pi, pi);
    X_k(k) = A * exp(1j * phi);
end

x_n = N * real(ifft(X_k));

t = (0:N-1) / fs;

figure;
subplot(3,1,1);
plot(t, x_n);
title('Signal in time domain');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,1,2);
plot(freqAxis, abs(X_k));
title('DFT - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(3,1,3);
plot(freqAxis, angle(X_k));
title('DFT - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');

