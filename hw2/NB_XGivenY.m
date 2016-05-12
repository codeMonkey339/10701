function [D] = NB_XGivenY(XTrain, yTrain)
% Implement your function here.
EconoRows = find(yTrain == 1);
OnionRows = find(yTrain == 2);
Economist = XTrain(EconoRows, :);
Onion = XTrain(OnionRows, :);
D = [(sum(Economist) + 0.001) / (length(EconoRows) + 0.901) ;
(sum(Onion) + 0.001) / (length(OnionRows) + 0.901)];
end
