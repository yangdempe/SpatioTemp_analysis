function Ratio(ID)
load('Para.mat');

re    = Para(ID,1)*1e3;
sigma = Para(ID,2)*1e3;
filemat=sprintf('Matfile/re=%.0fmm_sigma=%.0fmm_Itn=22.mat',re,sigma);
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
 
save(['Ratiofile/',filemat(9:end-4),'_A.mat'],'re','sigma','A','ratio','-v7.3');
