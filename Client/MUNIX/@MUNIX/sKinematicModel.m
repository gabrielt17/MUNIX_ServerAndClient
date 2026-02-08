function sKinematicModel(mnx)

% Determine the robot pose, based on the control signal
%      +-----------+      .
% U -> | Kinematic |  ->  X
%      | Model     |      
%      +-----------+      
%

K = [cos(mnx.pPos.X(6)) -mnx.pPar.a*sin(mnx.pPos.X(6)+mnx.pPar.alpha); ...
     sin(mnx.pPos.X(6))  mnx.pPar.a*cos(mnx.pPos.X(6)+mnx.pPar.alpha); ...
             0                             1                   ];

% Current position
mnx.pPos.X([1 2 6]) = mnx.pPos.X([1 2 6]) + K*mnx.pSC.U(1:2)*mnx.pPar.Ts;

% first-time derivative of the current position
mnx.pPos.X([7 8 12]) = K*mnx.pSC.U(1:2);

% Angle limitation per quadrant
for ii = 4:6
    if abs(mnx.pPos.X(ii)) > pi
        if mnx.pPos.X(ii) < 0
            mnx.pPos.X(ii) = mnx.pPos.X(ii) + 2*pi;
        else
            mnx.pPos.X(ii) = mnx.pPos.X(ii) - 2*pi;
        end
    end
end

% Pose of the robot's center
mnx.pPos.Xc([1 2 6]) = mnx.pPos.X([1 2 6]) - ...
    [cos(mnx.pPos.X(6)) -sin(mnx.pPos.X(6)) 0; sin(mnx.pPos.X(6)) cos(mnx.pPos.X(6)) 0; 0 0 1]*...
    [mnx.pPar.a*cos(mnx.pPar.alpha); mnx.pPar.a*sin(mnx.pPar.alpha); 0];