Lipid Phase Segmentation Tool
==========

This tool is a GUI-based application implemented in MATLAB, designed for processing microscopy images. It sharpens images using frequency-domain deconvolution and then segments them based on multi-level thresholding to identify and mask distinct lipid phases (e.g., Liquid-ordered, $L_o$, and Liquid-disordered, $L_d$).

## Installation and Setup
### Prerequisites

1.  **MATLAB** installation (tested with 2024a).
2.  MATLAB's **Image Processing Toolbox** (required for `imresize`, `fspecial`, `multithresh`, `imquantize`, `bwpmorph`, etc.).

### Cloning the Repository

To get started, clone the repository to your local machine using Git Bash:

```bash
git clone git@github.com:christianpaolorichter/Lipid_Phase_Segmentizer.git
```

or using direct download:

1.  **Download ZIP:** Navigate to the repository page on GitHub. Click the **green `<> Code`** button and select **"Download ZIP."**
2.  **Unzip:** Extract the contents of the downloaded ZIP file to your desired project location (e.g., your MATLAB projects folder).

Then, add the main directory and all subfolders to your MATLAB environment:

```Matlab
% Run this command in MATLAB after cloning:
addpath(genpath('/path/to/Lipid_Phase_Segmentizer/'));
```

## Getting Started: GUI Workflow

This tool is designed to be run as a GUI. Launch the main application script (`LipidPhaseSegmentizer.m`) to open the interface.

<p align="center">
  <img src="https://github.com/christianpaolorichter/Lipid_Phase_Segmentizer/blob/main/GUI.png?raw=true" alt=""/>
</p>

The typical workflow is as follows:
1. Load Image: Load your source microscopy image (tif-file).
2. Deconvolve Image:
* Adjust the Point Spread Function (PSF) Width slider. This sets the standard deviation of the Gaussian PSF used for sharpening.
* Adjust the Regularization slider. This is the gamma parameter ($10^{\text{Gamma}}$) for the Tikhonov deconvolution.
3. Phase Segmentation:
4. Export: Click the "Export Mask" button. This will open a dialog to select a save location. 

The export saves the following three files in a new subfolder named Lipid Phase Segmentation:
* Lo-Phase Mask.tif: A binary mask of the $L_o$ phase.
* Ld-Phase Mask.tif: A binary mask of the $L_d$ phase.
* Lipid Phase Deconvolution.tif: A 8-bit, normalized ([0 255]) deconvolved image that was used for the segmentation.

## Performance Evaluation 

<p align="center">
  <img src="https://github.com/christianpaolorichter/Lipid_Phase_Segmentizer/blob/main/evaluation/ground_truth.png?raw=true" alt=""/>
</p>

<p align="center">
  <img src="https://github.com/christianpaolorichter/Lipid_Phase_Segmentizer/blob/main/evaluation/comparison_classification.png?raw=true" alt=""/>
</p>