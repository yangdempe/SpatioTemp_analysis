k1 = 0.0656/0.08;
k2 = 0.08/0.0583;

Para=[];
for re=0.01:0.001:0.07
    Min_sigma = max(floor(k1*re*1e3)*1e-3,0.01);
    Max_sigma = min(ceil(k2*re*1e3)*1e-3,0.064); 
    
    for sigma=Min_sigma:0.001:Max_sigma
        Para=[Para; re, sigma];
    end
end
scatter3(Para(:,1),Para(:,2),30.*ones(numel(Para(:,1)),1),'r*');
