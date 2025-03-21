clear; close all; clc;

repNumber = 10;
N = 4096;

% Load the data
[u1 y1] = ReadData('signal_2_1.mat', N, repNumber);
[u2 y2] = ReadData('signal_2_2.mat', N, repNumber);
[u3 y3] = ReadData('signal_2_3.mat', N, repNumber);
[u4 y4] = ReadData('signal_2_4.mat', N, repNumber);
[u5 y5] = ReadData('signal_2_5.mat', N, repNumber);
[u6 y6] = ReadData('signal_2_6.mat', N, repNumber);
[u7 y7] = ReadData('signal_2_7.mat', N, repNumber);
[u8 y8] = ReadData('signal_2_8.mat', N, repNumber);
[u9 y9] = ReadData('signal_2_9.mat', N, repNumber);
[uA yA] = ReadData('signal_2_A.mat', N, repNumber);

% plot the DFT of the last period of the output
figure('units','normalized','outerposition',[0 0 1 1]); % Full screen
subplot(3, 4, 1);
plot(abs(fft(y1(:, end))));
title('output 1');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
subplot(3, 4, 2);
plot(abs(fft(y2(:, end))));
title('output 2');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
subplot(3, 4, 3);
plot(abs(fft(y3(:, end))));
title('output 3');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
subplot(3, 4, 4);
plot(abs(fft(y4(:, end))));
title('output 4');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
subplot(3, 4, 5);
plot(abs(fft(y5(:, end))));
title('output 5');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
subplot(3, 4, 6);
plot(abs(fft(y6(:, end))));
title('output 6');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
subplot(3, 4, 7);
plot(abs(fft(y7(:, end))));
title('output 7');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
subplot(3, 4, 8);
plot(abs(fft(y8(:, end))));
title('output 8');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
subplot(3, 4, 9);
plot(abs(fft(y9(:, end))));
title('output 9');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
subplot(3, 4, 10);
plot(abs(fft(yA(:, end))));
title('output A');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

%% Question 4.4. about power

% Calculate the power of the input signals
powerIn = zeros(10, 1);
powerIn(1) = mean(abs(u1).^2);
powerIn(2) = mean(abs(u2).^2);
powerIn(3) = mean(abs(u3).^2);
powerIn(4) = mean(abs(u4).^2);
powerIn(5) = mean(abs(u5).^2);
powerIn(6) = mean(abs(u6).^2);
powerIn(7) = mean(abs(u7).^2);
powerIn(8) = mean(abs(u8).^2);
powerIn(9) = mean(abs(u9).^2);
powerIn(10) = mean(abs(uA).^2);

% Calculate the power of the output signals
powerOut = zeros(10, 1);
powerOut(1) = mean(abs(y1).^2);
powerOut(2) = mean(abs(y2).^2);
powerOut(3) = mean(abs(y3).^2);
powerOut(4) = mean(abs(y4).^2);
powerOut(5) = mean(abs(y5).^2);
powerOut(6) = mean(abs(y6).^2);
powerOut(7) = mean(abs(y7).^2);
powerOut(8) = mean(abs(y8).^2);
powerOut(9) = mean(abs(y9).^2);
powerOut(10) = mean(abs(yA).^2);

% plot the output power as a function of the input power

figure;
plot(powerIn, powerOut, 'o');
xlabel('Input power');
ylabel('Output power');
title('Output power as a function of the input power');


