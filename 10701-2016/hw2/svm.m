load ('./news.mat');
%pkg load optim

% X_train = standardize(X_train);

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
