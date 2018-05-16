function [pred] = adaboost(trainX, trainY, testX, T)
% train and test an adaboost classifier
% trainX: m * 2 train feature matrix
% trainY: m * 1 groundtruth label
% testX: n * 2 test feature matrix
% T: number of iterations
%
% pred: n * 1 vector 
models = cell(T);
weight = 1 / size(trainX, 1) * ones(size(trainX, 1));
for i=1:T
    models(i) = train_base(trainX, trainY, weight);
end
pred = predict(testX, models);
end