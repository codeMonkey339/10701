function [C, a] = lloyd_iteration(X, C)
  % Implement your function here.
  n = size(X,1);
  a = zeros(n,1);
  while(1)
      aOld = a;
      a = update_assignments(X,C,a);
      C = update_centers(X,C,a);
      if a == aOld
          break;
      end
  end
end
