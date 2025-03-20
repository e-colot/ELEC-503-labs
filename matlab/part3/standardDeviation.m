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

splits = [2 4 8 16];

% done only for aperiodic as periodic measurements are not noised enough

figure;

for i = splits
    FRFs = zeros(4000, i);
    for j = 1:i 
        aperMeanu = mean(uAperiodic(:, (j-1)*32/i+1:j*32/i), 2);
        aperMeany = mean(yAperiodic(:, (j-1)*32/i+1:j*32/i), 2);

        FRFs(:, j) = fft(aperMeany)./fft(aperMeanu);
    end

    stdFRF = std(FRFs, 0, 2);


    plot(freqAxis, db(stdFRF));
    title(['Aperiodic FRF - standard deviation']);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)'); xlim([0 1000]);
    hold on;

end

legend('16 averages', '8 averages', '4 averages', '2 averages');

