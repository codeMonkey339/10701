% this file will read the raw format of mnist data set and save relevant data to
% mat file

fileNames = {'./data/train-images.idx3-ubyte', './data/train-labels.idx1-ubyte'; './data/t10k-images.idx3-ubyte', './data/t10k-labels.idx1-ubyte'};

XTrain = [];
YTrain = [];
XTest = [];
YTest = [];

for type = 1: size(fileNames, 2)
  data_path = fileNames(type, 1){:};
  label_path = fileNames(type, 2){:};
  
  % data file
  int_size = 'int32';
  uint8_size = 'uint8';
  fid = fopen(data_path, 'r', 'b');
  magic_no = fread(fid, 1, int_size);

  if magic_no ~= 2051
    error('Invalid image file handler');
  end

  count = fread(fid, 1, int_size);
  h = fread(fid, 1, int_size);
  w = fread(fid, 1, int_size);

  % label file
  imgs = zeros([h w count]);
  for i=1:count
    for j=1:h
      imgs(j, :, i) = fread(fid, w, uint8_size);
    end
  end
  fclose(fid);

  fid = fopen(label_path, 'r', 'b');
  magic_no = fread(fid, 1, int_size);
  if magic_no ~= 2049
    error('Invalid label file handler');
  end

  count = fread(fid, 1, int_size);
  labels = fread(fid, count, uint8_size);
  labels4 = find(labels == 4);
  labels7 = find(labels == 7);
  y4 = ones(1, length(labels4));
  y7 = zeros(1, length(labels7));
  y = [y4 y7];
  imgs4 = imgs(:, :, labels4);
  imgs7 = imgs(:, :, labels7);
  X = cat(3, imgs4, imgs7);
  fclose(fid);
  
  if type == 1
    XTrain = reshape(X, [], size(X, 3), 1);
    YTrain = y;
  else
    XTest = reshape(X, [], size(X, 3), 1);
    YTest = y;
  end
end

save('lr_data.mat', 'XTrain', 'YTrain', 'XTest', 'YTest');


