%% get powers for whole time series
function [bfreq,bispec,freq,spec]=Get_powers(x_out,fmax,fres,bfmax)

data=x_out.data{3}(:,60);
dt=x_out.deltat;
n=x_out.npoints;

Fs=1./dt;           % frequency resolution
f = Fs*(1:(n/2))/n;

fmax_id=floor(fmax*n/Fs);
dFs    =floor(fres*n/Fs);       % sample 1 tenth of data
fft_data=fft(data-mean(data));
fft_data=fft_data(2:n/2+1)./n;
freq=f(1:dFs:fmax_id);
spec=fft_data(1:dFs:2*fmax_id);

bfmax_id=floor(bfmax*n/(dFs*Fs));
bfreq=freq(1:bfmax_id);
bispec=zeros(bfmax_id,bfmax_id);
for i=1:bfmax_id
    for j=1:bfmax_id
        bispec(i,j)=spec(i).*spec(j).*conj(spec(i+j));
    end
end
