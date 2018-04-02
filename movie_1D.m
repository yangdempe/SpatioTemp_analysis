function movie_1D(sigma)
folderOut='For_PD/';
file_name=sprintf('re=10mm_sigma=%dmm_Itn=18',sigma);
load([file_name,'.mat']);

%% set parameters for plot
trange=1e4+1:10:2e4;
n = numel(trange);
twindow = -1000:100;

L=120;  lx=0.005; Lx = 120*lx;
rwindow = (1:120).*lx-Lx/2-lx/2;
rlims=[-0.5,L+0.5].*lx-Lx/2;

phielims = [0, max(x_out.data{1}(:,60))];
field=1;
node =60;

%% set figure
hbif=figure();%('visible', 'off');
hpos=get(hbif,'Position');
set(hbif,'Position',hpos.*[1 1 1.2 0.8]);
Title = sprintf('Axon range $r_e=0.03$ m, width $\\sigma=%.4f$ m',sigma*1e-3);
annotation('textbox', [0 0.86 1 0.13], ...
    'String',Title,...
    'interpreter','latex','fontsize',25, ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')
video1 = VideoWriter([folderOut,file_name,'_1D'],'MPEG-4');
open(video1);

pos1 = [0.13    0.18    0.35    0.7];
pos2 = [0.57    0.18    0.35    0.7];

%% plot each frame (n frames in total)
for i=1:n
    j=trange(i);
    jwindow = j + twindow;
    
    s1   = subplot(1,2,1);
    set(s1,'pos',pos1); 
    plot(x_out.time(jwindow),x_out.data{field}(jwindow,node),'k-');
    xlim([x_out.time(jwindow(1)),x_out.time(jwindow(end))]);
    hold on
    scatter(x_out.time(j),x_out.data{1}(j,node),'bo');
    hold off
    xlabel('time (s)','interpreter','latex');
    ylabel('$\phi_e$ (s$^{-1}$)','interpreter','latex');
    set(gca,'yscale','linear','ylim',phielims,'fontsize',20);
    
    s2   = subplot(1,2,2);
    set(s2,'pos',pos2);
    plot(rwindow,[x_out.data{field}(j,:),fliplr(x_out.data{field}(j,:))],'b.');
    hold on
    scatter(0,x_out.data{field}(j,node),'ko');
    hold off
    xlim(rlims); ylim(phielims);
    xlabel('Site X (m)','interpreter','latex');
    set(gca,'yscale','linear','ylim',phielims,'fontsize',20);
    
    drawnow
    vframe = getframe(gcf);
    writeVideo(video1,vframe);
end
        
close(video1);
end
