function rControlSetup(MX, Address, Port)
%% Sets up an IPV4 (and port, optionally) address for usage in 
%% control methods.
% Expects at least an IPV4 address argument inserted as string.

% If the user doesn't pass arguments, this will catch it
if nargin < 2
    error("Not enough arguments. Please provide an IPV4 address.");
end

if ~(ischar(Address) || isstring(Address))
    error('Please provide a valid IPV4 (String or Char).');
end

address = string(Address);
port = 4210; % Default

if nargin == 3
    if isnumeric(Port)
        port = Port;
    else
        error('Please provide a valid numeric port.');
    end
end

% Defines the parameters
MX.pCOM.Address = address;
MX.pCOM.Port = port;

fprintf('Setting address as ' + MX.pCOM.Address + ":" + MX.pCOM.Port + '.\n');

% Creates UDP connection object
MX.pCOM.UDP = udpport('datagram', 'IPV4');

% Clear any object data that's still in memory
flush(MX.pCOM.UDP);

MX.pFlag.Connected = 1;
end