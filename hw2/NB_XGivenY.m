function [D] = NB_XGivenY(XTrain, YTrain)
% entry D(y,w) is the MAP estimate of theta with a Beta(1.001, 1.9)
% prior distribution. theta represents the conditional probability
% of X = 1 given Y = y

% XTrain: n * V dimensional matrix
% YTrain: n * 1 dimensional vector
% D: 2 * V dimensional vector
econ_rows = find(YTrain == 1);
onion_rows = find(YTrain == 2);
ecno_data = XTrain(econ_rows);
onion_data = XTrain(onion_data);


% MAP of bernoulli with Beta prior is basically adding alpha and beta
% to the numerator and denominator respectively
D = [(sum(econ_data) + 0.001) / (length(Econ_data) + 0.901);
(sum(onion_data) + 0.001) / (length(onion_data) + 0.901)];

end