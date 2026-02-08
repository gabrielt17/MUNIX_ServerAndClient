function rGetSensorData(MX)

% Store past position
MX.pPos.Xa = MX.pPos.X;

if MX.pFlag.Connected == 1
    ip = MX.pCOM.Address;
    port = MX.pCOM.Port;

    if (MX.pFlag.Connected)

        % Clear any object data that's still in memory

        flush(MX.pCOM.UDP);

        % Sends msg to ESP32
        msg = sprintf('{"cmd":"getRPM"}');
        write(MX.pCOM.UDP, uint8(msg), "uint8", ip, port);

        % Wait 15 ms to receive the info
        t_start = tic;
        timeout = 0.05;
        found = false;

        while toc(t_start) < timeout
            if MX.pCOM.UDP.NumDatagramsAvailable > 0
                found = true;
                break;
            end
        end

        % 4. Processa apenas se recebeu
        if found
            packet = read(MX.pCOM.UDP, 1); % Lê o datagrama mais recente
            answer = char(packet.Data);
            r_json = jsondecode(answer);
            MX.pSC.RPM(1,1) = r_json.rpm;
        else
            warning("Timed out.");
        end
    end

else
    % Simulation
    % Robot center position
    MX.pPos.Xc([1 2 6]) = MX.pPos.X([1 2 6]) - [MX.pPar.a*cos(MX.pPos.X(6)); MX.pPar.a*sin(MX.pPos.X(6)); 0];
end