load('For_PD.mat');

Nn = 60;

close all;

figure()
imagesc(SIGMA,RE,Mu); xlim([0,0.08]); ylim([0,0.08]);  box on
set(gca,'YDir','normal')
shading flat
colorbar;
title('Attenuation','interpreter','latex')
xlabel('$r_e$ (m)','interpreter','latex')
ylabel('$\sigma$ (m)','interpreter','latex')
set(gca,'fontsize',20,'CLim',[0,40])
figure()
imagesc(SIGMA,RE,Fpeak(:,:,Nn)); xlim([0,0.08]); ylim([0,0.08]);  box on
set(gca,'YDir','normal')
shading flat
colorbar;
title('Frequency','interpreter','latex')
xlabel('$r_e$ (m)','interpreter','latex')
ylabel('$\sigma$ (m)','interpreter','latex')
set(gca,'fontsize',20,'CLim',[0,12])
figure()
imagesc(SIGMA,RE,Amp(:,:,Nn)); xlim([0,0.08]); ylim([0,0.08]);  box on
set(gca,'YDir','normal')
shading flat
colorbar;
title('Amplitude of $\phi_e$','interpreter','latex')
xlabel('$r_e$ (m)','interpreter','latex')
ylabel('$\sigma$ (m)','interpreter','latex')
set(gca,'fontsize',20,'CLim',[0,10])
hold on

xm = 0.07;      k1 = 0.0656/0.08;   
ym = 0.064;     k2 = 0.08/0.0583;
plot3([0,xm],     [0,xm.*k1], [11,11],'r--')
plot3([0,ym./k2], [0,ym],     [11,11],'r--')
plot3([ym./k2,xm],[ym,ym],    [11,11],'r--')
plot3([xm,xm],    [xm.*k1,ym],[11,11],'r--')
generate_points;

figure()
imagesc(SIGMA,RE,Wavenum); xlim([0,0.08]); ylim([0,0.08]);  box on
set(gca,'YDir','normal')
shading flat
colorbar;
title('Wave number','interpreter','latex')
xlabel('$r_e$ (m)','interpreter','latex')
ylabel('$\sigma$ (m)','interpreter','latex')
set(gca,'fontsize',20,'CLim',[0,20])
