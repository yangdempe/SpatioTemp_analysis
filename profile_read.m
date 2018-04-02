function [A1,B1]=profile_read(sigma)

L=120;  lx=0.5; 
nulims=[1.8,4.4];    
n=15;   fs=20;

%% gaussian profile nu_se
xi=(-(L/2-1/2):(L/2-1/2)).*lx; % lx= 0.5 cm
fr=exp(-xi.^2./(2*sigma^2));
nus=(nulims(2)-nulims(1)).*fr+nulims(1);

%% simulation data of time-averaged phie
filemat=sprintf('data/sigma=%.1fcm_itn=%d.mat',sigma,n);
load(filemat);
phie_m=mean(x_out.data{3},1);

%% ---Fit Data: Using LSQ method---
% Define g(x) = a*exp(-(x-mu)^2/(2*sigma^2)):
g = @(A,X) A(1)*exp(-X.^2/2/A(3).^2)+A(2);
g2= @(B,X) B(1)*exp(-X.^2/2/B(3).^2).*(1+B(4).*cos(B(5).*X))+B(2);
% Initial (Guess) Parameters
A0 = [1,3,sigma];
B0 = [1,3,sigma,1e-1,1];
% Fit using Matlab's Least Squares function
[A1,~,~,~,~] = lsqcurvefit(g,A0,xi,phie_m);
[B1,~,~,~,~] = lsqcurvefit(g,B0,xi,phie_m);

figure(); hold on; box on;
plot(xi,nus,'-.')
scatter(xi,phie_m)
plot(xi,g(A1,xi),'k--','linewidth',2);
plot(xi,g2(B1,xi),'b--','linewidth',2);
scatter(xi,g(A1,xi)-phie_m,'k*')
scatter(xi,g2(B1,xi)-phie_m,'b*')
legend({'\nu_{se}','\phi_e','Gaussian fitting'})
title(sprintf('$r_e = 3$ cm, $\\sigma = %.1f$ cm, fitted $\\sigma = %.1f$',sigma,A1(3)),'interpreter','latex');
xlabel('site X (cm)')
ylabel('$\nu_{se}$ (mV s) or $\phi_e$ (s$^{-1}$)','interpreter','latex');
set(gca,'fontsize',fs)

savefig(sprintf('figs/steady_state_s=%.1fcm.fig',sigma))

% figure(1); hold on; box on;
% plot(xi,phie_m);
% title('$r_e = 3$ cm','interpreter','latex');
% xlabel('site X (cm)')
% ylabel('$\phi_e$ (s$^{-1}$)','interpreter','latex');
% set(gca,'fontsize',fs)

% figure(2); hold on; box on;
% gx=@(a,X) -a.*X./2.*exp(-X.^2/2);
% plot([xi(1), xi(end)]./3,[0 0],'k--');
% plotyy(xi./3,gx(A1(1),xi./3),xi./3,g(A1,xi))
