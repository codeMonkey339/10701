trainError = zeros(17, 1);
testError = zeros(17, 1);
i = 0;
for m = 100:30:580
    i = i+1;
    D = NB_XGivenY(XTrain(1:m, :), yTrain(1:m));
    p = NB_YPrior(yTrain(1:m));
    yHatTrain = NB_Classify(D, p, XTrain(1:m, :));
    yHatTest = NB_Classify(D, p, XTest);
    trainError(i) = ClassificationError(yHatTrain, yTrain(1:m));
    testError(i) = ClassificationError(yHatTest, yTest);
end