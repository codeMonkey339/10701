function [p] = NB_YPrior(yTrain)
% p: MLE for estimating Y == 1
exists = sum(yTrain == 1) / length(yTrain);
p = [exists; 1- exists];

end
