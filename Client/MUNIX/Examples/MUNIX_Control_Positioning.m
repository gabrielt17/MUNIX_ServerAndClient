% Plotar robô e realizar posicionamento

% =========================================================================
% Limpar histórico de comandos
close all
clear
clc

% =========================================================================
% Buscar o diretório de pasta quem contém a Plataforma AuRoRA
PastaAtual = pwd;
PastaRaiz = 'AuRoRA_beta';
cd(PastaAtual(1:(strfind(PastaAtual,PastaRaiz)+numel(PastaRaiz)-1)))
addpath(genpath(pwd))


% =========================================================================
% Carregar a classe referente ao robô
M = MUNIX;

% =========================================================================
% Criar ambiente e exibir o robos

figure(1);
ax = gca;
ax.FontSize = 12;
xlabel({'$$x$$ [m]'},'FontSize',18,'FontWeight','bold','interpreter','latex');
ylabel({'$$y$$ [m]'},'FontSize',18,'FontWeight','bold','interpreter','latex');
zlabel({'$$z$$ [m]'},'FontSize',18,'FontWeight','bold','interpreter','latex');
axis equal
view(3)
view(210,20)
grid on
hold on
grid minor
light;
axis([-1 1 -1 1 0 0.5])
set(gca,'Box','on');

M.mCADplot
%M.mCADcolor([0 51 80]/255);

%Modificando a escala do robô:
%M.pCAD.scale = 1;

drawnow

XX = []; % Matriz vazia para armazenamento dos dados de navegação

%Pontos desejados:
%Xd = [1 1 0  2 2 0  3 3 0  4 4 0  5 5 0  6 6 0];

Xd = [1 1 0  1 0 0  0 1 0  0 0 0];
numero_pontos = 0;
cont_pos = 1;
tempo_ponto = 10;

Rastro.X  = M.pPos.X(1:3); % Rastro atual
Rastro.Xd = M.pPos.X(1:3); % Rastro desejado

hold on
Rastro.linhaX  = plot3(Rastro.X(1,:), Rastro.X(1,:), Rastro.X(1,:), '-k');
Rastro.linhaXd = plot3(Rastro.Xd(1,:),Rastro.Xd(1,:),Rastro.Xd(1,:),'--r');

pause(2)
disp('Início ............')

% =========================================================================
tmax = tempo_ponto*length(Xd)/3; % Tempo Simulação em segundos
Info = title(['Time: ' num2str(0,'%05.2f') ' | ' num2str(tmax,'%05.2f') 's']);

t = tic;   % Tempo corrente de simulação
tc = tic;  % Tempo de envio de sinal de controle
tp = tic;  % Tempo de plotagem do robô

while toc(t) < tmax
    if toc(tc) > 1/30
        tc = tic;

        % 0- Definir posições desejadas
        if toc(t) > numero_pontos*tempo_ponto
            if cont_pos < length(Xd)
                M.pPos.Xd(1) = Xd(cont_pos);
                M.pPos.Xd(2) = Xd(cont_pos+1);
                M.pPos.Xd(3) = Xd(cont_pos+2);

                numero_pontos = numero_pontos + 1;
            end
            cont_pos = cont_pos+3;
        end

        % Controlador
        % 1- Ler dados dos sensores
        M.rGetSensorData
        
        % 2- Calcular sinais de controe
        M = cMUNIX_KinematicController(M);

        % 3- Armazenar dados de navegação (LOG)
        XX = [XX; [M.pPos.Xd' M.pPos.X' M.pSC.Ud' toc(t)]];
        Rastro.X  = [Rastro.X  M.pPos.X(1:3)];
        Rastro.Xd = [Rastro.Xd M.pPos.Xd(1:3)];

        % 4- Enviar sinais de controle
        M.rSendControlSignals;

    end
    if toc(tp) > 0.3
        tp = tic;
        M.mCADplot;
        Rastro.linhaX.XData  = Rastro.X(1,:);
        Rastro.linhaX.YData  = Rastro.X(2,:);
        Rastro.linhaX.ZData  = Rastro.X(3,:);
        Rastro.linhaXd.XData = Rastro.Xd(1,:);
        Rastro.linhaXd.YData = Rastro.Xd(2,:);
        Rastro.linhaXd.ZData = Rastro.Xd(3,:);

        Info.String = ['Time: ' num2str(toc(t),'%05.2f') ' | ' num2str(tmax,'%05.2f') 's'];

        drawnow
    end

end

%% =========================================================================
disp('Fim   -------------')


figure
title('Posição')
subplot(311),plot(XX(:,end),XX(:,[1 13])')
legend('x_{Des}','x_{Atu}')
grid
subplot(312),plot(XX(:,end),XX(:,[2 14])')
legend('y_{Des}','y_{Atu}')
grid
subplot(313),plot(XX(:,end),XX(:,[3 15])')
legend('y_{Des}','y_{Atu}')
grid

figure
title('Orientação')
subplot(311),plot(XX(:,end),XX(:,[4 16])'*180/pi)
legend('\phi_{Des}','\phi_{Atu}')
grid
subplot(312),plot(XX(:,end),XX(:,[5 17])'*180/pi)
legend('\theta_{Des}','\theta_{Atu}')
grid
subplot(313),plot(XX(:,end),XX(:,[6 18])'*180/pi)
legend('\psi_{Des}','\psi_{Atu}')
grid

figure
title('Sinais de Controle')
subplot(211),plot(XX(:,end),XX(:,25))
legend('u_{1}')
grid
subplot(212),plot(XX(:,end),XX(:,26))
legend('u_{2}')
grid

