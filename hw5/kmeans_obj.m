function obj = kmeans_obj(X, C, a)
  % Implement your function here.
  n = size(X,1);
  obj = 0;
  for i = 1:n
      obj = obj + (X(i,:)-C(a(i),:))*(X(i,:)-C(a(i),:))';
  end
end
