function iControlVariables(MX)
%% Munix's control variables

% Raw data
MX.pSC.PWM = zeros(2,1);
MX.pSC.RPM = zeros(2,1);

% ========================================================================
% Robot pose
MX.pPos.X    = zeros(12,1); % Current pose (point of control)
MX.pPos.Xa   = zeros(12,1); % Past pose

MX.pPos.Xc   = zeros(12,1); % Current pose (center of the robot)
MX.pPos.Xp   = zeros(12,1); % Current pose (computed by the robot)

MX.pPos.Xd   = zeros(12,1); % Desired pose
MX.pPos.Xda  = zeros(12,1); % Past desired pose

MX.pPos.Xr   = zeros(12,1); % Reference pose
MX.pPos.Xra  = zeros(12,1); % Past reference pose

% First time derivative 
MX.pPos.dX   = zeros(12,1); % Current pose
MX.pPos.dXd  = zeros(12,1); % Desired pose
MX.pPos.dXr  = zeros(12,1); % Reference pose

% Pose error
MX.pPos.Xtil = MX.pPos.Xd - MX.pPos.X;

% ========================================================================
% Sensor data
MX.pPos.Xso  = zeros(12,1); % Initial sensor data
MX.pPos.Xs   = zeros(12,1); % Current sensor data
MX.pPos.Xsa  = zeros(12,1); % Past sensor data
MX.pPos.dXs  = zeros(12,1); % First time derivative of sensor data

% Sensorial fusion data
MX.pPos.Xf   = zeros(12,1);

% GPS data: Latitude, Longitude e Altitude
MX.pPos.Xg  = zeros(3,1);

% ========================================================================
% Signals of Control 
% Linear and Angular Velocity
MX.pSC.U   = [0;0]; % Current
MX.pSC.Ua  = [0;0]; % Past
MX.pSC.Ud  = [0;0]; % Desired
MX.pSC.Uda = [0;0]; % Past desired
MX.pSC.Ur  = [0;0]; % Reference
MX.pSC.Kinematics_control = 0;

% Linear and Angular Acceleration
MX.pSC.dU   = [0;0]; % Current
MX.pSC.dUd  = [0;0]; % Desired