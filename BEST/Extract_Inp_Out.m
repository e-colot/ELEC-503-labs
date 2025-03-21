%% Plot Input vs Output
Nrep = 5;
for i = 5:5
    % freq analysis
    freq_res = 1;   % Frequency resolution in Hz
    fs = 1250;      % Sampling frequency in Hz
    rep = 1;       % Number of periods
    T = 1/freq_res; % period
    t = 0:1/fs:T; % Time axis
    N = length(t); % Number of samples
    [Hann] = hanning(N,'periodic');
    u(:, i) = u(:, i).*Hann;
    y(:, i) = y(:, i).*Hann;
    freq = db(fft(y(:, i))/fft(u(:, i)));
    figure;
    subplot(2, 1, 1);
    plot(u(:, i));
    hold on;
    plot(y(:, i));
    hold off;
    legend("u", "y");
    subplot(2, 1, 2);
    plot(freq);
end
