%% guassian couple strength centered at (0,0)
function nus=gauss2Dprofile(nulims,sigma,L,lx)

xi=(-(L/2-1/2):(L/2-1/2)).*lx; % lx= 0.005 m, L=120
[X,Y]=meshgrid(xi,xi);
ri=sqrt(X.*X+Y.*Y);

fr=exp(-ri.^2./(2.*sigma.^2));        % guassian function with width sigma
nus=(nulims(2)-nulims(1)).*fr+nulims(1);
