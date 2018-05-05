function [Y] = test(X, w, b)
% given the test feature matrix, weight vector w and offset term b,
% classify test data points
%
% X: testing feature matrix: n * d
% w: weight vector: d * 1
% b: the offset term

prod = X * w + b;
Y = prod >= 0;

end
