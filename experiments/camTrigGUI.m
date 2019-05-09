function camTrigGUI

% Reset DAQ in case it is still in use
initializeDAQ_widefield;

global obj
obj = drawGUIfig;

end

% =========================================================================
%% callbacks

function shutter_callback(~,event)
global obj
if get(obj.shutter,'value') == true
    set(obj.shutter,'string','close shutter','foregroundcolor','r')
    nidaqPulse3('on')
else
    set(obj.shutter,'string','open shutter','foregroundcolor','k')
    nidaqPulse3('off')
end
end

function cam_callback(~,event)
global obj
if get(obj.cam,'value') == true
    nidaqPulse2('ttl',200)
end
end

function daqreset_callback(~,event)
global obj
if get(obj.daqreset,'value') == true
    initializeDAQ_widefield;
end
end

function quit_callback(~,event)
global obj
if get(obj.quit,'value') == true
    terminateDAQ_widefield
    close(obj.guifig)
end
end

% =========================================================================
%% DRAW GUI OBJECT
function obj = drawGUIfig


% create GUI figure
ss = get(groot,'screensize');
ss = ss(3:4);
obj.guifig    =   figure    ('Name',            'wide field',     ...
                          'NumberTitle',        'off',                      ...
                          'Position',           round([ss(1)*.8 ss(2)*.8 ss(1)*.15 ss(2)*.10]));

% -------------------------------------------------------------------------
%% general control buttons
% -------------------------------------------------------------------------                      
obj.shutter =   uicontrol   ('Parent',          obj.guifig,         ...
                        'Style',                'togglebutton',     ...
                        'String',               'open shutter',     ...
                        'Units',                'normalized',       ...
                        'Position',             [.05 .52 .40 .46],  ...
                        'horizontalAlignment',  'center',           ...
                        'foregroundColor',      'k',                ...
                        'fontweight',           'bold',             ...
                        'fontsize',             13,                 ...
                        'Callback',             @shutter_callback);
obj.cam =   uicontrol   ('Parent',              obj.guifig,         ...
                        'Style',                'pushbutton',       ...
                        'String',               'start cam',        ...
                        'Units',                'normalized',       ...
                        'Position',             [.50 .52 .40 .46],  ...
                        'horizontalAlignment',  'center',           ...
                        'foregroundColor',      'k',                ...
                        'fontweight',           'bold',             ...
                        'fontsize',             13,                 ...
                        'Callback',             @cam_callback);
obj.daqreset =   uicontrol   ('Parent',          obj.guifig,        ...
                        'Style',                'pushbutton',       ...
                        'String',               'reset DAQ',        ...
                        'Units',                'normalized',       ...
                        'Position',             [.05 .02 .40 .46],  ...
                        'horizontalAlignment',  'center',           ...
                        'foregroundColor',      [0 .5 0],           ...
                        'fontweight',           'bold',             ...
                        'fontsize',             13,                 ...
                        'Callback',             @daqreset_callback);
obj.quit =   uicontrol   ('Parent',              obj.guifig,        ...
                        'Style',                'pushbutton',       ...
                        'String',               'quit',             ...
                        'Units',                'normalized',       ...
                        'Position',             [.50 .02 .40 .46],  ...
                        'horizontalAlignment',  'center',           ...
                        'foregroundColor',      'r',                ...
                        'fontweight',           'bold',             ...
                        'fontsize',             13,                 ...
                        'Callback',             @quit_callback);
                    
end