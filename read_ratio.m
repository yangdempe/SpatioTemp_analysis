function read_ratio()
sigmav=3.41:0.1:5.7; n=numel(sigmav);
ratio=zeros(n,1);
roundup=2e3;
nt=2^22;
As=zeros(n,nt-2*roundup);

for i=1:n
    sigma=sigmav(i);
    filen=sprintf('data2/sigma=%.2fcm_itn=22.mat',sigma);
    load(filen);
    
    A=Cal_ratio(x_out,roundup);
    ratio(i)=sum(sign(A)==1)./numel(A);
    As(i,:)=A;
    
end
save('ratio_alpha.mat','sigmav','ratio','As');