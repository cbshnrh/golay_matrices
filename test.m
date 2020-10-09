[A, B] = gen_golay_matrices(38, 111);
close all;
figure;
stem3(abs(xcorr2(A) + xcorr2(B)));





        
