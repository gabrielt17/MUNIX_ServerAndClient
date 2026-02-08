function rCameraSetup(MX, Address, Port)
%% Sets up an IPV4 (and port, optionally) address for usage in other }
%% camera methods.
% Expects at least an IPV4 address argument inserted as string.
% Uses IPCAM toolbox

address = "";
port = 8554;

% If the user doesn't pass arguments, this will catch it
switch (nargin)
    case 1
        error("Not enough arguments. Please provide an IPV4 address.");
    case 2
        
        if ischar(Address) || isstring(Address)
            address = string(Address);
        else
            error('Please provide a valid IPV4 (String or Char).');
        end
    case 3
        if ischar(Address) || isstring(Address)
            address = string(Address);
        else
            error('Please provide a valid IPV4 (String or Char).');
        end

        if isnumeric(Port)
            port = Port;
        else
            error('Please provide a valid numeric port.');
        end
end

% Defines the parameters
MX.pCAM.Address = address;
MX.pCAM.Port = port;
MX.pCAM.URL = "rtsp://" + address + ":" + num2str(port) + "/test";

fprintf('Setting address as ' + MX.pCAM.URL + '.\n');

MX.pCAM.Cam = ipcam(MX.pCAM.URL);

MX.pFlag.CamConnected = 1;
end