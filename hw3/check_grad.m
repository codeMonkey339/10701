load lr_train.mat;

% initialize
epsilon = 1e-6;
num_iter = 2;

w = rand(size(train.X, 1), 1) * 1e-4;
d = length(w);
err = zeros(d, 1);

[f, g] = fv_grad(w, train.X, train.y);

% for i = 1 : num_iter
    grad_approx = zeros(d, 1);
    for j = 1 : d
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Your code here:
        w_pos = w;
        w_neg = w;
        w_pos(j) = w_pos(j)+epsilon;
        w_neg(j) = w_neg(j)-epsilon;
        [f_pos,~] = fv_grad(w_pos, train.X, train.y);
        [f_neg,~] = fv_grad(w_neg, train.X, train.y);
        grad_approx(j) = (f_pos-f_neg)/(2*epsilon);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    err = 1 / d * sum(abs(grad_approx - g));
% end

if mean(err) < 1e-6
    fprintf('pass!')
else
    fprintf('fail.')
end