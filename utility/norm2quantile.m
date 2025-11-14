function X = norm2quantile(X,Q)
% NORM2QUANTILE Normalizes input data matrix X based on specified quantile
% limits or performs standard min-max normalization.
%
%   X = norm2quantile(X, Q)
%
%   This function normalizes the matrix X such that its values fall within
%   the range [0, 1]. The method depends on the input argument Q:
%
%   1. Min-Max Normalization: If diff(Q) == 1 (e.g., Q = [0 1]), the data is
%      normalized using the global minimum and maximum of X.
%   2. Quantile Normalization: If Q is a two-element vector defining two
%      quantiles (e.g., Q = [0.05 0.95]), the data is clipped and scaled
%      based on those quantile values.
%
%   Inputs:
%       X: The input data matrix (can be any size).
%       Q: A two-element vector defining the normalization method:
%          - [min_quantile, max_quantile] for quantile normalization.
%          - [0 1] (or any Q where diff(Q) is 1) for min-max normalization.
%
%   Output:
%       X: The normalized output matrix, scaled to [0, 1].
%
%   Copyright (c) 2015-2025 Christian Paolo Richter
%   University of Osnabrueck
%
%   modified 19.11.2015
%   modified 21.11.2016: [0 1] -> min-max-normalization

% Check if the difference between the two elements of Q is 1.
% This condition (e.g., Q = [0 1]) is used as a flag for standard Min-Max normalization.
if diff(Q) == 1
    % --- Standard Min-Max Normalization (Scale based on global min/max) ---
    % Formula: X_norm = (X - min(X)) / (max(X) - min(X))
    X = (X-min(X(:)))/(max(X(:))-min(X(:)));
else
    % --- Quantile-based Normalization ---
    
    % Calculate the quantile limits (lim(1) = lower quantile, lim(2) = upper quantile)
    % nanquantile is used to handle NaN values if they exist, calculating quantiles
    % based on the non-NaN elements.
    lim = nanquantile(X(:),Q);
    
    % Apply normalization and clipping:
    % 1. Scale: (X - lim(1)) / (lim(2) - lim(1)) -> scales data between the limits to [0 1].
    % 2. Clip: max(0, ...) -> ensures values below lim(1) are set to 0.
    % 3. Clip: min(1, ...) -> ensures values above lim(2) are set to 1.
    X = min(1,max(0,(X-lim(1))/(lim(2)-lim(1))));
end %if

end %fun