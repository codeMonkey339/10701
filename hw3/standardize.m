function [Xnew] = standardize(X)
  % Standardize input matrix X
  % Center the mean of each feature to 0
  % Adjust each feature to have variance 1
  % dimension(X): d * n --> each column represents an image
  
  X = bsxfun(@minus, X, mean(X));
  Xnew = bsxfun(@rdivide, X, std(A));  
  % alternative implementation
  % (A - mean(A)) ./ std(A)
  
  end