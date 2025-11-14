* MATLAB Lipid Phase Segmentation Tool

==========This tool is a GUI-based application implemented in MATLAB, designed for processing microscopy images. It sharpens images using frequency-domain deconvolution and then segments them based on multi-level thresholding to identify and mask distinct lipid phases (e.g., Liquid-ordered, $L_o$, and Liquid-disordered, $L_d$).

** Installation and Setup
Prerequisites
MATLAB installation (e.g., R2021a or newer).

MATLAB Image Processing Toolbox (required for imresize, fspecial, multithresh, imquantize, bwperim, etc.).

Repository Setup
Download or Clone: Clone this repository or download and extract the ZIP file to your local machine.

Add to MATLAB Path: Add the main directory and all its subfolders (especially the utility-folder) to your MATLAB environment.

´´´Matlab
% Run this command in MATLAB
addpath(genpath('/path/to/Lipid_Phase_Segmentation_Tool/'));
```

Getting Started: GUI Workflow
This tool is designed to be run as a GUI. Launch the main application script (e.g., run_lipid_segmenter.m) to open the interface.