function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

%% function input
% output.data: output data of inner_product_forward
% output.diff: the gradient w.r.t otuput.data

%% function output
% param_grad.w: gradient w.r.t param.w
% param_grad.b: gradient w.r.t param.b
% input_od: gradient w.r.t input.data

%% here begins inner product backward computation

% initialize the gradient w.r.t param
param_grad.w = zeros(size(param.w)); % gradient w.r.t param.w
param_grad.b = zeros(size(param.b)); % gradient w.r.t param.b
input_od = zeros(size(input.data));

% start to work here to compute param_grad.w, param_grad.b, input_od
for i = 1:input.batch_size
    param_grad.w = param_grad.w + input.data(:,i) * output.diff(:,i)';
    param_grad.b = param_grad.b + output.diff(:,i)';
end
input_od = param.w * output.diff;
end
