function [w] = lr_gd(w0, X, y)
% updates the weight vector w and returns its value after convergence
% implement gradient descent using the gradient function written
% w0: initial weight vector d * 1
% X: feature of training example d * n
% y: labels of training example 1 * n

% this implementation adopts SGD. program terminates either reaching max
% iteration number or gradient different is within tolerance level

max_itr = 100;
tol = 4e-4;
step_size = 1e-5;
w = w0;

f_prev = 1;

fprintf('started stochastic gradient descent\n');
for k = 1: max_itr
  for i = 1: size(X, 2)
      [f,g] = fv_grad(w, X(:,i), y(i));
      w = w - step_size * g;
  end
  
  f_diff = abs(f_prev - f)/ f_prev;
  fprintf('itr: %d, loglikelihood diff: %g\n', k, f_diff);
  if f_diff <= tol
    break;
  end
  f_prev = f;
end

end