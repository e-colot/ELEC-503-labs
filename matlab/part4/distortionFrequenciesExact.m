clear; close all; clc;

function y = f(u)
    y = u - 0.5*u.^3 - 0.25*u.^4;
end

N = 10000;
freqRange = 50;
T = N/(2*freqRange);

t = linspace(0, T, N);
freqAxis = -freqRange:1/T:freqRange-1/T;

u = sin(2*pi*4*t) + sin(2*pi*11*t);

y = f(u);

Y = fft(y);

figure;
plot(freqAxis, fftshift(Y));
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Distorted Signal Spectrum');

