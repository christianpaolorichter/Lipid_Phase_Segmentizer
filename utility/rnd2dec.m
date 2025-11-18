function x = rnd2dec(x,i,mode)
%RND2DEC Rounds a number X to a specified number of decimal places I.
%
%   X = RND2DEC(X, I) rounds the number X to I decimal places using the
%   standard **round-half-up** method (standard 'round' function).
%
%   X = RND2DEC(X, I, MODE) allows specifying a different rounding method:
%       - 'floor': Rounds towards negative infinity.
%       - 'ceil': Rounds towards positive infinity.
%
%   Inputs:
%       x (numeric): The number or array of numbers to be rounded.
%       i (integer): The number of decimal places to round to.
%       mode (string, optional): The rounding method ('floor' or 'ceil').
%
%   Output:
%       x (numeric): The rounded number or array.
%
%   Copyright (c) 2025 Christian Paolo Richter

% Calculate the scaling factor 'k' based on the requested number of decimal
% places 'i'. E.g., if i=2 (two decimal places), k = 10^2 = 100.
k = 10^i;

% Check the number of input arguments (nargin).
% If nargin == 2, the optional 'mode' argument was not provided.
if nargin == 2
    % Standard rounding: Multiply by the scaling factor 'k', apply the
    % standard 'round' function, and then divide by 'k' to revert the scale.
    x = round(x*k)/k;
else
    % If nargin > 2 (i.e., nargin == 3), the optional 'mode' argument was provided.
    switch mode
        % Check if the requested rounding mode is 'floor'.
        case 'floor'
            % Round towards negative infinity: Multiply by 'k', apply 'floor',
            % and then divide by 'k'.
            x = floor(x*k)/k;
        % Check if the requested rounding mode is 'ceil'.
        case 'ceil'
            % Round towards positive infinity: Multiply by 'k', apply 'ceil',
            % and then divide by 'k'.
            x = ceil(x*k)/k;
    end %switch
end %if
end %fun