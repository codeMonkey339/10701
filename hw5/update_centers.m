function C = update_centers(X, C, a)
  % Implement your function here.
  k = size(C,1);
  for i = 1:k
      clusters_pts = X(a==i, :);
      C(i,:) = mean(clusters_pts);
  end
end
