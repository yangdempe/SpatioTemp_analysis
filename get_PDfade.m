function get_PDfade()
load('For_PD.mat')

Nr=numel(RE);
Ns=numel(SIGMA);
phie_thres=1;               Nn= 60;
                            
phases=zeros(Ns,Nr);
for i=1:Ns
    for j=1:Nr
        if Amp(i,j,Nn)<phie_thres   % threshold of phi_e
            phases(i,j)=0.25;       % Phase I
        elseif Mu(i,j)>3&&Wavenum(i,j)<0
            phases(i,j)=1.75;       % Phase III
        else
            phases(i,j)=2;      
        end
    end
end

load('Para.mat')
for n=1:size(Para,1)
    re_n    =round(Para(n,1).*1e3); j=re_n-9;
    sigma_n =round(Para(n,2).*1e3); i=sigma_n-9;
    file=sprintf('Ratiofile/re=%.0fmm_sigma=%.0fmm_Itn=22_A.mat',re_n,sigma_n);
    load(file);
    
    if phases(i,j)>1
        if ratio>1-5e-3
            phases(i,j)=2.25;   % Phase IV
        elseif ratio>5e-3
            phases(i,j)=2.75;   % Phase V
        end
    end
end

mumax=max(max(Mu(phases==2)));
mumin=min(min(Mu(phases==2)));
for i=1:Ns
    for j=1:Nr
        if phases(i,j)==2
            phases(i,j)=0.5+Mu(i,j)./mumax;
        end
    end
end

save('PDfade_1.mat','RE','SIGMA','phases','mumin','mumax','-v7.3');
