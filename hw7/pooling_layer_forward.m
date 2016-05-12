function [output] = pooling_layer_forward(input, layer)

%% function input:
% input.batch_size: batch_size of input
% input.height: height of input
% input.width : width of input
% input.data: the actual data of input
% input.data is of size (input.height*input.width*input.channel, input.batch_size)

% layer.k: kernel size of pooling operation
% layers.stride: stride of pooling operation
% layers.pad: pad of pooling operation


%% function output
% output: the output of inner_product_forward

% figure out the output shape
h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;
k = layer.k;
layer.pad = 0;
pad = layer.pad;
stride = layer.stride;

h_out = (h_in + 2*pad - k) / stride + 1;
w_out = (w_in + 2*pad - k) / stride + 1;
assert(h_out == floor(h_out), 'h_out is not integer')
assert(w_out == floor(w_out), 'w_out is not integer')

% set output shape
output.height = h_out;
output.width = w_out;
output.channel = c;
output.batch_size = batch_size;

% initialize output.data
output.data = zeros(h_out*w_out*c, batch_size);


switch layer.act_type
    case 'MAX'
        % work out the max pooling and compute output.data
        for n = 1:batch_size
            data = input.data(:, n);
            data = reshape(data, [h_in, w_in, c]);
            idx = 1;
            for cc = 1:c
                for i = 1:stride:w_in
                    for j = 1:stride:h_in
                        patch = data(j:j+k-1, i:i+k-1, cc);
                        output.data(idx, n) = max(patch(:));
                        idx = idx+1;
                    end
                end
            end
        end
        
    case 'AVE'
        % work out the average pooling and compute output.data
        for n = 1:batch_size
            data = input.data(:, n);
            data = reshape(data, [h_in, w_in, c]);
            idx = 1;
            for cc = 1:c
                for i = 1:stride:w_in
                    for j = 1:stride:h_in
                        patch = data(j:j+k-1, i:i+k-1, cc);
                        output.data(idx, n) = mean(patch(:));
                        idx = idx+1;
                    end
                end
            end
        end
        
end

end

