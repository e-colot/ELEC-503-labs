clear; close all; clc;

periodicFile = 'ResPeriodic.mat';
aperiodicFile = 'ResAperiodic.mat';

[uPeriodic, yPeriodic] = ReadData(periodicFile, 4000, 40);
[uAperiodic, yAperiodic] = ReadData(aperiodicFile, 40*4000, 1);

if (size(uPeriodic, 1) == 1)
    uPeriodic = uPeriodic(1, 8*4000+1:end);
    yPeriodic = yPeriodic(1, 8*4000+1:end);
    uAperiodic = uAperiodic(1, 8*4000+1:end);
    yAperiodic = yAperiodic(1, 8*4000+1:end);
else
    uPeriodic = uPeriodic(8*4000+1:end);
    yPeriodic = yPeriodic(8*4000+1:end);
    uAperiodic = uAperiodic(8*4000+1:end);
    yAperiodic = yAperiodic(8*4000+1:end);
end

uPeriodic = reshape(uPeriodic, 4000, 32);
yPeriodic = reshape(yPeriodic, 4000, 32);
uAperiodic = reshape(uAperiodic, 4000, 32);
yAperiodic = reshape(yAperiodic, 4000, 32);

fs = 16000; % Sampling frequency
N = 4000; % Number of samples
freqAxis = (0:N-1)*fs/N; % Frequency axis in Hz

%% Averaging the time records
uPeriodicMean = mean(uPeriodic, 2);
yPeriodicMean = mean(yPeriodic, 2);
uAperiodicMean = mean(uAperiodic, 2);
yAperiodicMean = mean(yAperiodic, 2);

periodicFRF1 = fft(yPeriodicMean)./fft(uPeriodicMean);
aperiodicFRF1 = fft(yAperiodicMean)./fft(uAperiodicMean);

figure;
title('FRF - time average');
subplot(2, 2, 1);
plot(freqAxis, abs(periodicFRF1));
title('Periodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2, 2, 2);
plot(freqAxis, angle(periodicFRF1));
title('Periodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');
subplot(2, 2, 3);
plot(freqAxis, abs(aperiodicFRF1));
title('Aperiodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2, 2, 4);
plot(freqAxis, angle(aperiodicFRF1));
title('Aperiodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');

%% Averaging the DFT spectra

uPeriodicDFT = fft(uPeriodic);
yPeriodicDFT = fft(yPeriodic);
uAperiodicDFT = fft(uAperiodic);
yAperiodicDFT = fft(yAperiodic);

uPeriodicMeanDFT = mean(uPeriodicDFT, 2);
yPeriodicMeanDFT = mean(yPeriodicDFT, 2);
uAperiodicMeanDFT = mean(uAperiodicDFT, 2);
yAperiodicMeanDFT = mean(yAperiodicDFT, 2);

periodicFRF2 = yPeriodicMeanDFT./uPeriodicMeanDFT;
aperiodicFRF2 = yAperiodicMeanDFT./uAperiodicMeanDFT;

figure;
title('FRF - DFT average');
subplot(2, 2, 1);
plot(freqAxis, abs(periodicFRF2));
title('Periodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2, 2, 2);
plot(freqAxis, angle(periodicFRF2));
title('Periodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');
subplot(2, 2, 3);
plot(freqAxis, abs(aperiodicFRF2));
title('Aperiodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2, 2, 4);
plot(freqAxis, angle(aperiodicFRF2));
title('Aperiodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');

%% Averaging the FRF

periodicFRFDFT = yPeriodicDFT./uPeriodicDFT;
periodicFRF3 = mean(periodicFRFDFT, 2);
aperiodicFRFDFT = yAperiodicDFT./uAperiodicDFT;
aperiodicFRF3 = mean(aperiodicFRFDFT, 2);

figure;
title('FRF - DFT average');
subplot(2, 2, 1);
plot(freqAxis, abs(periodicFRF3));
title('Periodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2, 2, 2);
plot(freqAxis, angle(periodicFRF3));
title('Periodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');
subplot(2, 2, 3);
plot(freqAxis, abs(aperiodicFRF3));
title('Aperiodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2, 2, 4);
plot(freqAxis, angle(aperiodicFRF3));
title('Aperiodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');

%% Averaging the auto-power of the input signal and the cross-power

periodicCrossPower = mean(yPeriodicDFT.*conj(uPeriodicDFT), 2);
aperiodicCrossPower = mean(yAperiodicDFT.*conj(uAperiodicDFT), 2);
periodicInputPower = mean(abs(uPeriodicDFT).^2, 2);
aperiodicInputPower = mean(abs(uAperiodicDFT).^2, 2);

periodicFRF4 = periodicCrossPower./periodicInputPower;
aperiodicFRF4 = aperiodicCrossPower./aperiodicInputPower;

figure;
title('FRF - input auto-power average');
subplot(2, 2, 1);
plot(freqAxis, abs(periodicFRF4));
title('Periodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2, 2, 2);
plot(freqAxis, angle(periodicFRF4));
title('Periodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');
subplot(2, 2, 3);
plot(freqAxis, abs(aperiodicFRF4));
title('Aperiodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2, 2, 4);
plot(freqAxis, angle(aperiodicFRF4));
title('Aperiodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');

%% Averaging the auto-power of the output signal and the cross-power

periodicCrossPowerBis = mean(uPeriodicDFT.*conj(yPeriodicDFT), 2);
aperiodicCrossPowerBis = mean(uAperiodicDFT.*conj(yAperiodicDFT), 2);
periodicOutputPower = mean(abs(yPeriodicDFT).^2, 2);
aperiodicOutputPower = mean(abs(yAperiodicDFT).^2, 2);

periodicFRF5 = periodicOutputPower./periodicCrossPowerBis;
aperiodicFRF5 = aperiodicOutputPower./aperiodicCrossPowerBis;

figure;
title('FRF - output auto-power average');
subplot(2, 2, 1);
plot(freqAxis, abs(periodicFRF5));
title('Periodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2, 2, 2);
plot(freqAxis, angle(periodicFRF5));
title('Periodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');
subplot(2, 2, 3);
plot(freqAxis, abs(aperiodicFRF5));
title('Aperiodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2, 2, 4);
plot(freqAxis, angle(aperiodicFRF5));
title('Aperiodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase');


disp('Done!');
