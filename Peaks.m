%% function for catch peaks of bifurcations.
function phie_peaks=Peaks(x,rmp,window,np)
%pick up all stable local peaks
fs=round(1./x.deltat);  % point number in 1s;
segsize=window*fs-1;
n=rmp.pairs/2;
phie_peaks=cell(n,3);
for j=1:n
    phie_peaks{j,1}=rmp.sigmas(2*j);
    
    seg=int64(rmp.timepoints(2*j)*fs+(-segsize:0));
    data=x.data{1}(seg,1);
    
    phie_peaks{j,2}=findpeaks(data);
    phie_peaks{j,3}=-findpeaks((-1).*data);
    
    if length(phie_peaks{j,2})>np, phie_peaks{j,2}(1:end-np)=[];   end
    if isempty(phie_peaks{j,2}),   phie_peaks{j,2}(1)=data(end);   end
    
    if length(phie_peaks{j,3})>np, phie_peaks{j,3}(1:end-np)=[];   end
    if isempty(phie_peaks{j,3}),   phie_peaks{j,3}(1)=data(end);   end
end

end
