% get power peaks for whole time series in alpha and theta freq range
function [Peaks,freq,power]=Get_powerpeaks(x_out)
n=2^20;
data=x_out.data{3}(1:2^20);
x=data-mean(data);
dt=x_out.deltat;

Fs=1./dt;

[power,freq]=pwelch(x,hanning(2^13),2^12,n,Fs);
f=freq;

%hwelch = spectrum.welch;
%hwelch.SegmentLength = 10000;
%yy=psd(hwelch,x,'NFFT',length(x),'Fs',1e3);

%f=yy.Frequencies(1:3e4);
%freq=f;
%power=yy.Data(1:3e4);


id_theta=find(f>2.9&f<3.1);
[P1,I1]=max(power(id_theta));
f1=f(id_theta(I1));

id_alpha=find(f>9.5&f<10.5);
[P2,I2]=max(power(id_alpha));
f2=f(id_alpha(I2));

Peaks=[f1,P1,f2,P2];
