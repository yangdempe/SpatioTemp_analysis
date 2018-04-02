function re2_read(ID)

n=23;

%% loading external parameters [re,delta]
load('Para_re=3_2.mat')
re=3.0;      
Delta=parar(ID); % the radius of lesion zone

%% naming configue and output files
fid=ID;    

subfolder='.';      %'Emergence/re=3_2';
fprefix=sprintf('%s/Para_itn',subfolder);
filein=sprintf('%s_%d.conf',fprefix,fid);
filemat=sprintf('%s/Delta=%.2fcm_re=%.1fcm_itn=%d.mat',subfolder,Delta,re,n);

x_out=nf.read([filein(1:end-4),'output']);

Peaks=Get_powerpeaks(x_out.data{3}(1:2^22,1),x_out.deltat);
ratio_a=Cal_ratio(x_out.data{3}(:,1),x_out.deltat,2e3);
save([filemat(1:end-4),'_r.mat'],'Delta','re','Peaks','ratio_a','-v7.3');
save(filemat,'x_out','-v7.3');
