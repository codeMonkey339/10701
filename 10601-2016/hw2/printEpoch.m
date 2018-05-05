function [] = printEpoch(trainError, testError, m)
  fprintf("----------------------------- train error for %i samples----------\n", m)
  disp(trainError);
  fprintf("----------------------------- test error for %i samples ----------\n", m)
  disp(testError);  
end