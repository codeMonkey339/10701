load ('./news.mat');

% todo: need to replace the name of variables here and check dims
XTrain = standardize(XTrain);
[w1, b1, fval1] = dual(XTrain, YTrain);
[w2, b2, fval2] = primal(XTrain, YTrain);
Ypred_dual = test(XTest,w1, b1);
Ypred_primal = test(XTest, w2, b2);
accuracy_dual = sum(Ypred_dual == YTest) / length(YTest);
accuracy_primal = sum(Ypred_primal == YTest) / length(YTest);
