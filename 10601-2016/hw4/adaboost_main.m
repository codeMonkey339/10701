%%%%%%%%%%%%%%%%%%%%%% main script for adaboost %%%%%%%%%%%%%%%%%%%%%%%%%%
nTrain = 10000;
nTest = 2000;
T = 100; % # of iterations
samples = gen_sample(nTrain, nTest);
pred = adaboost(samples.XTrain, samples.XTest, samples.XTest, T);
accuracy = mean(pred == samples.YTest);
fprintf('accuracy %i\n', accuracy);
