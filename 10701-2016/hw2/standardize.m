function [X] = function(X)
% standardize the feature matrix
% X: the training feature n * d
% @return
% X: the standardized feature matrix

X = bxsfun(@minus, X, mean(X));
X = bxsfun(@rdivide, X, std(X));
end
