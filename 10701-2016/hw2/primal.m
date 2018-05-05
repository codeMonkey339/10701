function [w, b, obj_val] = primal(X, Y)
% X: the training data n * d
% Y: the training label n * 1
% @return
% w: the weight vector d * 1
% b: the offset term
% obj_val: the optimal objective value

X = [X ones(size(X, 1), 1)];
H = eye(size(X, 2));
H = [H; zeros(size(X, 1), size(X, 2))];
H_zero = zeros(size(X, 1), size(X, 1));
H_zero = [zeros(size(X, 2), size(X, 1)); H_zero];
H = [H H_zero];
A = zeros(size(X, 1), size(X, 2));
A_nonzero = -1 * ones(size(X, 1), size(X, 1));
A = [A A_nonzero];
b = zeros(size(X, 1), 1);
% todo: need to complete the row-wise multiplication

