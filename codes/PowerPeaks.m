function PowerPeaks(ID)

re=3;

deltav=1.5:0.01:2.4;        % unit: cm
Delta=deltav(ID);           % the radius of lesion zone

data_set2=[1.5,1.6,1.8,1.9,2.2];  %itn=20
data_set3=[1.7,2.0,2.1,2.3,2.4];  %itn=23

if sum(round(100*Delta)==round(100.*data_set2))
filemat=sprintf('data_mat2/Delta=%.1fcm_re=%.1fcm_itn=20.mat',Delta,re);
elseif sum(round(100*Delta)==round(100.*data_set3))
filemat=sprintf('data_mat3/Delta=%.1fcm_re=%.1fcm_itn=23.mat',Delta,re);
else
filemat=sprintf('data_mat/Delta=%.2fcm_re=%.1fcm_itn=23.mat',Delta,re);
end

load(filemat);

[Peaks,freq,power]=Get_powerpeaks(x_out);
save(sprintf('powerpeaks/Delta=%.2fcm_re=%.1fcm_p.mat',Delta,re),'freq','power','Peaks','-v7.3');
