function [f,g] = fv_grad(w, X, y)
  % returns the objective function value f (i.e negative loglikelihood) and its
  % gradient g w.r.t w at w
  % w is current weight vector (d * 1)
  % X is feature values (d * n)
  % y is label (1 * n)

  lambda = 2; % the default coefficient for regularization
  mask = ones(length(w), 1);
  mask(1,1) = 0;
  
  sigmoid = sigmoid(w' * X); % evaluate the sigmoid function
  f = -log(sigmoid) .* y' - log(1 - sigmoid) .* (1 - y)' +  lambda * (w' * w)/2;
  g = -X * (y - sigmoid)' + lambda * mask .* w;
  end