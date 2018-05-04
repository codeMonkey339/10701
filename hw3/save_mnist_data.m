% this file will read the raw format of mnist data set and save relevant data to
% mat file




% read images from train data set
data_path = './data/train-images.idx3-ubyte';
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

imgs = zeros([h w count]);
for i=1:count
  for j=1:h
    imgs(j, :, i) = fread(fid, w, uint8_size);
  end
end


fclose(fid);


% read lables from train data set
label_path = './data/train-labels.idx1-ubyte';
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

% save the data into a mat file
fclose(fid);
XTrain = reshape(X, [], size(X, 3), 1);
YTrain = y;
save('lr_data.mat', 'XTrain', 'YTrain');


