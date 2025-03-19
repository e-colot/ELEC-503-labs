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

figure;

for i = 1:32

    perMeanU = mean(uPeriodic(:, 1:i), 2);
    perMeanY = mean(yPeriodic(:, 1:i), 2);
    aperMeanU = mean(uAperiodic(:, 1:i), 2);
    aperMeanY = mean(yAperiodic(:, 1:i), 2);

    perFRF = fft(perMeanY)./fft(perMeanU);
    aperFRF = fft(aperMeanY)./fft(aperMeanU);

    subplot(2, 1, 1);
    plot(freqAxis, db(perFRF));
    title('Periodic FRF - magnitude for increasing number of averaged records');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude'); xlim([0 1000]);
    hold on;

    subplot(2, 1, 2);
    if (i == 32)
        plot(freqAxis, db(aperFRF), 'r--', 'LineWidth', 2);
    else
        plot(freqAxis, db(aperFRF));
    end
    title('Aperiodic FRF - magnitude for increasing number of averaged records');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude'); xlim([0 1000]);
    hold on;

end

