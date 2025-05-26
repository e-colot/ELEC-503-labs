clear; close all; clc;

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

% keeping 80% of the data for training and 20% for testing
trainingMax = floor(0.8*size(meas, 1));
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

% ------------- initialization -------------
% randomly initialized so the result is data dependent
W1 = randn(4,8);
b1 = randn(1, 8);

W2 = randn(8, 3);
b2 = randn(1, 3);

epochs = 2000;
learningRate = 0.1;

% ------------- training loop -------------
Loss = zeros(epochs, 1);
for i = 1:epochs
    % ------------- forward pass -------------
    m = size(x,1);
    Z1 = x * W1 + repmat(b1, m, 1);
    A1 = 1 ./ (1 + exp(-Z1));

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
    dZ1 = (dZ2 * W2') .* (A1 .* (1 - A1));
    dW1 = 1/m * x' * dZ1;
    db1 = 1/m * sum(dZ1, 1);
    % ------------- update weights -------------
    W1 = W1 - learningRate * dW1;
    W2 = W2 - learningRate * dW2;
    b1 = b1 - learningRate * db1;
    b2 = b2 - learningRate * db2;
end

% loss function plot
figure;
plot(Loss, 'LineWidth', 2);
xlabel('Epochs');
ylabel('Loss');

% ------------- testing loop -------------
clear Z1 A1 Z2 A2;
% forward pass, test data
m = size(xTesting,1);
Z1 = xTesting * W1 + repmat(b1, m, 1);
A1 = 1 ./ (1 + exp(-Z1));

Z2 = A1 * W2 + repmat(b2, m, 1);
A2 = exp(Z2) ./ sum(exp(Z2), 2);

[~, estimatedResult] = max(A2, [], 2);
[~, trueResult] = max(yTesting, [], 2);

% forward pass, training data
m = size(x,1);
Z1 = x * W1 + repmat(b1, m, 1);
A1 = 1 ./ (1 + exp(-Z1));
Z2 = A1 * W2 + repmat(b2, m, 1);
A2 = exp(Z2) ./ sum(exp(Z2), 2);

[~, estimatedResultTraining] = max(A2, [], 2);
[~, trueResultTraining] = max(yTraining, [], 2);

figure;
plot(trueResult, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
hold on;
plot(estimatedResult, 'bx', 'MarkerSize', 10, 'LineWidth', 2);
hold off;
yticks(1:3);
yticklabels({'setosa', 'versicolor', 'virginica'});
xlabel('Sample number');
ylabel('Class number');
legend('True result', 'Estimated result');
title('True vs Estimated result');
axis([0 size(xTesting, 1) 0 4]);
grid on;

TR = cell(size(trueResult, 1), 1);
for i = 1:size(trueResult, 1)
    if trueResult(i) == 1
        TR{i} = 'setosa';
    elseif trueResult(i) == 2
        TR{i} = 'versicolor';
    elseif trueResult(i) == 3
        TR{i} = 'virginica';
    end
end
ER = cell(size(trueResult, 1), 1);
for i = 1:size(estimatedResult, 1)
    if estimatedResult(i) == 1
        ER{i} = 'setosa';
    elseif estimatedResult(i) == 2
        ER{i} = 'versicolor';
    elseif estimatedResult(i) == 3
        ER{i} = 'virginica';
    end
end

TRT = cell(size(trueResultTraining, 1), 1);
for i = 1:size(trueResultTraining, 1)
    if trueResultTraining(i) == 1
        TRT{i} = 'setosa';
    elseif trueResultTraining(i) == 2
        TRT{i} = 'versicolor';
    elseif trueResultTraining(i) == 3
        TRT{i} = 'virginica';
    end
end
ERT = cell(size(estimatedResultTraining, 1), 1);
for i = 1:size(estimatedResultTraining, 1)
    if estimatedResultTraining(i) == 1
        ERT{i} = 'setosa';
    elseif estimatedResultTraining(i) == 2
        ERT{i} = 'versicolor';
    elseif estimatedResultTraining(i) == 3
        ERT{i} = 'virginica';
    end
end

% confusion matrix
figure;
subplot(1,2,1);
confusionchart(TR, ER);
title('Confusion matrix of test data');
subplot(1,2,2);
confusionchart(TRT, ERT);
title('Confusion matrix of training data');

% decision boundaries
maxFeatures = max(meas);
minFeatures = min(meas);

numberOfPlots = sum(1:length(maxFeatures)-1);
subplotRows = ceil(sqrt(numberOfPlots));
subplotCols = ceil(numberOfPlots / subplotRows);
subplotCnt = 1;
numberOfPoints = 100;

figure;
colormap(jet(3)); % Set colormap for consistent coloring across subplots
for i = 1:length(maxFeatures)
    for j = i+1:length(maxFeatures)
        
        % create a grid of points
        subplot(subplotRows, subplotCols, subplotCnt);
        subplotCnt = subplotCnt + 1;

        iFeature = linspace(minFeatures(i), maxFeatures(i), numberOfPoints);
        jFeature = linspace(minFeatures(j), maxFeatures(j), numberOfPoints);

        data = zeros(numberOfPoints^2, size(meas, 2));
        iFeature = repmat(iFeature', numberOfPoints, 1);
        jFeature = repmat(jFeature, numberOfPoints, 1);
        jFeature = reshape(jFeature, numberOfPoints^2, 1);

        data(:, i) = iFeature;
        data(:, j) = jFeature;
        
        % forward pass
        m = size(data,1);
        Z1 = data * W1 + repmat(b1, m, 1);
        A1 = 1 ./ (1 + exp(-Z1));

        Z2 = A1 * W2 + repmat(b2, m, 1);
        A2 = exp(Z2) ./ sum(exp(Z2), 2);

        % plot decision boundaries
        [~, estimatedResult] = max(A2, [], 2);
        scatter(data(:, i), data(:, j), 10, estimatedResult, 'filled');
        hold on;
        xlabel(['Feature ' num2str(i)]);
        ylabel(['Feature ' num2str(j)]);

    end
end
sgtitle('Decision boundaries'); % Add a shared title for all subplots

% Add a unique legend for all subplots
legendLabels = {'setosa', 'versicolor', 'virginica'};
colormap(jet(3)); % Ensure the colormap matches the number of classes
% get min and max values for colorbar
caxis([0, 6]); % Set color axis limits to match the number of classes
colorbar('Ticks', [1, 3, 5], 'TickLabels', legendLabels, 'Location', 'eastoutside', 'Position', [0.92, 0.1, 0.02, 0.8]);

