function [pred] = predict(XTest, models)
% given the trained model, make predictions on testing data
%
% XTest n * 1
% models: T * 1 array with mode params
pred = zeros(1, size(XTest,1));
modelWeightSum = 0;
for i = 1:size(models,2)
    modelWeightSum = modelWeightSum + models(i).alpha;
for i = 1: size(XTest,1)
    sum = 0;
    for j = 1: size(models,2)
        val = XTest(i, models(j).dim);
        if val < models(j).pos
            if models(j).direction == 1
                sum = sum - models(j).alpha;
            else
                sum = sum + models(j).alpha;
            end
        else
            if models(j).direction == 1
                sum = sum + models(j).alpha;
            else
                sum = sum - models(j).alpha;
            end
        end
    end
    pred(i) = sum/modelWeightSum >= 0;
end
pred = pred';
end