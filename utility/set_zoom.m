function set_zoom(src,varargin)
% SET_ZOOM Toggles the zoom mode on a figure and configures its motion and behavior.
%
%   set_zoom(src, varargin)
%
%   This function is typically used as a callback for a toggle button
%   (like a push tool in a figure toolbar) to enable or disable interactive zooming.
%
%   Inputs:
%       src:      Handle to the object (e.g., uitoggletool) that triggered the
%                 function. Its 'State' property ('on'/'off') determines the action.
%       varargin: Optional parameter/value pairs:
%                 'hFig':             The handle of the figure to apply zooming to (default: gcf).
%                 'Direction':        The motion constraint for zooming ('horizontal', 'vertical', or 'both') (default: 'both').
%                 'RightClickAction': The action performed on a right-click
%                                     ('InverseZoom' (default), 'PostContextMenu').
%
%   Copyright (c) 2025 Christian Paolo Richter

% --- Input Validation and Parsing ---
objInputParser = inputParser;
addParamValue(objInputParser,...
    'hFig', gcf, @(x)ishandle(x)); % Figure handle to target
addParamValue(objInputParser,...
    'Direction', 'both', @(x)ischar(x)); % Zoom motion constraint
addParamValue(objInputParser,...
    'RightClickAction', 'InverseZoom', @(x)ischar(x)); % Action on right-click
parse(objInputParser,varargin{:});
inputs = objInputParser.Results;

% Get the zoom object handle associated with the target figure
hZoom = zoom(inputs.hFig);

% --- Action based on the source object's State ---
switch get(src,'State')
    case 'on'
        % If the zoom button is turned ON, disable conflicting tools (Pan and Rotate).

        % Find all objects with Tag 'Pan' or 'Rotate' in the same parent (toolbar)
        set(findobj(get(src,'Parent'),...
            'Tag','Pan','-or','Tag','Rotate'),...
            'State','off') % Set their state to 'off'

        % Enable and configure the zoom object
        set(hZoom,...
            'Enable','on',... % Turn zoom mode ON
            'Motion', inputs.Direction,... % Set the motion constraint (e.g., 'both')
            'RightClickAction', inputs.RightClickAction) % Configure right-click behavior

    case 'off'
        % If the zoom button is turned OFF, disable the zoom object.
        set(hZoom,...
            'Enable','off') % Turn zoom mode OFF
end %switch

end %fun