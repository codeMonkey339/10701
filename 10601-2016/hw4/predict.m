function [pred] = predict(XTest, models)
% given the trained model, make predictions on testing data
%
% XTest n * 1
% models: T * 1 array with mode params
pred = zeros(1, size(XTest,1));
for i = 1: size(XTest,1)
    sum = 0;
    for j = 1: size(models,2)
        val = XTest(i, models(i).dim);
        if val < models(i).pos
            if models(i).direction == 1
                sum = sum - models(i).alpha;
            else
                sum = sum + models(i).alpha;
            end
        else
            if models(i).direction == 1
                sum = sum + models(i).alpha;
            else
                sum = sum - models(i).alpha;
            end
        end
    end
    pred(i) = sum >= 0;
end
pred = pred';
end