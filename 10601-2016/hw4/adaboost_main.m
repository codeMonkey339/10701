%%%%%%%%%%%%%%%%%%%%%% main script for adaboost %%%%%%%%%%%%%%%%%%%%%%%%%%
nTrain = 100;
nTest = 20;

samples = gen_sample(nTrain, nTest);
T = 5:10:100; % # of iterations
res = [];
for i = 1:length(T)
    pred = adaboost(samples.XTrain, samples.YTrain, samples.XTest, T(i));
    accuracy = mean(pred == samples.YTest);
    fprintf('accuracy %i\n', accuracy);
    res = [res; accuracy];
end
disp(res);
