function [s] = sigmoid(a)
  % computes the sigmoid of input a
  % dim(a) 1 * n
  % dim(s) 1 * n
  
  s = 1 ./ (1 + exp(-a));
  end