function q = nanquantile(X,Q)
% NANQUANTILE Calculates the quantile(s) of a data array X, ignoring any NaN values.
%
%   q = nanquantile(X, Q)
%
%   This function serves as a wrapper for the standard MATLAB `quantile`
%   function but explicitly handles NaN (Not-a-Number) values.
%
%   Inputs:
%       X: The input data array (vector or matrix) which may contain NaN values.
%       Q: The quantile probabilities, a scalar or vector between 0 and 1 (e.g., [0.05 0.95]).
%
%   Output:
%       q: The calculated quantile value(s) corresponding to Q.
%
%   Copyright (c) 2015-2025 Christian Paolo Richter
%   University of Osnabrueck
%
%   modified 18.11.2015

% Determine which elements in X are NaN
isNaN = isnan(X);

% Check if any NaN values exist in the array
if any(isNaN(:))
    % If NaNs are present:
    % 1. Filter out NaN values using logical indexing (X(not(isNaN))).
    % 2. Calculate the quantile(s) using the standard `quantile` function on the remaining valid data.
    q = quantile(X(not(isNaN)),Q);
else
    % If no NaNs are present:
    % 1. Flatten the array X into a vector X(:).
    % 2. Convert the data to double precision (ensuring compatibility and preventing issues with integer types).
    % 3. Calculate the quantile(s) directly.
    q = quantile(double(X(:)),Q);
end %if

end %fun