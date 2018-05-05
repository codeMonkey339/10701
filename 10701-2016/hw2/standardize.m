function [X] = standardize(X)
% standardize the feature matrix
% X: the training feature n * d
% @return
% X: the standardized feature matrix

X = bsxfun(@minus, X, mean(X));
X = bsxfun(@rdivide, X, std(X));
end
