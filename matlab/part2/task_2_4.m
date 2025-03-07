clear; close all; clc;

N = 4096; % number of samples
K = 100;  % number of excited frequencies

% fixed amplitude ?
A = 1;

%% constant phase
X_const = zeros(1, N);
for i = 1:K
    phi = 0;
    X_const(i) = A*exp(1j*phi);
end

%% uniform phase
X_unif = zeros(1, N);
for i = 1:K
    phi = unifrnd(-pi, pi);
    X_unif(i) = A*exp(1j*phi);
end

%% schroeder phase
X_schr = zeros(1, N);
for i = 1:K
    phi = (i*(i+1)*pi)/K;
    X_schr(i) = A*exp(1j*phi);
end

% back to time domain
x_const = N*real(ifft(X_const));
x_unif = N*real(ifft(X_unif));
x_schr = N*real(ifft(X_schr));

%% 2.5. Crest Factor

crest_factor_const = max(abs(x_const))/rms(x_const);
crest_factor_unif = max(abs(x_unif))/rms(x_unif);
crest_factor_schr = max(abs(x_schr))/rms(x_schr);
disp('Crest factor - constant phase: ' + string(crest_factor_const));
disp('Crest factor - uniform phase: ' + string(crest_factor_unif));
disp('Crest factor - Schroeder phase: ' + string(crest_factor_schr));

%% 2.6. Plot
figure;

% Constant phase
subplot(3,3,1);
plot(x_const);
title('Signal in time domain - constant phase');
xlabel('Samples');
ylabel('Amplitude');

subplot(3,3,2);
plot(abs(X_const(1:round(K*1.2))));
title('DFT - magnitude - constant phase');
xlabel('Frequency (bins)');
ylabel('Magnitude');

subplot(3,3,3);
plot(angle(X_const(1:round(K*1.2))));
title('DFT - phase - constant phase');
xlabel('Frequency (bins)');
ylabel('Phase');

% Uniform phase
subplot(3,3,4);
plot(x_unif);
title('Signal in time domain - uniform phase');
xlabel('Samples');
ylabel('Amplitude');

subplot(3,3,5);
plot(abs(X_unif(1:round(K*1.2))));
title('DFT - magnitude - uniform phase');
xlabel('Frequency (bins)');
ylabel('Magnitude');

subplot(3,3,6);
plot(angle(X_unif(1:round(K*1.2))));
title('DFT - phase - uniform phase');
xlabel('Frequency (bins)');
ylabel('Phase');

% Schroeder phase
subplot(3,3,7);
plot(x_schr);
title('Signal in time domain - Schroeder phase');
xlabel('Samples');
ylabel('Amplitude');

subplot(3,3,8);
plot(abs(X_schr(1:round(K*1.2))));
title('DFT - magnitude - Schroeder phase');
xlabel('Frequency (bins)');
ylabel('Magnitude');

subplot(3,3,9);
plot(angle(X_schr(1:round(K*1.2))));
title('DFT - phase - Schroeder phase');
xlabel('Frequency (bins)');
ylabel('Phase');

