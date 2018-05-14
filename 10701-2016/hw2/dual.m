function [w, b, obj_val] = dual(X,Y)
% X: training data n * d
% Y: training label n * 1
% @return
% w: the weight vector d * 1
% b: the offset term
% obj_val: the optimal objective value

%todo: implement the optimization

C = double(ones(size(X, 1), 1)); % the upper bound for params
lb = double(zeros(size(X, 1), 1));
Y = double(Y);
Y_replicated = repmat(Y, 1, size(X, 2));
H = X .* Y_replicated;
H = H * H';
H = H + diag(ones(size(H, 1),1) * eps^(2/3));
f = -1 * ones(size(X, 1), 1);
beq = [0];
options = optimset('MaxIter', 1000);
[alpha, fval, exitflag, output, lambda] = quadprog(H, f, [], [], Y', beq, lb, ...
C, [], options);
w = X' * (Y .* alpha);
alpha_nonzero = find(alpha > 1e-4 & alpha < C(1));
b = Y(alpha_nonzero(1)) - w' * X(alpha_nonzero(1), :)';
obj_val = fval;
end

% find b from the value of w
