z1 = mvnrnd([0, 0], [1 0;0 1], 1000);
figure(1);
% subplot(3,2,1);
scatter(z1(:, 1), z1(:, 2));
title('MU = [0, 0], SIGMA = [1 0;0 1]');

z2 = mvnrnd([1, 1], [1 0;0 1], 1000);
% subplot(3,2,2);
figure(2);
scatter(z2(:, 1), z2(:, 2));
title('MU = [1, 1], SIGMA = [1 0;0 1]');

z3 = mvnrnd([0, 0], [2 0;0 2], 1000);
% subplot(3,2,3);
figure(3);
scatter(z3(:, 1), z3(:, 2));
title('MU = [0, 0], SIGMA = [2 0;0 2]');

z4 = mvnrnd([0, 0], [1 0.5;0.5 1], 1000);
% subplot(3,2,4);
figure(4);
scatter(z4(:, 1), z4(:, 2));
title('MU = [0, 0], SIGMA = [1 0.5;0.5 1]');

z5 = mvnrnd([0, 0], [1 -0.5;-0.5 1], 1000);
% subplot(3,2,5);
figure(5);
scatter(z5(:, 1), z5(:, 2));
title('MU = [0, 0], SIGMA = [1 -0.5;-0.5 1]');