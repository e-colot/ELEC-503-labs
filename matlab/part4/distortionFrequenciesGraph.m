clear; close all; clc;

% y(t) = u(t) - 0.5u³(t) - 0.25u⁴(t)
factors = [1 0 -0.5 -0.25];

excitedFreq = [4 11]; % Hz

% for negative frequencies
excitedFreq = [-flip(excitedFreq) excitedFreq];

freqAxis = -length(factors)*max(excitedFreq)-7:length(factors)*max(excitedFreq)+7;

linearResponse = zeros(1, length(factors) * max(excitedFreq) * 2+15);
thirdOrderResponse = zeros(1, length(factors) * max(excitedFreq) * 2+15);
fourthOrderResponse = zeros(1, length(factors) * max(excitedFreq) * 2+15);

for i = excitedFreq
    linearResponse(i+length(factors)*max(excitedFreq)+8) = abs(factors(1));
    for j = excitedFreq
        for k = excitedFreq
            thirdOrderResponse(i + j + k+length(factors)*max(excitedFreq)+8) = abs(factors(3));
            for l = excitedFreq
                fourthOrderResponse(i + j + k + l+length(factors)*max(excitedFreq)+8) = abs(factors(4));
            end
        end
    end
end

total = linearResponse + thirdOrderResponse + fourthOrderResponse;

figure;
hold on;
plot(freqAxis, linearResponse, 'r', 'LineWidth', 1.5);
plot(freqAxis, thirdOrderResponse, 'g', 'LineWidth', 1.5);
plot(freqAxis, fourthOrderResponse, 'b', 'LineWidth', 1.5);
plot(freqAxis, total, 'k', 'LineWidth', 2, 'LineStyle', '--');
title('Distortion Frequencies');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('Linear', 'Third Order', 'Fourth Order', 'Total');
hold off;
