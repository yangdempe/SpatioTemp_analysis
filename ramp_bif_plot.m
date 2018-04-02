figure()
hold on
box on

n=size(phie_peaks,1)/2;
for j=n+1:2*n
    para    =phie_peaks{j,1};
    data_max=phie_peaks{j,2};
    scatter(para.*ones(size(data_max)),data_max,'b');
    data_min=phie_peaks{j,3};
    scatter(para.*ones(size(data_min)),data_min,'b'); 
end
for j=1:n
    para    =phie_peaks{j,1};
    data_max=phie_peaks{j,2};
    scatter(para.*ones(size(data_max)),data_max,'r.');
    data_min=phie_peaks{j,3};
    scatter(para.*ones(size(data_min)),data_min,'r.'); 
end
xlabel('Width $\sigma$ (m)','interpreter','latex');
ylabel('$\phi_e$ (s$^{-1}$)','interpreter','latex');
set(gca,'yscale','log','ylim',[1,200],'fontsize',18);