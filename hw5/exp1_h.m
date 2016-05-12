% Experiment 2
clear;clc
load 'kmeans_data.mat';
obj_rnd = zeros(1000,1);
obj_kmeans = zeros(1000,1);
for k = 1:1000
    [~,~,obj_rnd(k)] = kmeans_cluster(X, 9, 'random', 1);
    [~,~,obj_kmeans(k)] = kmeans_cluster(X, 9, 'kmeans++', 1);
end
obj_rnd = mean(obj_rnd);
obj_kmeans = mean(obj_kmeans);