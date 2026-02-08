function rSetPose(MX,Xo)
if nargin > 1
    MX.pPos.Xc([1 2 3 6]) = Xo;
end

MX.pCAD.scale = 0.01;
MX.pCAD.obj{1}.v = MX.pCAD.obj{1}.v*MX.pCAD.scale;

MX.pPos.X([1 2 3 6]) = MX.pPos.Xc([1 2 3 6]) + ...
    [cos(MX.pPos.X(6)) -sin(MX.pPos.X(6)) 0 0; sin(MX.pPos.X(6)) cos(MX.pPos.X(6)) 0 0; 0 0 1 0; 0 0 0 1]*...
    [MX.pPar.a*cos(MX.pPar.alpha); MX.pPar.a*sin(MX.pPar.alpha); 0; 0];

MX.pPos.Xa = MX.pPos.X;

if MX.pFlags.Connected
    % The position is given in milimetes and
    % the heading in degrees
    arrobot_setpose(MX.pPos.Xc(1)*1000,MX.pPos.Xc(2)*1000,MX.pPos.Xc(6)*180/pi);
end