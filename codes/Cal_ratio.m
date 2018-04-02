%% get the ratio of alpha freq dominace
function A=Cal_ratio(x_out,roundup)
data=x_out.data{3};
dt=x_out.deltat;

freqs1=2.8:0.1:3.2;
cfs1=Spectrog(data,dt,freqs1,[]);
freqs2=9.5:0.1:10.5;
cfs2=Spectrog(data,dt,freqs2,[]);

power1=abs(cfs1(:,roundup+1:end-roundup)); % power should be |cfs|^2
power2=abs(cfs2(:,roundup+1:end-roundup));
power_peaks_a=max(power2,[],1);     % peaks for freq range of alpha wave
power_peaks_t=max(power1,[],1);     % peaks for freq range of theta wave

A=sign(power_peaks_a-power_peaks_t);
