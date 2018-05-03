X = [1 1;1 1;1 1];
Y = [1;1;2];

expectedResult = [(2 + 0.001) / (2 + 0.901), (2 + 0.001) / (2 + 0.901);(1 + 0.001)/(1 + 0.901),(1 + 0.001)/(1 + 0.901)];
actualResult = NB_XGivenY(X, Y);
diff = expectedResult - actualResult;
disp("asserting expected value and actual value");
disp(sqrt(sum(diff .* diff)) < 0.01);