function rOpenCameraPreview(MX)
%% Opens a preview the TV Box camera.
% It uses the natively IPCAM toolbox from MATLAB to create a preview
% Connection parameters depends on rCameraSetup


if ~isvalid(MX.pCAM.Cam)
    error('Please setup a camera using rCameraSetup.');
end

% Opens camera preview in a figure.
preview(MX.pCAM.Cam);

end