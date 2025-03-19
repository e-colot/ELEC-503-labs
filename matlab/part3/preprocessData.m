clear; close all; clc;

periodicFile = 'ResPeriodic.mat';
aperiodicFile = 'ResAperiodic.mat';

[uPeriodic, yPeriodic] = ReadData(periodicFile, 4000, 40);
[uAperiodic, yAperiodic] = ReadData(aperiodicFile, 40*4000, 1);

uAperiodic = reshape(uAperiodic, 4000, 40);
yAperiodic = reshape(yAperiodic, 4000, 40);

uAperiodic = uAperiodic(:, 9:end);
yAperiodic = yAperiodic(:, 9:end);

uPeriodic = uPeriodic(:, 9:end);
yPeriodic = yPeriodic(:, 9:end);


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

figure('Name', 'FRF - time average');
subplot(2, 2, 1);
plot(freqAxis, db(periodicFRF1));
title('Periodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude'); xlim([0 1000]); 
subplot(2, 2, 2);
plot(freqAxis, angle(periodicFRF1));
title('Periodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase'); xlim([0 1000]);
subplot(2, 2, 3);
plot(freqAxis, db(aperiodicFRF1));
title('Aperiodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude'); xlim([0 1000]);
subplot(2, 2, 4);
plot(freqAxis, angle(aperiodicFRF1));
title('Aperiodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase'); xlim([0 1000]);


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

figure('Name', 'FRF - DFT average');
subplot(2, 2, 1);
plot(freqAxis, db(periodicFRF2));
title('Periodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude'); xlim([0 1000]);
subplot(2, 2, 2);
plot(freqAxis, angle(periodicFRF2));
title('Periodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase'); xlim([0 1000]);
subplot(2, 2, 3);
plot(freqAxis, db(aperiodicFRF2));
title('Aperiodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude'); xlim([0 1000]);
subplot(2, 2, 4);
plot(freqAxis, angle(aperiodicFRF2));
title('Aperiodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase'); xlim([0 1000]);

%% Averaging the FRF

periodicFRFDFT = yPeriodicDFT./uPeriodicDFT;
periodicFRF3 = mean(periodicFRFDFT, 2);
aperiodicFRFDFT = yAperiodicDFT./uAperiodicDFT;
aperiodicFRF3 = mean(aperiodicFRFDFT, 2);

figure('Name', 'FRF average');
subplot(2, 2, 1);
plot(freqAxis, db(periodicFRF3));
title('Periodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude'); xlim([0 1000]);
subplot(2, 2, 2);
plot(freqAxis, angle(periodicFRF3));
title('Periodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase'); xlim([0 1000]);
subplot(2, 2, 3);
plot(freqAxis, db(aperiodicFRF3));
title('Aperiodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude'); xlim([0 1000]);
subplot(2, 2, 4);
plot(freqAxis, angle(aperiodicFRF3));
title('Aperiodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase'); xlim([0 1000]);

%% Averaging the auto-power of the input signal and the cross-power

periodicCrossPower = mean(yPeriodicDFT.*conj(uPeriodicDFT), 2);
aperiodicCrossPower = mean(yAperiodicDFT.*conj(uAperiodicDFT), 2);
periodicInputPower = mean(abs(uPeriodicDFT).^2, 2);
aperiodicInputPower = mean(abs(uAperiodicDFT).^2, 2);

periodicFRF4 = periodicCrossPower./periodicInputPower;
aperiodicFRF4 = aperiodicCrossPower./aperiodicInputPower;

figure('Name', 'FRF - input auto-power average');
subplot(2, 2, 1);
plot(freqAxis, db(periodicFRF4));
title('Periodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude'); xlim([0 1000]);
subplot(2, 2, 2);
plot(freqAxis, angle(periodicFRF4));
title('Periodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase'); xlim([0 1000]);
subplot(2, 2, 3);
plot(freqAxis, db(aperiodicFRF4));
title('Aperiodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude'); xlim([0 1000]);
subplot(2, 2, 4);
plot(freqAxis, angle(aperiodicFRF4));
title('Aperiodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase'); xlim([0 1000]);

%% Averaging the auto-power of the output signal and the cross-power

periodicCrossPowerBis = mean(uPeriodicDFT.*conj(yPeriodicDFT), 2);
aperiodicCrossPowerBis = mean(uAperiodicDFT.*conj(yAperiodicDFT), 2);
periodicOutputPower = mean(abs(yPeriodicDFT).^2, 2);
aperiodicOutputPower = mean(abs(yAperiodicDFT).^2, 2);

periodicFRF5 = periodicOutputPower./periodicCrossPowerBis;
aperiodicFRF5 = aperiodicOutputPower./aperiodicCrossPowerBis;

figure('Name', 'FRF - output auto-power average');
subplot(2, 2, 1);
plot(freqAxis, db(periodicFRF5));
title('Periodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude'); xlim([0 1000]);
subplot(2, 2, 2);
plot(freqAxis, angle(periodicFRF5));
title('Periodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase'); xlim([0 1000]);
subplot(2, 2, 3);
plot(freqAxis, db(aperiodicFRF5));
title('Aperiodic FRF - magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude'); xlim([0 1000]);
subplot(2, 2, 4);
plot(freqAxis, angle(aperiodicFRF5));
title('Aperiodic FRF - phase');
xlabel('Frequency (Hz)');
ylabel('Phase'); xlim([0 1000]);


disp('Done!');
