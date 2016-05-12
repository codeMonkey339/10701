% Parameters 
% (Feel free to change the parameters for fun, 
% but use trainsize = 400; testsize = 100; for report)
trainsize = 400;
testsize = 100;
num_iter = 20;
[train.X, train.y] = gen_sample(trainsize);
[test.X, test.y] = gen_sample(testsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Your experiments goes here:
T = [20, 50, 100, 200];
figure;
for t = 1:4
    [pred, model] = adaboost(train.X, train.y, test.X, T(t));
    error_hi = zeros(T(t),1);
    error = zeros(T(t),1);
    margin = zeros(T(t),1);
    error_test = zeros(T(t),1);
    
    for i = 1:T(t)
        error_hi(i) = model(i).error_hi;
        error(i) = model(i).error;
        tmp = model(i).margin(model(i).margin>0);
        margin(i) = min(tmp);
    end
%     figure;
    
%     figure;
%     subplot(2,2,t);
%     plot(1:T(t), margin);
    title(T(t));
%     figure;
    
    plot(1:T(t), error_hi);
%     figure;
%     plot(1:t, error);
%     hold on
%     for j = 1:t
%         [pred, model] = adaboost(train.X, train.y, test.X, j);
%         error_test(j) = sum(pred~=test.y)/length(test.y);
%     end
%     plot(1:t, error_test);
%     hold off
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%