% Copyright (c) 2020 Key Laboratory for Information Science of Electromagnetic Waves (MoE),
% Department of Communication Science and Engineering, Fudan University, Shanghai, China
function [expo, num] = expo_dec(num, base)
expo = 0;
while mod(num, base) == 0
    num = num / base;
    expo = expo + 1;
end
