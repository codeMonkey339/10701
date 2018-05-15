clc;
clear all;
load ('./news.mat');
%pkg load optim

% X_train = standardize(X_train);


%%%%%%%%%%%%%%%%%%% the section for training use libsvm %%%%%%%%%%%%%%%%%
% model = fitcsvm(double(full(X_train)), y_train');
% Ytrain_svm = predict(model, double(full(X_train)));
% Ytest_svm = predict(model, double(full(X_test)));
% test_accuracy_svm = sum(Ytest_svm == y_test) / length(y_test);
% train_accuracy_svm = sum(Ytrain_svm == y_test) / length(y_test);

%%%%%%%%%%%%%%%%%%%% the section for homework %%%%%%%%%%%%%%%%%%%%%%%%%%%
% quad programming for dual problem
[w1, b1, fval1] = dual(X_train, y_train');
Ytest_dual = test(X_test,w1, b1);
Ytrain_dual = test(X_train, w1, b1);
test_accuracy_dual = mean(Ytest_dual' == y_test);
train_accuracy_dual = mean(Ytrain_dual' == y_train);

% quad programming for primal problem
[w2, b2, fval2] = primal(X_train, y_train');
Ypred_primal = test(X_test, w2, b2);
test_accuracy_primal = sum(Ypred_primal == y_test) / length(y_test);


%%%%%%%%%%%%%%%%%%%% the section for abalone dataset %%%%%%%%%%%%%%%%%%%%%
[X_train, y_train] = read_abalone();
[w1, b1, fval1] = dual(X_train, y_train);
Ytrain_dual = test(X_train, w1, b1);
train_accuracy_dual = sum(Ytrain_dual == y_train) / length(y_train);
model = fitcsvm(X_train, y_train);
label = predict(model, X_train);
train_accuracy_library = sum(label == y_train) / length(y_train);





