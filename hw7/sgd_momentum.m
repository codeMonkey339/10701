function [params, param_winc] = sgd_momentum(rate, mu, weight_decay, params, param_winc, param_grad)
% update the parameter with sgd with momentum

%% function input
% rate: learning rate at current step
% mu: momentum
% weight_decay: weigth decay of w
% params: original weight parameter
% param_winc: buffer to store history gradient accumulation
% param_grad: gradient of parameter

%% function output
% params: updated parameters
% param_winc: updated buffer

for l_idx =1:length(params)
    p_l = params{l_idx};
    p_grad_l = param_grad{l_idx};
    p_winc_l = param_winc{l_idx};
    p_grad_l.w = p_grad_l.w + weight_decay*p_l.w;
    p_winc_l.w = mu*p_winc_l.w + rate*p_grad_l.w;
    p_winc_l.b = mu*p_winc_l.b + rate*p_grad_l.b;
    p_l.w = p_l.w - p_winc_l.w;
    p_l.b = p_l.b - p_winc_l.b;
    params{l_idx} = p_l;
    param_winc{l_idx} = p_winc_l;
end

end
