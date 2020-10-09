# A genarator for golay matrices
## Usage
  [A, B] = gen_golay_matrices(M, L);
  
  Input: (M, L) is the size of the required golay matrices, at least one of M and L must be even.
  
  Output: A and B are two genarated golay matrices, the sum of whose auto-correlation functions is a 2-D delta-function, which is illustrated in a figure by stem3 function in matlab
