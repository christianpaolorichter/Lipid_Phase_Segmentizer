function UI = generate_information_dialog(title,string,varargin)
% GENERATE_INFORMATION_DIALOG Creates a customizable information dialog box (similar to msgbox).
%
%   UI = generate_information_dialog(title, string, varargin)
%
%   Inputs:
%       title:  The title string for the dialog box window.
%       string: The message to display. Can be a single string or a cell
%               array of strings for multi-line display.
%       varargin: Optional parameter/value pairs to customize appearance and behavior:
%               'FontUnits', 'FontName', 'FontAngle', 'FontSize', 'FontWeight' (for text)
%               'IsModal': If true (default), the window is modal (blocks other windows).
%               'PauseQueue': If true (default), pauses execution until the window is closed.
%               'ShowButton': If true (default), displays the 'OK' button.
%
%   Output:
%       UI:     A structure containing handles and layout parameters, notably
%               UI.hFig for the figure handle.
%
%   Copyright (c) 2025 Christian Paolo Richter

% Define default UI layout parameters
UI = struct(...
    'Margin',30,... %[px] Margin around text area
    'ButtonBarHeight', 100,... %[px] Height allocated for the button bar at the bottom
    'ButtonWidth', 200,... % Default width for the button
    'ButtonHeight', 50,... % Default height for the button
    'IconSize',100,... %[px] Width allocated for the icon display area
    'FontUnits','points',... % Default font units
    'FontName','FixedWidth',... % Default font name
    'FontAngle','normal',... % Default font angle
    'FontSize',20,... % Default font size
    'FontWeight','normal'); % Default font weight

% Initialize input parser to handle optional arguments
objInputParser = inputParser;

% Define parameter/value pairs for input parsing
addParamValue(objInputParser,...
    'FontUnits', UI.FontUnits, @(x)isnumeric(x));
addParamValue(objInputParser,...
    'FontName', UI.FontName, @(x)ischar(x));
addParamValue(objInputParser,...
    'FontAngle', UI.FontAngle, @(x)ischar(x));
addParamValue(objInputParser,...
    'FontSize', UI.FontSize, @(x)isnumeric(x));
addParamValue(objInputParser,...
    'FontWeight', UI.FontWeight, @(x)ischar(x));
addParamValue(objInputParser,...
    'IsModal', true, @(x)islogical(x)); % Controls if window is modal
addParamValue(objInputParser,...
    'PauseQueue', true, @(x)islogical(x)); % Controls if function execution pauses
addParamValue(objInputParser,...
    'ShowButton', true, @(x)islogical(x)); % Controls visibility of the 'OK' button

% Parse the input arguments
parse(objInputParser,varargin{:});
inputs = objInputParser.Results;

% Adjust button bar size if the button is hidden
if not(inputs.ShowButton)
    UI.ButtonHeight = 0;
    UI.ButtonBarHeight = 0;
end %if

% Calculate the required dimensions (width and height) for the text string(s)
if iscell(string)
    % Handle multi-line string (cell array)
    numString = numel(string);
    [stringWidth,stringHeight] = deal(zeros(numString,1));
    for idxString = 1:numString
        % Assuming get_text_extent is an external function to calculate text size
        [stringWidth(idxString),stringHeight(idxString)] = ...
            get_text_extent(string{idxString},varargin{:});
    end %for
else
    % Handle single-line string
    numString = 1;
    % Assuming get_text_extent is an external function to calculate text size
    [stringWidth,stringHeight] = ...
        get_text_extent(string,varargin{:});
end %for

% Get screen size for centering the figure
scrSize = get(0, 'ScreenSize');

%             if max(stringExtent) > scrSize(3)
%                 %cut string - (Commented out block for potential future string cutting logic)
%             end %if

