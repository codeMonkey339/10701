function [yHat] = NB_Classify(D, p, X)
% X: m * V matrix containing m feature vectors
% D: 2 * V matrix containg MAP estimate of each word appearing
% p: prior probality, P(Y = 1)
% yHat: yHat(i) is the predicated label for the ith row of X

appear_sum = X * log(D');
absence_sum = (1 - X) * log(1 - D)';
conditional_prob = appear_sum + absence_sum;
replicated_p = repmat(p, 1, size(X, 1));
%log_map = logProd(log(replicated_p), log(conditional_prob'))';
log_map = log(replicated_p) + conditional_prob';
[maxElem, indices] = max(log_map);
yHat = indices';
end
