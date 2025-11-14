function RGB = IMG_to_RGB(R,G,B,I)
% IMG_TO_RGB Creates an RGB color image from one or more input channel matrices (R, G, B, I).
%
%   RGB = IMG_to_RGB(R, G, B, I)
%
%   This function takes up to four input matrices representing Red, Green, Blue,
%   and Intensity/Gray components, normalizes them, and combines them into an
%   RGB image array. If Intensity (I) is provided, it is blended with the
%   existing RGB channels.
%
%   Inputs:
%       R: Red channel matrix (or empty []).
%       G: Green channel matrix (or empty []).
%       B: Blue channel matrix (or empty []).
%       I: Intensity/Gray channel matrix (or empty []).
%
%   Output:
%       RGB: A [Height x Width x 3] array representing the resulting RGB image,
%            with values typically normalized between 0 and 1.
%
%   Copyright (c) 2025 Christian Paolo Richter

% Determine the common size (Height x Width) of the input image(s).
% The code assumes all provided non-empty matrices have the same dimensions.
[imgHeight,imgWidth] = deal(0); % Initialize size variables

if not(isempty(R))
    [imgHeight,imgWidth] = size(R); % Get size from Red channel
end %if

if not(isempty(G))
    % If G is not empty, it updates the size, assuming it matches R's size
    [imgHeight,imgWidth] = size(G); 
end %if

if not(isempty(B))
    % If B is not empty, it updates the size
    [imgHeight,imgWidth] = size(B);
end %if

if not(isempty(I))
    % If I is not empty, it updates the size
    [imgHeight,imgWidth] = size(I);
end %if

% Initialize the output RGB image array (Height x Width x 3) with zeros
RGB = zeros(imgHeight,imgWidth,3);

% --- Channel Assignment and Normalization ---
if not(isempty(R))
    % Normalize Red channel and assign it to the 1st plane (R)
    RGB(:,:,1) = norm2quantile(R,[0 1]);
end %if

if not(isempty(G))
    % Normalize Green channel and assign it to the 2nd plane (G)
    RGB(:,:,2) = norm2quantile(G,[0 1]);
end %if

if not(isempty(B))
    % Normalize Blue channel and assign it to the 3rd plane (B)
    RGB(:,:,3) = norm2quantile(B,[0 1]);
end %if

% --- Intensity Channel Blending ---
if not(isempty(I))
    % Normalize the Intensity channel
    RGB_ = norm2quantile(I,[0 1]);
    
    % Blend the intensity channel with the existing RGB image.
    % The result is a 50/50 blend: 0.5 * (current RGB) + 0.5 * (Intensity channel replicated across 3 planes)
    RGB = 0.5*RGB+0.5*repmat(RGB_,[1,1,3]);
end %if

end %fun