% to extract an exponential of a given base from a number
% input: num is the given number 
%        base is the given base
% output: expo is the exponential and num is the processed number
% Last modified on Oct. 8, 2020
% Copyright Communication System Research Laboratory, Fudan University
function [expo, num] = expo_dec(num, base)
expo = 0;
while mod(num, base) == 0
    num = num / base;
    expo = expo + 1;
end
