function [p] = NB_YPrior(yTrain)
% p: MLE for estimating Y == 1
p = sum(yTrain == 1) / length(yTrain)

end
