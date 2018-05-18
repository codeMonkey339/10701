function [model] = train_base(XTrain, YTrain, weight)
% train a base classifier with weigheted data
% XTrain: n * 2
% YTrain: n * 2
% weight: n * 1

% model.weight n * 1 updated data weight
% model.alpha weight of the classifier
% model.dim dimension of the deicison variable
% model.direction direction of the positive data, +1 for pos, -1 for neg
% model.pos the position of the decision plane
model = struct;
maxWeight = 0;
pos = 0;
dir = 0;
dim = 0;
classification = zeros(size(YTrain,1),1); % the classification result
for i = 1: size(XTrain, 2)
    curModel = scan_axis(XTrain, YTrain, weight, i);
    if curModel.accWeight > maxWeight
        pos = curModel.pos;
        dir = curModel.dir;
        dim = curModel.axis;
        classification = curModel.classification;
        maxWeight = curModel.accWeight;
    end
end
classRes = (YTrain ~= classification);
errorWeight = weight' * classRes;
if abs(errorWeight) < 1e-3
    modelWeight = 100; % random large weight for 100% accuracy
else
    modelWeight = 0.5 * log((1 - errorWeight) / errorWeight);
end
updatedDataWeight = weight .* (exp(-1 * modelWeight * (2*(classification == YTrain) - 1)));
model.weight = updatedDataWeight / sum(updatedDataWeight);
model.alpha = modelWeight;
model.dim = dim;
model.direction = dir;
model.pos = pos;
end