% Determine the required size of the display area (axes) for the text
axWidth = max(stringWidth)+2*UI.Margin;
% Determine the total figure width (Text Area + Icon Area)
figWidth = axWidth+UI.IconSize;
% Determine the required height of the display area (axes) for the text
axHeight = sum(stringHeight)+2*UI.Margin;
% Determine the total figure height (Text Area + Button Bar Area)
figHeight = axHeight+UI.ButtonBarHeight;

% Create the main figure (dialog box)
UI.hFig =...
    figure(...
    'Units','pixels',...
    'Position',[0.5*(scrSize(3)-figWidth),0.5*(scrSize(4)-figHeight),figWidth,figHeight],... % Centered position
    'Name', title,... % Set window title
    'NumberTitle', 'off',... % Hide figure number
    'MenuBar', 'none',... % Hide menu bar
    'ToolBar', 'none',... % Hide tool bar
    'DockControls', 'off',... % Disable docking
    'Resize', 'off',... % Disable resizing
    'IntegerHandle','off',... % Use floating point handle
    'Color', [1 1 1],... % White background
    'Visible','off'); % Keep hidden until fully configured

% Set window style to modal if requested
if inputs.IsModal
    set(UI.hFig,...
        'WindowStyle','modal')
end %if

% Create the axes for displaying the text message
hAx = axes(...
    'Parent',UI.hFig,...
    'Units','pixels',...
    'Position',[UI.Margin+UI.IconSize+1,UI.ButtonBarHeight+1,... % Positioned next to the icon, above the button bar
    axWidth,axHeight],...
    'Visible','off'); % Make axes invisible, only text children will show

% Calculate vertical starting positions (y0) for each line of text
y0 = linspace(0,axHeight,numString+2);
y0 = y0(end-1:-1:2); % Calculate vertical positions centered in the available height

% Add each line of text to the message axes
for idxString = 1:numString
    % Check if string is a cell array (multi-line) or single string
    current_string = string;
    if iscell(string)
        current_string = string{idxString};
    end

    text(0,y0(idxString),...
        current_string,...
        'Parent',hAx,...
        'Units','pixels',...
        'HorizontalAlignment','left',...
        'VerticalAlignment','middle',...
        'FontUnits',inputs.FontUnits,...
        'FontName',inputs.FontName,...
        'FontAngle',inputs.FontAngle,...
        'FontSize',inputs.FontSize,...
        'FontWeight',inputs.FontWeight,...
        'Margin',2)
end %for

% Create the axes for displaying the icon
hAx = axes(...
    'Parent',UI.hFig,...
    'Units','pixels',...
    'Position',[1,UI.ButtonBarHeight+1,UI.IconSize,axHeight],... % Positioned on the left side
    'Visible','off'); % Make axes invisible

% Load and display the icon (assuming 'dialogicons.mat' contains the icon data)
icon = load('dialogicons.mat');
imshow(icon.lightbulbIconData,icon.lightbulbIconMap,'Parent',hAx) % Display 'lightbulb' icon

% Create the 'OK' button if requested
if inputs.ShowButton
    uicontrol(...
        'Parent', UI.hFig,...
        'Style', 'pushbutton',...
        'Units','pixels',...
        'Position', [figWidth-UI.ButtonWidth-UI.Margin,... % Right-aligned button
        (UI.ButtonBarHeight-UI.ButtonHeight)/2,... % Vertically centered in button bar
        UI.ButtonWidth,UI.ButtonHeight],...
        'FontUnits',inputs.FontUnits,...
        'FontName',inputs.FontName,...
        'FontAngle',inputs.FontAngle,...
        'FontSize',inputs.FontSize,...
        'FontWeight',inputs.FontWeight,...
        'String', 'OK',...
        'Callback','close(gcf)'); % Closes the figure when pressed
end %if

% Make the figure visible
set(UI.hFig,...
    'Visible','on');
drawnow expose % Force immediate rendering of the figure

% Pause execution if requested, waiting for the figure to be closed
if inputs.PauseQueue
    uiwait(UI.hFig)
end %if

end %fun