L=120;  lx=0.5; 
sigma=6;
nulims=[1.8,4.4];

xi=(-(L/2-1/2):(L/2-1/2)).*lx; % lx= 0.5 cm

[X,Y]=meshgrid(xi,xi);
ri=sqrt(X.*X+Y.*Y);

fr=exp(-ri.^2./sigma^2);
nus=(nulims(2)-nulims(1)).*fr+nulims(1);

figure(1)
surfc(X,Y,nus)
shading flat
