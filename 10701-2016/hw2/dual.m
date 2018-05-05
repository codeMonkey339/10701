function [w, b, obj_val] = dual(X,Y)
% X: training data n * d
% Y: training label n * 1
% @return
% w: the weight vector d * 1
% b: the offset term
% obj_val: the optimal objective value

%todo: implement the optimization

C = 1; % the upper bound for params
lb = 0;
X = [X ones(size(X, 1), 1];
H = X * X';
f = ones(size(X, 2), 1);
[alpha, fval, exitflag, output, lambda] = quadprog(H, f, [], [], Y', lb, C];
b = w(length(alpha));
w = w(1: length(alpha)-1);
obj_val = fval;
w = X' * (Y .* w');
