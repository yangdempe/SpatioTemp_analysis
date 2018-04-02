L=120;  lx=0.005; 
nulims=[1.8,4.4].*1e-3;

xi=(-(L/2-1/2):(L/2-1/2)).*lx; % lx= 0.5 cm

figure(1); hold on


sigma=0.03;
fr=exp(-xi.^2./(2.*sigma^2));
nus=(nulims(2)-nulims(1)).*fr+nulims(1);
plot(xi,nus,'r-.')



