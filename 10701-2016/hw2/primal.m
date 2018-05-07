function [w, b, obj_val] = primal(X, Y)
% X: the training data n * d
% Y: the training label n * 1
% @return
% w: the weight vector d * 1
% b: the offset term
% obj_val: the optimal objective value

Y = double(Y);
C = 1; % the regularization coefficient
X = [X ones(size(X, 1), 1)];
H = eye(size(X, 2));
H = [H; zeros(size(X, 1), size(X, 2))];
H_zero = zeros(size(X, 1), size(X, 1));
H_zero = [zeros(size(X, 2), size(X, 1)); H_zero];
H = [H H_zero];
f = zeros(size(X, 2), 1);
f = [f; C * ones(size(X, 1), 1)]; 
A1 = -1 * eye(size(X, 1), size(X, 1));
A1 = [zeros(size(X, 1), size(X, 2)) A1];
b1 = zeros(size(X,1),1);
A2 = -1 * bsxfun(@times, X, Y);
A2 = [A2 -1 * eye(size(X, 1), size(X, 1))];
b2 = -1 * ones(size(X, 1), 1);
A = [A1; A2];
b = [b1; b2];
[w, fval, exitflag, output] = quadprog(H, f, A, b);
b = w(size(X,2));
w = w(1:size(X,2)-1);
obj_val = fval;

end

