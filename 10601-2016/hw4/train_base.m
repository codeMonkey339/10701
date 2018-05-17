function [model] = train_base(XTrain, YTrain, weight)
% train a base classifier with weigheted data
% XTrain: n * 2
% YTrain: n * 2
% weight: n * 1

% model.weight n * 1 updated data weight
% model.alpha weight of the classifier
% model.dim dimension of the deicison variable
% model.direction direction of the positive data, +1 for pos, -1 for neg

maxWeight = 0;
pos = 0;
dir = 0;
dim = 0;
correctI = yTrain;
I = yTrain;
for i = 1: size(sortedX, 2)
    curModel = scan_axis(sortedX, sortedY, weight, i);
    if curModel.accWeight > maxWeight
        pos = model.pos;
        dir = model.dir;
        dim = model.axis;
        correctI = curModel.correctI;
        I = curModel.I;
    end
end
sortedWeight = weight(I);
errorWeight = sortedWeight' * (1 - correctI);
modelWeight = 0.5 * log((1 - errorWeight) / errorWeight);
updatedDataWeight = sortedWeight .* (exp(-1 * modelWeight * correctI));
updatedDataWeight = updatedDataWeight(I);
%TODO: need to restore the order of weights
        
%%%%%%%%%%%%%%%%%%%%% scan the y-axis direction %%%%%%%%%%%%%%%%%%%%%%%%%%

    
end