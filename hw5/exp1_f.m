% Experiment 1
clear;clc
load 'kmeans_data.mat';
obj = zeros(20,1);
for k = 1:20
    [~,~,obj(k)] = kmeans_cluster(X, k, 'random', 10);
end
plot(1:20,obj);