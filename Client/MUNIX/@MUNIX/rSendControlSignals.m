function rSendControlSignals(MX)

if MX.pFlag.Connected == 1
    pwm = MX.pSC.PWM();

    ip = MX.pCOM.Address;
    port = MX.pCOM.Port;

    if (MX.pFlag.Connected)
        % Pings MUNIX
        % Clear any object data that's still in memory
        flush(MX.pCOM.UDP);

        % Sends msg to ESP32
        msg = sprintf('{"cmd":"setPWM","Lval":%d,"Rval":%d}', pwm(1,1), pwm(2,1));
        write(MX.pCOM.UDP, uint8(msg), "uint8", ip, port);
    end

else
    % Simulation Mode
    MX.pSC.U = MX.pSC.Ud;
    MX.sKinematicModel; % MODIFY IT BY THE DYNAMIC MODEL
end


