function a = update_assignments(X, C, a)
  % Implement your function here.
  n = size(X,1);
  k = size(C,1);
  min_error = 1e9;
  for i = 1:n
      for j = 1:k
          error = (X(i,:)-C(j,:))*(X(i,:)-C(j,:))';
          if min_error > error
              min_error = error;
              idx = j;
          end
      end
      a(i) = idx;
      min_error = 1e9;
  end
end
