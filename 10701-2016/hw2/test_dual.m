% test case 1
X = [-1 0; -2 0; 1 0; 2 0];
Y = [-1; -1; 1; 1];
[w, b, obj] = dual(X, Y);
assert(norm(w - [1;0]) < 1e-5);
assert(norm(b - 0) < 1e-5);

% test case 2
X = [0, 0; -1 -1;1 1; 2 2];
Y = [-1;-1;1;1];
[w, b, obj] = dual(X, Y);
fprintf("%g", b);
