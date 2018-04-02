window=30; % unit:s time window of each seg for analysis
np=50;  % peak number limit for each para;

re=0.03;
load(sprintf('re=%.0fmm_gprmp_1.mat',re*1e3));
phie_peaks1 = Peaks(x_out,gprmp,window,np);
n1=size(phie_peaks1,1);
load(sprintf('re=%.0fmm_gprmp_2.mat',re*1e3));
phie_peaks2 = Peaks(x_out,gprmp,window,np);
n2=size(phie_peaks2,1);

phie_peaks = [ phie_peaks1(1:n1/2,:);
               phie_peaks2((n2/2+1):n2,:);
               phie_peaks2(1:n2/2,:);
               phie_peaks1((n1/2+1):n1,:)];
          
figure()
hold on
box on

n=size(phie_peaks,1)/2;
for j=1:n
    para    =phie_peaks{j,1}./re;
    data_max=phie_peaks{j,2};
    scatter(para.*ones(size(data_max)),data_max,'b');
    data_min=phie_peaks{j,3};
    scatter(para.*ones(size(data_min)),data_min,'b'); 
end
for j=n+1:2*n
    para    =phie_peaks{j,1}./re;
    data_max=phie_peaks{j,2};
    scatter(para.*ones(size(data_max)),data_max,'r.');
    data_min=phie_peaks{j,3};
    scatter(para.*ones(size(data_min)),data_min,'r.'); 
end
xlabel('Relative width $\sigma$/$r_e$','interpreter','latex');
ylabel('$\phi_e$ (s$^{-1}$)','interpreter','latex');
set(gca,'yscale','log','ylim',[1,200],'fontsize',20);

plot([0.0275,0.0275]./re,[1,200],'g--')
plot([0.0355,0.0355]./re,[1,200],'g--')
text(0.022,100,'f=10 Hz','interpreter','latex','fontsize',20)
text(0.031,110,'f=3 Hz','interpreter','latex','fontsize',20)
title('$r_e=0.03$ m','interpreter','latex','fontsize',20)
