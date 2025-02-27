clear; close all; clc;

%% Task 1.7.1

% using the noise of 1.6.1
N = 1000;
noise = 5*randn(N, 1);
RMS_des = 3;

noise_rms = rms(noise);
noise_3 = noise*(RMS_des/noise_rms);

RMS_act = rms(noise_3);

figure;
plot([0 N], [RMS_act RMS_act], 'r--', 'LineWidth', 2);
title(['Signal in time domain - Noise with RMS = ', num2str(RMS_act)]);
xlabel('Samples');
ylabel('Amplitude');
hold on;
plot(noise_3, 'b', 'LineWidth', 1.5);
plot(noise, 'y', 'LineWidth', 0.5);
legend('RMS = 3', 'Noise with RMS = 3', 'Original noise');
grid on;
xlim([0 N]);
ylim([-15 15]);
hold off;

