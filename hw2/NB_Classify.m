function [yHat] = NB_Classify(D, p, XTest)
% Implement your function here.
yHat = zeros(size(XTest, 1), 1);
for i = 1:size(XTest, 1)
econo_probs = XTest(i, :) .* D(1, :) + (1-XTest(i, :)) .* (1-D(1, :));
onion_probs = XTest(i, :) .* D(2, :) + (1-XTest(i, :)) .* (1-D(2, :));

econo_score = logProd([log(econo_probs), log(p)]);
onion_score = logProd([log(onion_probs), log(1-p)]);

if (econo_score > onion_score)
yHat(i) = 1;
else
yHat(i) = 2;
end
end
end
