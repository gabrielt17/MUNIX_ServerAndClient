classdef MUNIX < handle
%% A TV-Box based, ESP32 controlled robot.
% Class built following Pioneer3DX AuRoRA's philosophy.
% 
% To setup the class, pass an IPV4 to rControlSetup and rCameraSetup.
% Optionally, you can provide the ports. By default, port 4210 and 5000
% are used to each method, respectively.
% 
% To be able to plot the simulation 3D model, set a initial pose with
% rSetPose.


    properties
        
        % Identity specific
        pID
        
        % Describes robot pose
        pPos
        
        % Holds control signal info
        pSC

        % Communication parameters
        pCOM

        % Flags
        pFlag

        % Munix 3D image
        pCAD

        % Parameters
        pPar

        % Munix Camera
        pCAM

    end
    
    methods

        function MX = MUNIX(ID)
            if nargin < 1
                ID = 1;
            end

            MX.pID = ID;

            % ==================================================
            
            % Initializing essential class atributes (propreties)
            iControlVariables(MX);
            iParameters(MX);
            iFlags(MX);
            mCADload(MX);


                
        end
        
        % ==================================================
        
        % Initializes atributes
        iFlags(MX);
        iParameters(MX);
        
        % ==================================================

        % Sets up the connection parameters
        rControlSetup(MX, Address, Port);

        % Checks connection with MUNIX
        recv = rControlPing(MX);

        % ==================================================
        
        % Sets PWM
        rSendControlSignals(MX);

        % Gets current RPM
        rGetSensorData(MX);

        % ==================================================

        % Sets up the camera connection parameters
        rCameraSetup(MX, address, port);
        
        % Get the current camera image
        img = rGetCameraFrame(MX, doImshow);

        % Opens a video preview of the camera
        rOpenCameraPreview(MX);

        % ==================================================

        % Pioneer 3DX 3D Image
        mCADload(MX);
        mCADmake(MX);
        mCADplot(MX, scale);
        mCADdel(MX);
        mCADplot2D(MX,visible);
        mCADcolor(MX,color);

        % ==================================================

        % Pose definition, based on kinematic or dynamic model
        sKinematicModel(MX);
        sInvKinematicModel(MX,dXr);
        sDynamicModel(MX);

        % ==================================================

        % Robot functions Communication
        rSetPose(MX,Xo);



        
    end
end
