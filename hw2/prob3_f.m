clc;
clear;
load('HW2Data.mat')

result = [];
for i = 100:30:580
  xTrainData = XTrain(1:i, :);
  yTrainData = yTrain(1:i, :);
  xTestData = XTest(:, :);
  yTestData = yTest(:, :);
  D = NB_XGivenY(xTrainData, yTrainData);
  p = NB_YPrior(yTrainData);
  yHatTrain = NB_Classify(D, p, xTrainData);
  yHatTest = NB_Classify(D, p, xTestData);
  trainError = ClassificationError(yHatTrain, yTrainData);
  testError = ClassificationError(yHatTest, yTestData);
  printEpoch(trainError, testError, i);
  result = [result; [i trainError testError]];
end
plot(result(:, 1), result(:, 2), '-.r*');
hold on;
plot(result(:, 1), result(:, 3), '-.bmo');
legend('Train error', 'Test error');
