% sigma1 = 24.6:0.1:41.2; ns = numel(sigma1);
% ratios = zeros(1,ns);
% for i=1:ns
%     re=30;
%     sigma=sigma1(i);
%     filemat=sprintf('Ratiofile_EMG/re=%.0fmm_sigma=%.1fmm_Itn=22_A.mat',re,sigma);
%     load(filemat);
%     
%     ratios(i)=ratio;
% end 

hfig=figure();
hpos=get(hfig,'Position');
% set(hfig,'Position',hpos.*[1 1 1 1.5]);
% pos1=[0.13,0.56,0.8,0.38];
% pos2=[0.13,0.10,0.8,0.38];

xc0=18.7;
xc1=24.55;  xc2=28.1; xc3=39.05;

xlims=[16,42].*1e-3;
ylims=[-0.1,1.1];

hold on
plot(sigma1.*1e-3,ratios,'b-o');

plot([xc0 xc0].*1e-3,ylims,'r-','linewidth',2.5);
plot([xc1 xc1].*1e-3,ylims,'r-','linewidth',2.5);
plot([xc1 xc1].*1e-3,ylims,'k--');
plot([xc2 xc2].*1e-3,ylims,'k--');
plot([xc3 xc3].*1e-3,ylims,'k--');

xt1=27.5;   xt2=35.4;
plot([xt1 xt1].*1e-3,ylims,'g--');
plot([xt2 xt2].*1e-3,ylims,'g--');
% xe=2.15;  % bimodal case: bursting of alpha wave
% ye=0.4366;% ratio at Delta=2.15;
% plot(xe,ye,'b*','Markersize',10);

box on
text(0.017,0.5,'I',  'fontsize',24,'fontw','b');
text(0.026,0.5,'IV', 'fontsize',24,'fontw','b');
text(0.032,0.5,'V',  'fontsize',24,'fontw','b');
text(0.040,0.5,'II', 'fontsize',24,'fontw','b');

text(0.0188,0.5,'Bistable','fontsize',24,'fontw','b','Color','red');

xlim(xlims);
ylim([-0.1,1.1]);
xlabel('$\sigma$ (m)','interpreter','latex');
ylabel('Ratio of $\alpha$ wave dominance','interpreter','latex');
title('$r_e=0.03$ m','interpreter','latex');
set(gca,'fontsize',20);
