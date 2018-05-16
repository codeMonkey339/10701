function [X_train, y_train] = read_abalone()
% read data from abalone dataset

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
X_train(:, 2:size(X_train,2)) = standardize(X_train(:, 2:size(X_train,2)));
X_train = X_train(find(X_train(:,1) ~= 0),:);
y_train = X_train(find(X_train(:,1) ~= 0),1);
X_train = X_train(:, 2:size(X_train, 2));
end