function [amp,fid,fpeak,lags_rad,mu,wavenum] = get_phase(Path,re,sigma,fmin,fmax,fit_range)

if (exist('fit_range') ~=1), fit_range = 30:55;  end

%% load time series data
itn  = 18;
fin  = sprintf('%s/re=%.0fmm_sigma=%.0fmm_Itn=%d.mat',Path,re,sigma,itn);
load(fin);  
Nn   = numel(x_out.nodes{1});    % output node number
Fs   = 1./x_out.deltat;
nfft = 2^15;    overlap = nfft/2;

%% Results
amp      = zeros(1,Nn);
fid      = zeros(1,Nn);
fpeak    = zeros(1,Nn);
lags_rad = zeros(Nn,1); % phase lag relative to center node

%% For center node
data = x_out.data{1}(:,Nn);

% get amplitude of phie
amp(Nn) = max(data(2^17:end),[],1)-min(data(2^17:end),[],1);

% get fpeak
[pxx,f]=pwelch(data,nfft,nfft/2,nfft,Fs);
f   = f(f<fmax);    nf1 = numel(f);
f   = f(f>fmin);    nf2 = numel(f);
pxx = pxx(nf1-nf2+1:nf1);
[~,fid(Nn)] = max(pxx);
fpeak(Nn)= f(fid(Nn));

% get phase lag relative to center node
ffts = zeros(nf2,Nn);
[~,fft_data,~] = get_power(data,nfft,overlap,Fs);
ffts(:,Nn)  = fft_data(nf1-nf2+1:nf1);
lags_rad(Nn)= angle(ffts(fid(Nn),Nn))./(2*pi);

%% For other nodes: 
for j = Nn-1:-1:1
    data = x_out.data{1}(:,j);
    
    % get amplitude of phie
    amp(j) = max(data(2^17:end),[],1)-min(data(2^17:end),[],1);
    
    % get fpeak
    [pxx,~]=pwelch(data,nfft,nfft/2,nfft,Fs);
    pxx = pxx(nf1-nf2+1:nf1);
    [~,fid(j)] = max(pxx);
    fpeak(j)= f(fid(j));
    
    % get phase lag relative to center node
    [~,fft_data,~] = get_power(data,nfft,overlap,Fs);
    ffts(:,j)  = fft_data(nf1-nf2+1:nf1);
    lags_rad(j)= angle(ffts(fid(j),j))./(2*pi);
    lags_rad(j)= lags_rad(j)-round(lags_rad(j)-lags_rad(j+1));
end
lags_rad = lags_rad';

Pa = polyfit(fit_range.*lx,log(amp(fit_range)),1);
mu = Pa(1);
Pl = polyfit(fit_range.*lx,lags_rad(fit_range),1);
wavenum = Pl(1);
    
end