load('phases_ratio.mat', 'phases')
phases_ratio=phases;
load('L=100_delta_diag.mat')
Amp50=Amp(:,:,50);

re=1:0.1:10;        Delta=0.1:0.1:5;
phases=zeros(50,91);
for i=1:50
    for j=1:91
        if Amp50(i,j)<0.3
            phases(i,j)=0.25;   % Phase I
        elseif mu(i,j)>3&&wavenum(i,j)<0
            phases(i,j)=1.75;   % Phase III
        else
            phases(i,j)=2;      
        end
    end
end

for n=1:318
    i=find(round(10.*Delta)==round(10*phases_ratio(n,2)));
    j=find(round(10.*re)==round(10*phases_ratio(n,1)));
    if phases(i,j)>1
        if phases_ratio(n,3)>1-1e-2
            phases(i,j)=2.25;   % Phase IV

        elseif phases_ratio(n,3)>1e-2
            phases(i,j)=2.75;   % Phase V
        end
    end
end
mumax=max(max(mu(phases==2)));
mumin=min(min(mu(phases==2)));
for i=1:50
    for j=1:91
        if phases(i,j)==2
            phases(i,j)=0.5+mu(i,j)./mumax;
        end
    end
end

hfig=figure();
hold on
%surfc(X,Y,phases); view(0,90);  box on
% [cv,ch]=contourf(1:0.1:10,0.1:0.1:5,phases);
% set(ch,'edgecolor','none')
imagesc(1:0.1:10,0.1:0.1:5,phases); xlim([0,10]); ylim([0,5]);  box on
set(gca,'YDir','normal')
shading flat

C1=[zeros(25,1),ones(25,2)];
C2=[zeros(51,1),(0.8:-0.016:0)',ones(51,1)];
C3=[zeros(25,1),ones(25,1),zeros(25,1)];
C4=[ones(25,2).*0.5,zeros(25,1)];
C5=[ones(25,2),zeros(25,1)];
Cs=[C1;C2;C3;C4;C5];
colormap(Cs);
% colormap([
%           0 1 1;
%           0.4 0.6 1;
%           0 1 0;
%           0.1 0.8 0.1;
%           0.5 0.5 0;
%           1 1 0])
h=colorbar;
colorbar('Ticks',[0.25,0.5,1,1.5,1.75,2.25,2.75],...
    'TickLabels',{'I',sprintf('%.1f',mumin),'II',sprintf('%.1f',mumax),...
    'III','IV','V','VI'})
%title(h,'$\mu$ (m$^{-1}$)','interpreter','latex');


plot3([0,5.5],0.5.*[0,5.5],[10,10],'r--');
plot3([0,4.2],0.8.*[0,4.2],[10,10],'r--');
plot3([0,5],0.6.*[0,5],[10,10],'r--');
plot3([0,2.5],2.*[0,2.5],[10,10],'r--');

plot3([3,3],[1.4,2.5],[10,10],'k-.','Linewidth',2);

% plot([8.6,8.6],[0.1,5],'g-.','linewidth',1.2);
% plot([8.6,0],[0,4.5],'g-.','linewidth',1.2);

scatter3(4.0,1.0,8,70,'r^','filled');
scatter3(8.0,4.0,8,70,'rv','filled');
scatter3(1.5,1.5,8,70,'r>','filled');
scatter3(1.2,4.0,8,70,'rd','filled');
scatter3(3.5,2.5,8,60,'rs','filled');
scatter3(4.3,2.5,8,50,'ro','filled');

title('Phase Diagram','interpreter','latex')
xlabel('$r_e$ (cm)','interpreter','latex')
ylabel('$\Delta$ (cm)','interpreter','latex')
set(gca,'fontsize',20,'CLim',[0,3])

annotation(hfig,'textbox',...
    [0.5 0.32 0.07 0.076],... % [x_begin y_begin length height]
    'String',{'I'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',20,...
    'FontName','Helvetica Neue');

annotation(hfig,'textbox',...
    [0.56 0.72 0.07 0.076],...
    'String',{'II'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',20,...
    'FontName','Helvetica Neue');

% annotation(hfig,'textbox',...
%     [0.3 0.72 0.07 0.076],...
%     'String',{'III'},...
%     'LineStyle','none',...
%     'FontWeight','bold',...
%     'FontSize',20,...
%     'FontName','Helvetica Neue');

annotation(hfig,'textbox',...
    [0.2 0.75 0.07 0.076],...
    'String',{'III'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',20,...
    'FontName','Helvetica Neue');

annotation(hfig,'textbox',...
    [0.36 0.5 0.07 0.076],...
    'String',{'V'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',20,...
    'FontName','Helvetica Neue');

annotation(hfig,'textbox',...
    [0.41 0.5 0.07 0.076],...
    'String',{'IV'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',20,...
    'FontName','Helvetica Neue');
