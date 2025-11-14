function set_pan(src,varargin)
% SET_PAN Toggles the pan mode on a figure and configures its motion and UI.
%
%   set_pan(src, varargin)
%
%   This function is typically used as a callback for a toggle button
%   (like a push tool in a figure toolbar) to enable or disable interactive panning.
%
%   Inputs:
%       src:      Handle to the object (e.g., uicontrol or uitoggletool) that
%                 triggered the function. Its 'State' property ('on'/'off')
%                 determines the action.
%       varargin: Optional parameter/value pairs:
%                 'hFig':      The handle of the figure to apply panning to (default: gcf).
%                 'Direction': The motion constraint for panning ('horizontal', 'vertical', or 'both') (default: 'both').
%
%   Copyright (c) 2025 Christian Paolo Richter

% --- Input Validation and Parsing ---
objInputParser = inputParser;
addParamValue(objInputParser,...
    'hFig', gcf, @(x)ishandle(x)); % Figure handle to target
addParamValue(objInputParser,...
    'Direction', 'both', @(x)ischar(x)); % Panning motion constraint
parse(objInputParser,varargin{:});
inputs = objInputParser.Results;

% Get the pan object handle associated with the target figure
hPan = pan(inputs.hFig);

% --- Action based on the source object's State ---
switch get(src,'State')
    case 'on'
        % If the pan button is turned ON, disable conflicting tools (Zoom and Rotate).
        
        % Find all objects with Tag 'Zoom' or 'Rotate' in the same parent (toolbar)
        set(findobj(get(src,'Parent'),...
            'Tag','Zoom','-or','Tag','Rotate'),...
            'State','off') % Set their state to 'off'
        
        % Enable and configure the pan object
        set(hPan,...
            'Enable','on',... % Turn pan mode ON
            'Motion', inputs.Direction,... % Set the motion constraint (e.g., 'both')
            'UIContextMenu',[]) % Clear any context menu for a clean interaction
        
    case 'off'
        % If the pan button is turned OFF, disable the pan object.
        set(hPan,...
            'Enable','off') % Turn pan mode OFF
end %switch

end %fun