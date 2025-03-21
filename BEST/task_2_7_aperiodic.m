clear; close all; clc;


freq_res = 1;   % Frequency resolution in Hz
fs = 1250;      % Sampling frequency in Hz
rep = 1;       % Number of periods

T = 1/freq_res; % period
t = 0:1/fs:T; % Time axis
N = length(t); % Number of samples

K = 500; % Excited frequencies

RMS_sig = 0.1; % RMS value of the signal

x_rand = randn(1, N*rep); % Generate the signal

x_rand = x_rand * RMS_sig/rms(x_rand); % Normalized

[Hann] = hanning(N*rep,'periodic');

x_rand_windowed = x_rand.*Hann; % Apply the window

x_rand_windowed = x_rand_windowed * RMS_sig/rms(x_rand_windowed); % Normalized

x_rand_windowed = x_rand_windowed.';

save("x_rand_2_10_aperiodic.mat", "x_rand");
save("x_rand_windowed_2_10_aperiodic.mat", "x_rand_windowed");