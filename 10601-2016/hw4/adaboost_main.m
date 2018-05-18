%%%%%%%%%%%%%%%%%%%%%% main script for adaboost %%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
close();
nTrain = 10;
nTest = 2;

%samples = gen_sample(nTrain, nTest);
load('ten_samples');
save('ten_samples', 'samples');
T = 5:10:100; % # of iterations
res = [];
plotData(samples.XTrain, samples.YTrain);
for i = 1:length(T)
    pred = adaboost(samples.XTrain, samples.YTrain, samples.XTest, T(i));
    accuracy = mean(pred == samples.YTest);
    fprintf('accuracy %i\n', accuracy);
    res = [res; accuracy];
end
