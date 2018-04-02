function get_PD()

RE   =0.01:0.001:0.08;    nr=numel(RE);      % unit: m
SIGMA=0.01:0.001:0.08;    ns=numel(SIGMA);   % unit: m

fmax = 35;  fmin  = 1;  
Path = 'For_PD/Matfile';
Nn   = 60;
%% Results
Amp  = zeros(ns,nr,Nn);
Fid  = zeros(ns,nr,Nn);
Fpeak= zeros(ns,nr,Nn);
Mu   = zeros(ns,nr);
Lags_rad = zeros(ns,nr,Nn);
Wavenum  = zeros(ns,nr);

for i=1:ns
    for j=1:nr
        sigma = SIGMA(i);
        re    = RE(j);
        range = min(max(30,Nn-i-5),50):55;
        [amp,fid,fpeak,lags_rad,mu,wavenum]=get_phase(Path,re*1e3,sigma*1e3,fmin,fmax,range);
        
        Amp(i,j,:)  =amp;
        Fid(i,j,:)  =fid;
        Fpeak(i,j,:)=fpeak;
        Mu(i,j)     = mu;
        Lags_rad(i,j,:)=lags_rad;
        Wavenum(i,j)   = wavenum; 
    end
end

save('For_PD.mat','RE','SIGMA','Amp','Fid','Fpeak','Lags_rad','Wavenum','Mu','-v7.3');
