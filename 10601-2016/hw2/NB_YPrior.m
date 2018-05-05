function [p] = NB_YPrior(yTrain)
% this method estimates the probability of label Y=0 & Y=1
%
% p: MLE for estimating Y == 1
exists = sum(yTrain == 1) / length(yTrain);
p = [exists; 1- exists];

end
