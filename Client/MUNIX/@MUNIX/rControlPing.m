function recv = rControlPing(MX)
%% Pings MUNIX's ESP32
% This connection is made via UDP. By default, it uses port 4210.

ip = MX.pCOM.Address;
port = MX.pCOM.Port;

% Validates the existence of an IP address
if isempty(ip) || (isstring(ip) && ip == "")
    error(['Invalid IP address or not defined. Set an IP using ' ...
        'rConnectionSetup or give it as an argument!']);
end
% --------------------------------

COM = ip + ":" + port;
disp("Pinging to " + COM);

if (MX.pFlag.Connected)
    % Clear any object data that's still in memory
    flush(MX.pCOM.UDP);

    % Sends msg to ESP32
    msg = sprintf('{"cmd":"ping"}');
    write(MX.pCOM.UDP, uint8(msg), "uint8", ip, port);

    % Wait 2 seconds to receive the info
    t_start = tic;
    timeout = 2;
    found = false;

    while toc(t_start) < timeout
        if MX.pCOM.UDP.NumDatagramsAvailable > 0
            found = true;
            break;
        end
    end
    if found
        packet = read(MX.pCOM.UDP, 1);
        answer = char(packet.Data);
        r_json = jsondecode(answer);
        MX.pSC.RPM(1,1) = r_json.rpm;
        recv = true;
    else
        warning("Timed out.");
        recv = false;
    end
end
end
