function [PSD,fft_data,f] = get_power(data,nfft,overlap,fs)
%Smooth spectrum estimation using direct (fft-based) approach.
%   data      - data vector or time-series
%   nfft      - fft length
%   overlap   - overlap length [default = nfft/2]
%   fs        - sampling frequency
%
%   power     - estimated smoothed spectrum
%   f         - vector of frequencies;

n = numel(data);

if (exist('nfft') ~= 1),    nfft    = 2^10;     end
if (exist('overlap') ~= 1), overlap = nfft/2;   end
if (exist('fs') ~= 1),      fs      = 1e-3;     end

f = fs.*(0:nfft/2)/nfft;    fft_data = zeros(nfft/2+1,1);    
fstep = f(2)-f(1);
w = hanning(nfft);  % Using Hanning window to smooth spectrum
Nw= sqrt(w'*w*fs);

nrecs = 2*n/nfft-1;
locseg = 1:nfft;    nadvance = nfft-overlap;
for j = 1:nrecs
    xseg   = data(locseg);
    Xf     = fft((xseg-mean(xseg)).*w)/Nw;
    fft_data  = fft_data + Xf(1:(nfft/2+1));
    locseg = locseg +nadvance;
end
fft_data = fft_data/nrecs;
PSD      = abs(fft_data).^2./fstep;

end
