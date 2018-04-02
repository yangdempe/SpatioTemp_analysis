function power_f(re,sigma,fmax,fmin)
%re   = 30;  sigma = 30;
%fmax = 35;  fmin  = 1;

%% load time series data
itn=18;
fin=sprintf('For_PD/Matfile/re=%.0fmm_sigma=%.0fmm_Itn=%d.mat',re,sigma,itn);
load(fin);

data=x_out.data{1}(:,60);
Fs  =1./x_out.deltat;

%% get power spectrum
[pxx,f]=pwelch(data,2^15,2^14,2^15,Fs);

f   = f(f<fmax);    nf1 = numel(f);
f   = f(f>fmin);    nf2 = numel(f);
pxx = pxx(nf1-nf2+1:nf1);

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
pos1 = [0.12    0.18    0.34    0.7];
pos2 = [0.58    0.18    0.34    0.7];

%% ploting
s1=subplot(1,2,1);
set(s1,'pos',pos1);
plot(x_out.time(2e4:3e4),data(2e4:3e4));
xlabel('time (s)','interpreter','latex');
ylabel('$\phi_e$ (s$^{-1}$)','interpreter','latex');
set(gca,'fontsize',20);

s2=subplot(1,2,2);
set(s2,'pos',pos2);
plot(f,pow2db(pxx));
xlim([fmin,fmax]);
xlabel('Frequency $f$ (Hz)','interpreter','latex');
ylabel('$P$/$f$ (dB/Hz)','interpreter','latex')
set(gca,'fontsize',20);

savefig(sprintf('For_PD/Power_figs/re=%.0fmm_sigma=%.0fmm_p.fig',re,sigma));
