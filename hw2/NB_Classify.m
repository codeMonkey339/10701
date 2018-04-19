function [yHat] = NB_Classify(D, p, X)
% X: m * V matrix containing m feature vectors
% D: 2 * V matrix containg MAP estimate of each word appearing
% p: prior probality, P(Y = 1)
% yHat: yHat(i) is the predicated label for the ith row of X

appear_sum = X * D';
absence_sum = (1 - X) * (1 - D)';
conditional_prob = appear_sum + absence_sum;
replicated_p = repmat(p, 1, size(X, 2));
log_map = logProd(log(replicated_p), log(X'))';
yHat = max(log_map);
end
