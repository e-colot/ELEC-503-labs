clear; close all; clc;

fs = 10e3;
N = 4096;

f = 100; % sine frequency in Hz
f_alt = 105; % alternative sine frequency in Hz
A = 1;   % sine amplitude
A_alt = logspace(-1, log10(1.1), 10); % alternative sine amplitudes

t = (0:N-1)/fs;
u = A * sin(2*pi*f*t);
u_alt = A_alt.' * sin(2*pi*f_alt*t);

u_alt_1 = u_alt(1, :);
u_alt_2 = u_alt(2, :);
u_alt_3 = u_alt(3, :);
u_alt_4 = u_alt(4, :);
u_alt_5 = u_alt(5, :);
u_alt_6 = u_alt(6, :);
u_alt_7 = u_alt(7, :);
u_alt_8 = u_alt(8, :);
u_alt_9 = u_alt(9, :);
u_alt_A = u_alt(10, :);

save('signal_1.mat', 'u');
save('signal_2_1.mat', 'u_alt_1');
save('signal_2_2.mat', 'u_alt_2');
save('signal_2_3.mat', 'u_alt_3');
save('signal_2_4.mat', 'u_alt_4');
save('signal_2_5.mat', 'u_alt_5');
save('signal_2_6.mat', 'u_alt_6');
save('signal_2_7.mat', 'u_alt_7');
save('signal_2_8.mat', 'u_alt_8');
save('signal_2_9.mat', 'u_alt_9');
save('signal_2_A.mat', 'u_alt_A');
