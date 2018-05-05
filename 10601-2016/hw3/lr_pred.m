function [pred] = lr_pred(w, X)
% return a vector with predicted labels on input X
% w weight vector d * 1
% X feature matrix d * n

prod = w' * X;
sigmoid = sigmoid(prod);
ratio = sigmoid ./ (1 - sigmoid);
pred = ratio > 1;
end