function Spatial_gauss_EMG(ID)

load('./corticothalamic-model/p_absence.mat')
p=absence.copy();
p.phin=0;    

%% Parameters: (re,sigma), excitatory axon range,width of gaussian profile of nu_se   
%RE=0.02:0.002:0.16;      % unit: m
%SIGMA=0.02:0.001:0.03;    % unit: m
%[RE,SIGMA]=meshgrid(RE,SIGMA);

p.re=0.03;  %RE(ID);

k1 = 0.0656/0.08;
k2 = 0.08/0.0583;
Min_sigma = max(floor(k1*p.re*1e4)*1e-4,0.01);
Max_sigma = min(ceil(k2*p.re*1e4)*1e-4,0.064);
sigma1 = Min_sigma:1e-4:Max_sigma;
SIGMA  = sigma1(abs(sigma1*1e3-round(sigma1*1e3))>0.05);
sigma  = SIGMA(ID); 

%% Lattice setting
L=120;          % grid_edge: 120
N=L*L;          % total nodes
Lx=0.6;         % edge size: 0.6 m
lx=Lx/L;        % spatial resolution: lx=0.005 m

%% setting coupling matrix with lesion
nu_a=1.8e-3;    nu_c=4.4e-3;
CoupleMatrix=struct('id',4,'nus',gauss([nu_a,nu_c],sigma,L,lx));

%% integration time including lag time, unit: second
lag=100;    n=22;       int_time=lag+(2^n).*1e-3;

%% naming configue and output files
fid=ID;    fs=2e3;

folder='Gauss_profile/For_EMG';
fprefix=sprintf('%s/re=%.0fmm_sigma=%.1fmm_Itn=%d',folder,p.re*1e3,sigma*1e3,n);
filein=sprintf('%s_%d.conf',fprefix,fid);
filemat=sprintf('%s.mat',fprefix);

%% setting simulation output
gmatrix=zeros(L,L);     gmatrix(1:N)=1:N;
output=gmatrix(L/2,L/2);

%% writing configure file and do simulation, save results
% varargout = write_nf_dpy(p,file_id,firemode,int_time,grid_edge,...
%                           fs,waves,ranseed,fprefix,Lx,CoupleMatrix,...
%                           ramp,profileramp,start,Output)

p.write_nf_dpy(fid,[],int_time,L,...
               fs,[],[],fprefix,Lx,CoupleMatrix,...
               [],[],[],lag,output);
x_out=nf.run(filein);
save(filemat,'L','Lx','lx','p','lag','fs','CoupleMatrix','x_out','-v7.3');

%% guassian couple strength centered at (0,0)
function nus=gauss(nulims,sigma,L,lx)

xi=(-(L/2-1/2):(L/2-1/2)).*lx; % lx= 0.005 m, L=120
[X,Y]=meshgrid(xi,xi);
ri=sqrt(X.*X+Y.*Y);

fr=exp(-ri.^2./(2.*sigma.^2));        % guassian function with width sigma
nus=(nulims(2)-nulims(1)).*fr+nulims(1);
