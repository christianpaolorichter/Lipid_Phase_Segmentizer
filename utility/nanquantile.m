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

% Identify which elements in the input data array X are 'Not a Number' (NaN).
isNaN = isnan(X);

% Check if ALL elements in the entire array X are NaN.
if all(isNaN(:))
    % If all elements are NaN, the quantile cannot be calculated from data.
    % The output 'q' is set based on the dimensionality of the requested
    % probabilities Q, often returning 'inf' or an empty array as a defined
    % failure condition when no valid data exists.

    % Check if Q is a single scalar probability (e.g., 0.5 for median).
    if isscalar(Q)
        % Set the result to 'inf' (infinity) for a single quantile request.
        q = inf;
    % Check if Q contains exactly two probability values.
    elseif numel(Q) == 2
        % Set the result to [-inf, inf] for a two-element quantile request
        % (e.g., perhaps minimum and maximum, or 0 and 1 quantiles).
        q = [-inf,inf];
    % If Q is neither a scalar nor a two-element array (e.g., empty or >2 elements).
    else
        % Set the result to an empty array.
        q = [];
    end %if

% Check if ANY elements in the array X are NaN (but not all of them, as handled above).
elseif any(isNaN(:))
    % This block executes if there is a mix of valid numbers and NaNs.

    % 1. X(not(isNaN)) extracts all elements from X that are NOT NaN (the valid data).
    % 2. The standard 'quantile' function is then called on this filtered
    %    subset of valid data using the specified probabilities Q.
    q = quantile(X(not(isNaN)),Q);

% This block executes if NONE of the elements in the array X are NaN.
else
    % No NaN values are present, so the standard quantile calculation can be used
    % on the entire dataset.

    % 1. double(X(:)) ensures the input is a column vector of type double
    %    (quantile usually operates on columns/vectors and often benefits from
    %    double precision). X(:) flattens X into a column vector.
    % 2. The standard 'quantile' function is called.
    q = quantile(double(X(:)),Q);
end %if
end %fun