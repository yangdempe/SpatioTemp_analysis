k1 = 0.0656/0.08;
k2 = 0.08/0.0583;

re=0.03;


Min_sigma = max(floor(k1*re*1e4)*1e-4,0.01);
Max_sigma = min(ceil(k2*re*1e4)*1e-4,0.064);

sigma1 = Min_sigma:0.0001:Max_sigma;
sigma2 = sigma1(abs(sigma1*1e3-round(sigma1*1e3))>0.05);

%scatter3(Para(:,1),Para(:,2),30.*ones(numel(Para(:,1)),1),'r*');
