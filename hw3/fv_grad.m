function [f,g] = fv_grad(w, X, y)
  % returns the objective function value f (i.e negative loglikelihood) and its
  % gradient g w.r.t w at w
  % w is current weight vector (d * 1)
  % X is feature values (d * n)
  % y is label (1 * n)
  
  prod = (w' * X)';
  class1_loglikelihood = y' .* log(1 + exp(-1 * prod));
  class2_loglikelihood = (1 - y)' .* log(1 + exp(prod));
  loglikelihood = class1_loglikelihood + class2_loglikelihood;
  
  class1_gradient = y' * (bsxfun(@rdivide, -1 * X, (1 + exp(prod))'));
  class2_gradient = (1 - y)' * (bsxfun(@rdivide, X, (1 + exp(-prod))));
  
  f = class1_loglikelihood + class2_loglikelihood;
  g = class1_gradient + class2_loglikelihood;
  end