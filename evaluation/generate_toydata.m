% --- Toy Data Generation Script for Lipid Phase Segmentation ---
%
% This script creates synthetic image data to simulate a two-phase lipid
% membrane (Liquid-Ordered/Lo and Liquid-Disordered/Ld). The process involves
% creating a random binary mask, smoothing it morphologically to simulate
% phase separation, and then blurring it with a Gaussian kernel to mimic
% microscope optics (PSF).
%
%   Copyright (c) 2025 Christian Paolo Richter

% --- 1. Initialization and Initial Random Mask ---
numPx = 100; % Define the size of the square image (e.g., 100x100 pixels).

% Generate an initial chaotic binary mask (50% 0s and 50% 1s).
% 0 and 1 represent the two initial lipid phases.
mask = rand(numPx,numPx) > 0.5;
maskIn = mask; % Initialize the mask used for iterative smoothing.

% --- 2. Iterative Morphological Smoothing (Simulating Phase Coarsening) ---
% The loop applies the 'majority' operation repeatedly until the mask stops
% changing, stabilizing the phase boundaries and removing small, isolated pixels.
while 1
    % bwmorph(..., "majority"): Sets a pixel to 1 if five or more of its
    % eight neighbors are 1 (standard 3x3 neighborhood). This operation
    % promotes smoothing and coarsening of the regions.
    maskOut = bwmorph(maskIn,"majority");

    % Check if the mask changed compared to the previous iteration.
    if any(maskIn(:)-maskOut(:))
        maskIn = maskOut; % Update for the next iteration.
    else
        break % Exit loop once the mask is stable (equilibrium reached).
    end %if
end

% Save the final, smoothed binary mask. This serves as the ground truth
% for the segmentation task.
imwrite(maskOut,'path\to\toydata_binary_mask.tif')

% --- 3. Convolve with Gaussian (Simulating Microscope Blur/PSF) ---
% The smoothed binary mask is convolved with a Gaussian filter to simulate
% the Point Spread Function (PSF) of a microscope, introducing realistic
% blur and intensity gradients at the phase boundaries.
% Standard deviation (sigma) of the Gaussian kernel is set to 2 pixels.
img = imgaussfilt(double(maskOut),2);

% Save the resulting blurred image. This is the synthetic "raw" input data
% that the LipidPhaseSegmentizer would typically process.
imwrite(img,'path\to\toydata_blurred.tif')