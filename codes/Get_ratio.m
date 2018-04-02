function Get_ratio(ID)

re=3;

deltav=[2.26,2.3,2.31,2.32];       % unit: cm
Delta=deltav(ID);           % the radius of lesion zone

filemat=sprintf('data_mat/Delta=%.2fcm_re=%.1fcm_itn=23.mat',Delta,re);
load(filemat);

n=2^23;

Peaks=Get_powerpeaks(n,x_out);
ratio_a=Cal_ratio(n,x_out,2e3);
save([filemat(1:end-4),'_r2.mat'],'Delta','re','Peaks','ratio_a','-v7.3');
