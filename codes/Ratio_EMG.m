function Ratio_EMG(ID)
re=0.03;  %RE(ID);

k1 = 0.0656/0.08;
k2 = 0.08/0.0583;
Min_sigma = max(floor(k1*re*1e4)*1e-4,0.01);
Max_sigma = min(ceil(k2*re*1e4)*1e-4,0.064);
sigma1 = Min_sigma:1e-4:Max_sigma;
SIGMA  = sigma1(abs(sigma1*1e3-round(sigma1*1e3))>0.05);
sigma  = SIGMA(ID);

filemat=sprintf('Matfile/re=%.0fmm_sigma=%.1fmm_Itn=22.mat',re*1e3,sigma*1e3);
load(filemat);

data=x_out.data{1};
dt  =x_out.deltat;

freqs1=2.8:0.01:3.2;
cfs1=Spectrog(data,dt,freqs1,[]);
freqs2=9.5:0.01:10.5;
cfs2=Spectrog(data,dt,freqs2,[]);

roundup=2e3;
power1=abs(cfs1(:,roundup+1:end-roundup)); % power should be |cfs|^2
power2=abs(cfs2(:,roundup+1:end-roundup));
power_peaks_a=max(power2,[],1);     % peaks for freq range of alpha wave
power_peaks_t=max(power1,[],1);     % peaks for freq range of theta wave

A    = sign(power_peaks_a-power_peaks_t);
ratio= numel(A(A==1))./numel(A);
 
save(['Ratiofile_EMG/',filemat(9:end-4),'_A.mat'],'re','sigma','A','ratio','-v7.3');
