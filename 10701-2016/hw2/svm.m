clc;
clear all;
% load ('./news.mat');
%pkg load optim

% X_train = standardize(X_train);


%%%%%%%%%%%%%%%%%%% the section for training use libsvm %%%%%%%%%%%%%%%%%
% model = fitcsvm(double(full(X_train)), y_train');
% Ytrain_svm = predict(model, double(full(X_train)));
% Ytest_svm = predict(model, double(full(X_test)));
% test_accuracy_svm = sum(Ytest_svm == y_test) / length(y_test);
% train_accuracy_svm = sum(Ytrain_svm == y_test) / length(y_test);

%%%%%%%%%%%%%%%%%%%% the section for abalone dataset %%%%%%%%%%%%%%%%%%%%%
fid = fopen('./data/abalone.txt', 'r');
X_train = [];
y_train = [];
line = fgetl(fid);
while ischar(line)
    tokens = strsplit(line, ',');
    l = [];
    for i=1:length(tokens)
        if i == 1
            if tokens{1,1} == 'M'
                l = [1 l];
            elseif tokens{1,1} == 'F'
                l = [-1 l];
            else
                l = [0 l];
            end
            continue;
        end        
        l = [l str2double(tokens(i))];
    end
    X_train = [X_train;l];
    line = fgetl(fid);
end
X_train = X_train(find(X_train(:,1) ~= 0),:);
y_train = X_train(find(X_train(:,1) ~= 0),1);
[w1, b1, fval1] = dual(X_train, y_train);
Ytrain_dual = test(X_train, w1, b1);
train_accuracy_dual = sum(Ytrain_dual == y_train') / length(y_train);

%%%%%%%%%%%%%%%%%%%% the section for homework %%%%%%%%%%%%%%%%%%%%%%%%%%%
% quad programming for primal problem
[w2, b2, fval2] = primal(X_train, y_train');
Ypred_primal = test(X_test, w2, b2);
test_accuracy_primal = sum(Ypred_primal == y_test) / length(y_test);


% quad programming for dual problem
[w1, b1, fval1] = dual(X_train, y_train');
Ytest_dual = test(X_test,w1, b1);
Ytrain_dual = test(X_train, w1, b1);
test_accuracy_dual = sum(Ytest_dual == y_test) / length(y_test);
train_accuracy_dual = sum(Ytrain_dual == y_train) / length(y_train);



