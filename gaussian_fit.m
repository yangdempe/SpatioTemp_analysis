sigmav=0.1:0.1:3.4;   n=numel(sigmav);
A5=zeros(n,4);
A5(:,1)=sigmav;
for i=1:n
    sigma=sigmav(i);
    A5(i,2:end)=profile_read(sigma);
end

save('para_5.mat','A5');
    