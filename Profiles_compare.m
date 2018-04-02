n=15;
lx=0.005;
L=120;

xi=((-60:59)+0.5).*lx;

%hfig=figure(); pos=get(hfig,'position'); %set(hfig,'position',pos.*[1,1,1.5,0.7]);

!mkdir -p gauss_profile_compare_figs
for sigma=0.02:0.001:0.04
    filemat=sprintf('gauss_simdata/sigma=%.0fmm_itn=%d.mat',sigma*1e3,n);
    load(filemat);
    filemat=sprintf('gauss_solution/solution_r_sigma=%.0fmm.mat',sigma*1e3);
    load(filemat);
    phie_m=mean(x_out.data{1},1);
    
    figure();
    hold on; box on;
    plot([-xout,fliplr(xout)],[yout(:,1)',fliplr(yout(:,1)')]);
    scatter(xi,phie_m,'o');
    legend({'solution','simulation'});

    xlim([-0.3,0.3]);
    ylim([3,4]);
    xlabel('Site X (m)','interpreter','latex');
    ylabel('$\phi_e$ (s$^{-1}$)','interpreter','latex');
    title(sprintf('$\\sigma=%.3f$ m',sigma),'interpreter','latex');
    set(gca,'fontsize',20);
    
    fileout=sprintf('gauss_profile_compare_figs/sigma=%.0fmm.fig',sigma*1e3);
    savefig(fileout);
    close all;
end
