function [a,b] = gen_const_modul_golay_codes(M,psl)
% to generate constant modulus L-length Golay complementary codes
% inputs:
%        M: coding length
%        psl: peak sidelobe
% output: 
%        a,b: the obtained Golay pair
% Last modified on Oct. 8, 2020
% Copyright Communication System Research Laboratory, Fudan University
if nargin < 2
    psl = 1e-15;
end

% %%
for nn = 1:1e6 
    xk = 2*pi*rand(2*M,1); % random initialization
    [f,df] = calc_f_df(xk);
    normOld = norm(f);
    zeroImprovCnt = 0;
    iterCnt = 0;
    while zeroImprovCnt <= 15  % one of the try to solve the equations        
        Jacobi = [real(df);imag(df)];
        f = [real(f);imag(f)];
%        vNt = pinv(Jacobi)*f;
        [Q,R] = qr(Jacobi.',0);   Rt = R.';   vNt = Q*(Rt\f); % it's faster than using pinv;
        s = 1;
        for n = 1:50  % to find s
            ys = xk-s*vNt;
            f = calc_f_df(ys);
            normNew = norm(f);
            if normNew <= (1-s/2)*normOld
                break;
            end
            s = s/2;
        end
        xk = ys;
        currPsl = max(abs(f))/(2*M);
        if currPsl<psl % the Jacobi matrix will be nearly singular when get close to a solution
            fprintf('M= %d, Try # %4d, Terminate after %3d Iterations, PSL = %E\n',M,nn,iterCnt, currPsl);
            W = exp(1j*reshape(ys,M,2));
            fprintf('M= %d, Done after %d iterations!\n',M,iterCnt);
            % sv = svd(Jacobi);
            % sv(2*(M-1)-1)
            a = W(:,1);
            b = W(:,2);
            figure,semilogy(-M+1:M-1,abs(xcorr(a)+xcorr(b))/(2*M));
            return
        end
        if abs(normNew-normOld) < 1e-4*normOld
            zeroImprovCnt = zeroImprovCnt + 1;
        else
            zeroImprovCnt = 0;
        end
        [f,df] = calc_f_df(xk);
        normOld = normNew;
        iterCnt = iterCnt+1;
    end
    %if mod(nn,10)==1
    fprintf('M= %d, Try # %4d, Terminate after %3d Iterations, PSL = %E\n',M,nn,iterCnt, currPsl);
    %end
end
end

function [f,df] = calc_f_df(x)
M = length(x)/2;
thta = x(1:M);
phi = x(M+1:2*M);
if nargout==1
        f1 = calc_f_df_sub(thta);
        f2 = calc_f_df_sub(phi);
        f = f1+f2;
else
        [f1,df1] = calc_f_df_sub(thta);
        [f2,df2] = calc_f_df_sub(phi);
        f = f1+f2;
        df = [df1 df2];
end
end
function [f,df] = calc_f_df_sub(thta)
M = length(thta);
e = exp(1j*thta);
L = 2^ceil(log2(2*M-1));
fe = fft(e,L);
x = ifft(abs(fe).^2);
f = x(L:-1:L-M+2);
if nargout>1
%     H = hankel(conj(e(2:M)),[conj(e(M)),zeros(1,M-1)]);
%     df1 = H*diag(1j*e); 
    df = zeros(M-1,M);
    for n = 1:M-1
        df(n,1:M-n) = 1j*e(1:M-n).*conj(e(n+1:M));
        df(n,n+1:M) = df(n,n+1:M)-df(n,1:M-n);
    end
%     T = toeplitz(zeros(M-1,1),[0 e(1:M-1).']);
%     df2 = 1j*(H*diag(e)-T*diag(conj(e)));
    return
else
    df = [];
end
end