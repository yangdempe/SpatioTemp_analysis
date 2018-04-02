%% ploting time series and savefig
re_v   = [50,50,15,15,50,50];
sigma_v= [20,75,30,70,45,55];

xlim1=[0,0,0,0,0,0;
       1,1,1,1,2,3];
ylims=[3,3.6;
       2,7;
       1,11;
       0,25;
       0,40;
       0,60];
   
L=120;
out_points=[1:10:51,60];
xi=(-29.75:0.5:-0.25).*1e-2;

h=figure();
hpos=get(h,'Position');
set(h,'Position',hpos.*[1 1 2 1.5]);

width=0.27; height=0.16;
pos=[0.08    0.77    width    height
     0.39    0.77    width    height
     0.7     0.77    width    height
     0.08    0.6     width    height
     0.39    0.6     width    height
     0.7     0.6     width    height
     0.08    0.28    width    height
     0.39    0.28    width    height
     0.7     0.28    width    height
     0.08    0.11    width    height
     0.39    0.11    width    height
     0.7     0.11    width    height];

axs=cell(4,3);
Titles={'I: Seizure Suppression','IIa: Weakly attenuated wave','IIb: Strongly attenuated wave',...
        'III: Inward wave',      'IV: Modulated \alpha wave',  'V: \theta-\alpha bimodal wave'};
for i=1:6
    sigma = sigma_v(i);
    re    = re_v(i);
    
    filemat=sprintf('data_waves/re=%.0fmm_sigma=%.0fmm_Itn=18.mat',re,sigma);
    load(filemat);
    dt = x_out.deltat;
    
    %% plot wave
    idx=i;
    if i>3, idx=i+3; end
    axs{idx}=subplot(4,3,idx);
    set(axs{idx},'pos',pos(idx,:));
    if i<=4
        imagesc((1:1e3).*dt,xi,x_out.data{1}(1:1e3,:)'); 
    else
        imagesc((1:3e3).*dt,xi,x_out.data{1}(1:3e3,:)'); 
    end
    shading flat
    %colorbar;
    set(gca,'YDir','normal')
    xlim(xlim1(:,i));   
    ylim([-0.3,0]);
    if mod(i,3)==1
        set(gca,'xtick',[],'ytick',[-0.3,-0.2,-0.1,0])
    else
        set(gca,'xtick',[],'ytick',[])
    end
    if mod(i,3)==1, ylabel('Site X (m)');  end
    title(Titles{i},'fontweight','bold');
    set(gca,'fontsize',20,'CLim',ylims(i,:));
   
    %% plot time series
    idx=i+3;
    if i>3, idx=i+6;    end
    axs{idx}=subplot(4,3,idx);
    set(axs{idx},'pos',pos(idx,:));
    if i<=4
        plot((1:1e3).*dt,x_out.data{1}(1:1e3,out_points));
    else
        plot((1:3e3).*dt,x_out.data{1}(1:3e3,out_points));
    end
    xlim(xlim1(:,i));
    ylim(ylims(i,:));
    if mod(i,3)==1, ylabel('$\phi_e$ (s$^{-1}$)','interpreter','latex');    end
    xlabel('time (s)');
    set(gca,'fontsize',20);
end

%% for subplot labels
xl  = 0.03;   xm = 0.36;   xr = 0.67;
yu  = 0.93;   yd = 0.44;
wth = 0.05;
ht  = 0.07;
annotation(h,'textbox',...
    [xl yu wth ht],...
    'String',{'A'},...
    'LineStyle','none',...
    'FontSize',30,...
    'FontName','Helvetica Neue');

% Create textbox
annotation(h,'textbox',...
    [xm yu wth ht],...
    'String',{'B'},...
    'LineStyle','none',...
    'FontSize',30,...
    'FontName','Helvetica Neue');

% Create textbox
annotation(h,'textbox',...
    [xr yu wth ht],...
    'String',{'C'},...
    'LineStyle','none',...
    'FontSize',30,...
    'FontName','Helvetica Neue');

% Create textbox
annotation(h,'textbox',...
    [xl yd wth ht],...
    'String',{'D'},...
    'LineStyle','none',...
    'FontSize',30,...
    'FontName','Helvetica Neue');

% Create textbox
annotation(h,'textbox',...
    [xm yd wth ht],...
    'String',{'E'},...
    'LineStyle','none',...
    'FontSize',30,...
    'FontName','Helvetica Neue');

% Create textbox
annotation(h,'textbox',...
    [xr yd wth ht],...
    'String',{'F'},...
    'LineStyle','none',...
    'FontSize',30,...
    'FontName','Helvetica Neue');
