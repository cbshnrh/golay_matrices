% Copyright (c) 2020 Key Laboratory for Information Science of Electromagnetic Waves (MoE),
% Department of Communication Science and Engineering, Fudan University, Shanghai, China
function [A, B] = gen_golay_matrices(M, L)
assert(mod(M, 2)==0 || mod(L, 2)==0, 'Infeasible length!');
if mod(M, 2) == 0
    L1 = M/2;
    L2 = L;
    dim = 1;
else
    L1 = M;
    L2 = L/2;
    dim = 2;
end

try
    pair1 = gen_golay_sequences(L1);
    pair2 = gen_golay_sequences(L2);
catch
    error('Infeasible length!')
end

a = pair1(1, :).';
b = pair1(2, :).';
c = pair2(1, :).';
d = pair2(2, :).';
A = cat(dim, a*c.', b*d.');
B = cat(dim, -a*flip(d'), b*flip(c'));
close all;
figure;
stem3(abs(xcorr2(A) + xcorr2(B)));
end
