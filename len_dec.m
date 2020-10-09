% to decompose a number into exponentials of some bases
% input: num is the number to be decomposed
%        type is a required type of golay sequences
% output: expo is a row vector whose elements are exponentials of some bases
% Last modified on Oct. 8, 2020
% Copyright Communication System Research Laboratory, Fudan University

function expo = len_dec(num, type)
init = num;
switch type
    case 'binary'
        base = [26, 10, 2];
    case 'quaternary'
        base = [2, 3, 5, 11, 13];
    otherwise
        error('Binary or quaternary!');
end

for i = 1:length(base)
    [expo{i}, num] = expo_dec(num, base(i));
end

if num ~= 1
    error(sprintf('%d is undecomposable', init));
else
    if strcmp('binary', type)
        expo = flip(expo);
        return
    else
        [a, b, c, d, e] = expo{:};
        uSet = [];
        for u = 0:a
            if u <= c+e && b+c+d+e <= a+u+1
                uSet = [uSet, u];
            end
        end
        if ~isempty(uSet)
            % to choose a feasible u randormly
            uRand = uSet(randperm(length(uSet)));
            u = uRand(1);
            % to decompose u into uc and ue, the exponential of 10 and 26 respectively
            uc = randi([max(u-e, 0), min(u, c)]);
            ue = u - uc;
            a = a-u;
            expo = {a, uc, ue, b, c, d, e};
        else
            error(sprintf('Exponentials are infeasible'));
        end
    end
end

function [expo, num] = expo_dec(num, base)
expo = 0;
while mod(num, base) == 0
    num = num / base;
    expo = expo + 1;
end

            
            
