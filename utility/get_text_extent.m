function [width,height] = get_text_extent(string,varargin)
% GET_TEXT_EXTENT Calculates the required pixel dimensions (width and height)
% for a given text string using specified font properties.
%
%   [width, height] = get_text_extent(string, varargin)
%
%   Inputs:
%       string: The text string whose extent is to be measured.
%       varargin: Optional parameter/value pairs to define font properties:
%               'FontUnits', 'FontName', 'FontAngle', 'FontSize', 'FontWeight'.
%
%   Outputs:
%       width:  The required width (in pixels) for the string.
%       height: The required height (in pixels) for the string.
%
%   Copyright (c) 2025 Christian Paolo Richter

% Define default font properties
UI = struct(...
    'FontUnits','points',...
    'FontName','FixedWidth',...
    'FontAngle','normal',...
    'FontSize',20,...
    'FontWeight','normal');

% Initialize input parser to handle optional font arguments
IP = inputParser;
% Allows for arguments not explicitly defined in the input parser to be ignored
IP.KeepUnmatched = true;

% Define expected parameter/value pairs for font properties
addParamValue(IP,...
    'FontUnits', UI.FontUnits, @(x)isnumeric(x));
addParamValue(IP,...
    'FontName', UI.FontName, @(x)ischar(x));
addParamValue(IP,...
    'FontAngle', UI.FontAngle, @(x)ischar(x));
addParamValue(IP,...
    'FontSize', UI.FontSize, @(x)isnumeric(x));
addParamValue(IP,...
    'FontWeight', UI.FontWeight, @(x)ischar(x));

% Parse the input arguments
parse(IP,varargin{:});
inputs = IP.Results;

% Generate a temporary figure (must be 'Visible','on' to calculate extent)
hFig = figure(...
    'Units','pixels',...
    'Visible','on',... % Must be 'on' for extent calculation to work reliably
    'IntegerHandle','off',...
    'HandleVisibility','off',... % Prevent accidental closure via 'close all'
    'MenuBar','none',...
    'ToolBar','none',...
    'WindowStyle','modal',... % Make it less disruptive
    'Position',[1 1 1 1]); % Minimize initial size

% Generate invisible axes
hAx = axes(...
    'Parent',hFig,...
    'Units','pixels',...
    'Visible','off',...
    'Position',[0 0 1 1]); % Small, minimal axes

% Create the text object with the specified font properties
hText = text(0,0,string,...
    'Parent',hAx,...
    'Units','pixels',...
    'FontUnits',inputs.FontUnits,...
    'FontName',inputs.FontName,...
    'FontAngle',inputs.FontAngle,...
    'FontSize',inputs.FontSize,...
    'FontWeight',inputs.FontWeight);

% Retrieve the 'Extent' property [x y width height]
extent = get(hText,'Extent');

% Apply a scaling factor (1.5) to the extent for padding or safety margin
% Note: The extent property often returns a slightly too-small bounding box.
extent = 1.5*extent;

% Extract the calculated width and height
width = extent(3);
height = extent(4);

% Immediately close the temporary figure
close(hFig)

end %fun