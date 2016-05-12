function [input_od] = pooling_layer_backward(output, input, layer)

%% function input:
% input: input of pooling_layer_forward
% output: output of pooling_layer_forward

% layer.k: kernel size of pooling operation
% layer.stride: stride of pooling operation
% layer.pad: pad of pooling operation


%% function output
% input_od: gradient w.r.t input.data

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;
k = layer.k;
stride = layer.stride;

% initialize
input_od = zeros(size(input.data));

switch layer.act_type
    case 'MAX'
        % work out the max pooling backward and compute input_od
        for n = 1:batch_size
            in_data = reshape(input.data(:, n), [h_in, w_in, c]);
            input_od_tmp = zeros(h_in, w_in, c);
            l = 1;
            for cc = 1:c
                for i = 1:stride:w_in
                    for j = 1:stride:h_in
                        patch = in_data(j:j+k-1, i:i+k-1, cc);
                        [~, max_idx] = max(patch(:));
                        patch = zeros(size(patch));
                        patch(max_idx) = 1;
                        patch = patch*output.diff(l, n);
                        input_od_tmp(j:j+k-1, i:i+k-1, cc) = patch;
                        l = l+1;
                    end
                end
            end
            input_od(:, n) = input_od_tmp(:);
        end
        
    case 'AVE'
        % work out the ave pooling backward and compute input_od        
        for n = 1:batch_size
            input_od_tmp = zeros(h_in, w_in, c);
            l = 1;
            for cc = 1:c
                for i = 1:stride:w_in
                    for j = 1:stride:h_in
                        patch = ones(k,k)/(k^2);
                        patch = patch*output.diff(l, n);
                        input_od_tmp(j:j+k-1, i:i+k-1, cc) = patch;
                        l = l+1;
                    end
                end
            end
            input_od(:, n) = input_od_tmp(:);
        end
end

end