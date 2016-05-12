function [ f, g ] = fv_grad( w_curr, X, y )
%FV_GRAD: returns the objective function value f and the gradient g w.r.t w
%at point w_curr
%   w_curr is current weight vector (d * 1)
%   X is feature values (d * n)
%   y is label (1 * n)

% Set parameters
f = 0;
g = zeros(length(w_curr), 1);
lambda_val = 2;
lambda = ones(length(w_curr), 1) * lambda_val;
lambda(1) = 0;  % do not penalize weight associated with the intercept term

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here...
s = sigmoid(w_curr' * X);
f = -log(s)*y'-log(1-s)*(1-y)'+lambda_val*(w_curr'*w_curr)/2;

% Without regularization
% g = -X*(y-s)';

% With regularization
g = -X*(y-s)'+lambda.*w_curr;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

