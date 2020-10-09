% to combine 2 pairs of complex golay sequences by a pair of binary golay sequences
% input: x and y are binary golay sequences of length g
%        a and b are complex golay sequences of length g1
%        c and d are complex golay sequences of length g2
% output: pair is the genarated golay sequences of length g*g1*g2
% Last modified on Oct. 8, 2020
% Copyright Communication System Research Laboratory, Fudan University
function pair = golay_glue(x, y, a, b, c, d)
u = 1/4 * (x+flip(x)+y-flip(y));
v = 1/4 * (x-flip(x)+y+flip(y));
s = kron(a, u) + kron(b, v);
t = kron(a, flip(conj(v))) - kron(b, flip(conj(u)));
e = kron(c, s) + kron(flip(conj(d)), t);
f = kron(flip(conj(c)), t) - kron(d, s);
pair = [e; f];
