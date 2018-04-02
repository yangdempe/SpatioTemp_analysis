% load('re=30mm_gprmp_2.mat')
% data=x_out.data{1};
figure();
plot(x_out.time,data);
yyaxis right
plot(gprmp.timepoints,gprmp.sigmas)
xlabel('time (s)','interpreter','latex')
ylabel('Width $\sigma$ (m)','interpreter','latex')
yyaxis left
ylabel('$\phi_e$ (s$^{-1}$)','interpreter','latex')
set(gca,'fontsize',16)
title('$r_e=0.03$ m','interpreter','latex')
