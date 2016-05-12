x = [1,0,3,5,18,14,5,7,13,9,0,17,4,24,3];
theta = 0.01:0.01:0.5;
n = [5, 10, 15];
p = zeros(1, 3);
log_likelihood = zeros(3, size(theta, 2));
for i = 1:3
    p(i) = n(i)/(n(i)+sum(x(1:(n(i)))));
    log_likelihood(i, :) = n(i)*log(theta)+sum(x(1:n(i)))*log(1-theta);
    figure;
    plot(theta, log_likelihood(i, :));
end