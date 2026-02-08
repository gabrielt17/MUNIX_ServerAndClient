function mnx = cMUNIX_KinematicController(mnx,pgains)

    % Control gains
    % pgains = [1.5 1 1.5 1]; % Ganhos Daniel

    if nargin < 2

    pgains = [0.35 0.35 0.4 0.4];

    end 

    Kp1 = diag([pgains(1), pgains(2)]);
    Kp2 = diag([pgains(3), pgains(4)]);

    pPar.a = 0.1;

    K = [ cos(mnx.pPos.X(6)), -pPar.a*sin(mnx.pPos.X(6)); ...
          sin(mnx.pPos.X(6)), +pPar.a*cos(mnx.pPos.X(6))];

    mnx.pPos.Xtil = mnx.pPos.Xd - mnx.pPos.X;

    mnx.pSC.Ur = K\(mnx.pPos.Xd(7:8) + Kp1*tanh(Kp2*mnx.pPos.Xtil(1:2)));

    % Saturação do sinal de controle, baseado na folha de dados do Pioneer 3DX
    if abs(mnx.pSC.Ur(1)) > 0.75
        mnx.pSC.Ur(1) = sign(mnx.pSC.Ur(1))*0.75;
    end
    if abs(mnx.pSC.Ur(2)) > 1
        mnx.pSC.Ur(2) = sign(mnx.pSC.Ur(2))*1;
    end

    mnx.pSC.Ud = mnx.pSC.Ur;

end