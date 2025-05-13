clear; close all; clc;

function [x, xTesting, yTraining, yTesting] = loadData(percentage)
    % ------------- load data -------------
    load('fisheriris.mat');
    % standard scaling the data to have mean 0 and std 1
    % this avoids having to deal with different scales of the data
    meas = meas - mean(meas);
    meas = meas ./ std(meas);

    % permutating the data to have a random order
    perm = randperm(size(meas, 1));
    meas = meas(perm, :);
    species = species(perm);

    % keeping only part of the data for training
    trainingMax = floor(percentage*size(meas, 1));
    x = meas(1:trainingMax, :);
    xTesting = meas(trainingMax+1:end, :);

    % one hot encoding the labels
    y = zeros(size(meas, 1), 3);
    for i = 1:size(meas, 1)
        if strcmp(species(i), 'setosa')
            y(i, 1) = 1;
        elseif strcmp(species(i), 'versicolor')
            y(i, 2) = 1;
        elseif strcmp(species(i), 'virginica')
            y(i, 3) = 1;
        end
    end
    yTraining = y(1:trainingMax, :);
    yTesting = y(trainingMax+1:end, :);
end

function [Loss, errorRate] = train(x, xTesting, yTraining, yTesting, seed, activationFunction, activationFunctionDerivative)
    % ------------- initialization -------------
    % use the seed to initialize the random number generator
    rng(seed);
    % randomly initialized so the result is data dependent
    W1 = randn(4,8);
    b1 = randn(1, 8);

    W2 = randn(8, 3);
    b2 = randn(1, 3);

    epochs = 2000;
    learningRate = 0.1;

    m = size(x,1);

    % ------------- training loop -------------
    Loss = zeros(epochs, 1);
    for i = 1:epochs
        % ------------- forward pass -------------
        Z1 = x * W1 + repmat(b1, m, 1);
        A1 = activationFunction(Z1);

        Z2 = A1 * W2 + repmat(b2, m, 1);
        A2 = exp(Z2) ./ sum(exp(Z2), 2);
        % ------------- loss function -------------
        L = -1/m * sum(sum(yTraining .* log(A2)));
        Loss(i) = L;
        % ------------- backward pass -------------
        % layer 2
        dZ2 = A2 - yTraining; 
        dW2 = 1/m * A1' * dZ2;
        db2 = 1/m * sum(dZ2, 1);

        %layer 1
        dZ1 = (dZ2 * W2') .* activationFunctionDerivative(Z1);
        dW1 = 1/m * x' * dZ1;
        db1 = 1/m * sum(dZ1, 1);
        % ------------- update weights -------------
        W1 = W1 - learningRate * dW1;
        W2 = W2 - learningRate * dW2;
        b1 = b1 - learningRate * db1;
        b2 = b2 - learningRate * db2;
    end

    % ------------- testing loop -------------
    clear Z1 A1 Z2 A2;
    % forward pass
    m = size(xTesting,1);
    Z1 = xTesting * W1 + repmat(b1, m, 1);
    A1 = activationFunction(Z1);

    Z2 = A1 * W2 + repmat(b2, m, 1);
    A2 = exp(Z2) ./ sum(exp(Z2), 2);

    [~, estimatedResult] = max(A2, [], 2);
    [~, trueResult] = max(yTesting, [], 2);

    % error rate
    errorRate = sum(estimatedResult ~= trueResult) / size(xTesting, 1);
end

function A = sigmoid(Z)
    A = 1 ./ (1 + exp(-Z));
end
function A = sigmoidDerivative(Z)
    A = sigmoid(Z) .* (1 - sigmoid(Z));
end


%% Loss comparison between sigmoid and ReLU

% load data
percentage = 0.8;
[x, xTesting, yTraining, yTesting] = loadData(percentage);

function A = ReLU(Z)
    A = max(0, Z);
end
function A = ReLUDerivative(Z)
    A = Z > 0;
end

% get a random seed for the random number generator
seed = rng;

[Lsigmoid, ~] = train(x, xTesting, yTraining, yTesting, seed, @sigmoid, @sigmoidDerivative);
[LReLU, ~] = train(x, xTesting, yTraining, yTesting, seed, @ReLU, @ReLUDerivative);

% loss function plot
figure;
plot(Lsigmoid, 'LineWidth', 2);
hold on;
plot(LReLU, 'LineWidth', 2);
xlabel('Epochs');
ylabel('Loss');
legend('Sigmoid', 'ReLU');

%% Impact of the percentage of training data on error

% load activationComparison.mat if it exists
if exist('activationComparison.mat', 'file')
    load('activationComparison.mat');
    disp('Loaded activationComparison.mat');
    run = 0;
else
    disp('activationComparison.mat not found, running the code...');
    percentageVect = 0.1:0.025:0.9;
    avgErrorSigmoid = zeros(length(percentageVect), 1);
    avgErrorReLU = zeros(length(percentageVect), 1);
    run = 1;
end

if run == 1
    parfor i = 1:length(percentageVect)
        % load data
        [x, xTesting, yTraining, yTesting] = loadData(percentageVect(i));

        % looping for 100 times to average the error as a single test gives a varying result
        loopSize = 100;
        errorSigmoid = zeros(loopSize, 1);
        errorReLU = zeros(loopSize, 1);
        for j = 1:loopSize
            % get a random seed for the random number generator
            seed = rng;

            [~, errorSigmoid(j)] = train(x, xTesting, yTraining, yTesting, seed, @sigmoid, @sigmoidDerivative);
            [~, errorReLU(j)] = train(x, xTesting, yTraining, yTesting, seed, @ReLU, @ReLUDerivative);
        end

        % average the error
        avgErrorSigmoid(i) = mean(errorSigmoid);
        avgErrorReLU(i) = mean(errorReLU);
    end
    % save the results
    save('activationComparison.mat', 'avgErrorSigmoid', 'avgErrorReLU', 'percentageVect');
end

% error rate plot
figure;

% Subplot 1: Error rates for Sigmoid and ReLU
subplot(2, 1, 1);
plot(percentageVect, avgErrorSigmoid, 'LineWidth', 2);
hold on;
plot(percentageVect, avgErrorReLU, 'LineWidth', 2);
xlabel('Percentage of training data');
ylabel('Error rate');
legend('Sigmoid', 'ReLU');
title('Impact of the percentage of training data on error');

% Subplot 2: Difference between error rates
subplot(2, 1, 2);
plot(percentageVect, avgErrorReLU - avgErrorSigmoid, 'LineWidth', 2);
xlabel('Percentage of training data');
ylabel('Error rate difference (ReLU - Sigmoid)');
hold on;
yline(0, 'r--', 'LineWidth', 1);
hold off;
title('Difference in error rates between ReLU and Sigmoid');
