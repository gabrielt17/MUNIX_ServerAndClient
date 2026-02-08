function iParameters(MX)
%% Initializes basic structures and parameters

% Camera connection parameters
MX.pCAM.Port = 8554;
MX.pCAM.Address = "";
MX.pCAM.URL = "";
MX.pCAM.Cam = "";

% Control connection parameters
MX.pCOM.Port = 4210;
MX.pCOM.Address = "";
MX.pCOM.UDP = "";

MX.pPar.Model = 'MUNIX'; % robot model

% Sample time
MX.pPar.Ts = 0.1; % For numerical integration
MX.pPar.ti = tic; % Flag time

% Dynamic Model Parameters
MX.pPar.g = 9.8;    % [kg.m/s^2] Gravitational acceleration

% [kg]
MX.pPar.m = 0.429; %0.442;

% [m and rad]
MX.pPar.a = 0.15;  % point of control
MX.pPar.alpha = 0; % angle of control

% [Identified Parameters]
% Reference:
% Martins, F. N., & Brandão, A. S. (2018).
% Motion Control and Velocity-Based Dynamic Compensation for Mobile Robots.
% In Applications of Mobile Robots. IntechOpen.
% DOI: http://dx.doi.org/10.5772/intechopen.79397
MX.pPar.theta = [0.5338; 0.2168; -0.0134; 0.9560; -0.0843; 1.0590];

end
