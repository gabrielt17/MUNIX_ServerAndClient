function img = rGetCameraFrame(MX, doImshow)
%% Get a single frame from Munix's TV-Box USB camera.
% Connection parameters depends on rCameraSetup

if ~isvalid(MX.pCAM.Cam)
    error('Please setup a camera using rCameraSetup.');
end

img = snapshot(MX.pCAM.Cam);

% Optional display
if nargin > 1 && doImshow
    imshow(img);
end

end