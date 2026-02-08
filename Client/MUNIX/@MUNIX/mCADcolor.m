function mCADcolor(MX,color)
% Modify robot color

if nargin > 1                                 
    %--Munix:
    MX.pCAD.mtl{1}(2).Kd = color';  % 2,3  -> Top plat
    MX.pCAD.mtl{1}(3).Kd = color';  % 9    -> Suporte rodinha traseira
                                      % 10   -> rodinha traseira
                                   
end

for ii = 1:length(MX.pCAD.obj{1}.umat3)
    mtlnum = MX.pCAD.obj{1}.umat3(ii);
    for jj=1:length(MX.pCAD.mtl{1})
        if strcmp(MX.pCAD.mtl{1}(jj).name,MX.pCAD.obj{1}.usemtl(mtlnum-1))
            break;
        end
    end
    fvcd3(ii,:) = MX.pCAD.mtl{1}(jj).Kd';
end

MX.pCAD.i3D{1}.FaceVertexCData  = fvcd3;
end