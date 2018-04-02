function Get_peaks(ID)

re=3;

deltav=1.4:0.02:2.50;       % unit: cm
Delta=deltav(ID);           % the radius of lesion zone

filemat=sprintf('Delta=%.2fcm_re=%dcm_l.mat',Delta,re);
load(filemat);

Peaks=Get_powerpeaks(x_out);
save([filemat(1:end-6),'.mat'],'Delta','re','Peaks','-v7.3');
