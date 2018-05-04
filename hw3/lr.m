load ('data/lr_data.mat')

% assume XTrain, YTrain, XTest, YTest is there
XTrain = standardize(XTrain);
w0 = ones(size(XTrain, 1), 1);
w = lr_gd(w0, XTrain, YTrain);
yTrainPred = lr_pred(w, XTrain);
train_accuracy = sum(yTrainPred == YTrain) / size(YTrain, 2);
yTestPred = lr_pred(w, XTest);
test_accuracy = sum(yTestPred == YTest) / size(YTest, 2);
fprintf('Train accuracy: %g, Test accuracy: %g\n', train_accuracy, test_accuracy);
