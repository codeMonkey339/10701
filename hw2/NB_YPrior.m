function [p] = NB_YPrior(yTrain)
% Implement your function here.
p = sum(yTrain==1)/length(yTrain);
end
