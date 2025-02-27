clear; close all; clc;

N = 500;
K = 60;

X1_k = zeros(N, 1);
X2_k = zeros(N, 1);
X3_k = zeros(N, 1);
for m = 1:K
    phi1 = unifrnd(-pi, pi);
    phi2 = (m*(m+1)*pi)/K;
    phi3 = m*pi;
    X1_k(m) = exp(1j*phi1).';
    X2_k(m) = exp(1j*phi2).';
    X3_k(m) = exp(1j*phi3).';
end

x1_n = N*real(ifft(X1_k));
x2_n = N*real(ifft(X2_k));
x3_n = N*real(ifft(X3_k));

crest_factor1 = max(abs(x1_n))/rms(x1_n);
crest_factor2 = max(abs(x2_n))/rms(x2_n);
crest_factor3 = max(abs(x3_n))/rms(x3_n);

figure;
subplot(3,3,1);
plot(x1_n);
title(['Signal in time domain - x1[n] (random phase) - Crest Factor: ', num2str(crest_factor1)]);
xlabel('Samples');
ylabel('Amplitude');
subplot(3,3,2);
plot(abs(X1_k));
title('DFT - magnitude - x1[n] (random phase)');
xlabel('Frequency (bins)');
ylabel('Magnitude');
subplot(3,3,3);
plot(angle(X1_k));
title('DFT - phase - x1[n] (random phase)');
xlabel('Frequency (bins)');
ylabel('Phase');
subplot(3,3,4);
plot(x2_n);
title(['Signal in time domain - x2[n] (Schroeder phase) - Crest Factor: ', num2str(crest_factor2)]);
xlabel('Samples');
ylabel('Amplitude');
subplot(3,3,5);
plot(abs(X2_k));
title('DFT - magnitude - x2[n] (Schroeder phase)');
xlabel('Frequency (bins)');
ylabel('Magnitude');
subplot(3,3,6);
plot(angle(X2_k));
title('DFT - phase - x2[n] (Schroeder phase)');
xlabel('Frequency (bins)');
ylabel('Phase');
subplot(3,3,7);
plot(x3_n);
title(['Signal in time domain - x3[n] (linear phase) - Crest Factor: ', num2str(crest_factor3)]);
xlabel('Samples');
ylabel('Amplitude');
subplot(3,3,8);
plot(abs(X3_k));
title('DFT - magnitude - x3[n] (linear phase)');
xlabel('Frequency (bins)');
ylabel('Magnitude');
subplot(3,3,9);
plot(angle(X3_k));
title('DFT - phase - x3[n] (linear phase)');
xlabel('Frequency (bins)');
ylabel('Phase');



