clear; close all; clc;

repNumber = 10;
fs = 10e3;
N = 4096;
f = 100.1; %Frequency signal

freqaxis = [0:N-1]*fs/N;

A_alt = logspace(-1, log10(1.1), 10); % alternative sine amplitudes

% Load the data
[u1 y1] = ReadData('rep_2_1.mat', N, repNumber);
[u2 y2] = ReadData('rep_2_2.mat', N, repNumber);
[u3 y3] = ReadData('rep_2_3.mat', N, repNumber);
[u4 y4] = ReadData('rep_2_4.mat', N, repNumber);
[u5 y5] = ReadData('rep_2_5.mat', N, repNumber);
[u6 y6] = ReadData('rep_2_6.mat', N, repNumber);
[u7 y7] = ReadData('rep_2_7.mat', N, repNumber);
[u8 y8] = ReadData('rep_2_8.mat', N, repNumber);
[u9 y9] = ReadData('rep_2_9.mat', N, repNumber);
[uA yA] = ReadData('rep_2_A.mat', N, repNumber);

u1 = u1(:, end);
y1 = y1(:, end);
u2 = u2(:, end);
y2 = y2(:, end);
u3 = u3(:, end);
y3 = y3(:, end);
u4 = u4(:, end);
y4 = y4(:, end);
u5 = u5(:, end);
y5 = y5(:, end);
u6 = u6(:, end);
y6 = y6(:, end);
u7 = u7(:, end);
y7 = y7(:, end);
u8 = u8(:, end);
y8 = y8(:, end);
u9 = u9(:, end);
y9 = y9(:, end);
uA = uA(:, end);
yA = yA(:, end);

% plot the DFT of the last period of the output


figure('units','normalized','outerposition',[0 0 1 1]); % Full screen
outputs = {y1, y2, y3, y4, y5, y6, y7, y8, y9, yA};
for i = 1:length(outputs)
    subplot(3, 4, i);
    tmp = fft(outputs{i}(:, end));
    plot(freqaxis(1:500),db(tmp(1:500)));
    title(['Signal amplitude : ', num2str(A_alt(1,i))]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
end

figure('units','normalized','outerposition',[0 0 1 1]); % Full screen
outputs = {y1, y2, y3, y4, y5, y6, y7, y8, y9, yA};
tmp = fft(outputs{10}(:, end));
plot(freqaxis(1:500),db(tmp(1:500)));
title(['Signal amplitude : ', num2str(A_alt(1,10))]);
xlabel('Frequency (Hz)');
ylabel('Amplitude');

%% Question 4.4. about power

% Calculate the power of the input signals
powerIn = zeros(1, 10);
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
coeffs = polyfit(db(powerIn(1:10)), db(powerOut(1:10)), 6);
fittedLine_non_linear = polyval(coeffs, db(powerIn));
plot(db(powerIn), fittedLine_non_linear);
hold on;
plot(db(powerIn), db(powerOut), 'o');
xlabel('Input power');
ylabel('Output power');
title('Output power as a function of the input power');

coeffs = polyfit(db(powerIn(1:2)), db(powerOut(1:2)), 1);
fittedLine = polyval(coeffs, db(powerIn));
plot(db(powerIn), fittedLine, 'k');
hold on
plot(db(powerIn),fittedLine+1,'r');
legend('Data', 'Data points', 'Linear behaviour','1dB line');

%% Amplitude check - 1dB

powerIn_1dB = -4.366;
A_1db = sqrt(2*10^(powerIn_1dB/20));
disp(['Signal amplitude for 1dB expansion :',num2str(A_1db)]);


