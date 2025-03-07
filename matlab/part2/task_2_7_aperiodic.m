clear; close all; clc;


freq_res = 1;   % Frequency resolution in Hz
fs = 8000;      % Sampling frequency in Hz
rep = 10;       % Number of periods

T = 1/freq_res; % period
t = 0:1/fs:T; % Time axis
N = length(t); % Number of samples

K = 500; % Excited frequencies

RMS_sig = 0.1; % RMS value of the signal

x_rand = randn(1, N*rep); % Generate the signal

[Hann] = hanning(N*rep,'periodic')

x_rand_windowed = x_rand.*Hann; % Apply the window

