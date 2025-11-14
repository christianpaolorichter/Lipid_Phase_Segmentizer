function x = rnd2dec(x,i)
% RND2DEC Rounds a number or array X to a specified number of decimal places I.
%
%   x = rnd2dec(x, i)
%
%   Inputs:
%       x: The input number or array to be rounded.
%       i: The number of decimal places (integer) to round to.
%
%   Output:
%       x: The result of rounding the input X to I decimal places.
%
%   Algorithm:
%   This function implements standard rounding (round half up) by scaling the
%   number up, applying the standard `round` function, and then scaling it back down.
%
%   Copyright (c) 2025 Christian Paolo Richter

% Calculate the scaling factor (k), which is 10 raised to the power of i.
% Example: if i=2, k=100.
k = 10^i;

% Perform the rounding:
% 1. x * k: Scales the number so the desired decimal place is the new ones place.
% 2. round(...): Applies standard rounding to the new integer.
% 3. ... / k: Scales the number back down to its original magnitude.
x = round(x*k)/k;

end %fun