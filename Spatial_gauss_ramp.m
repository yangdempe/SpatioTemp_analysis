function Spatial_gauss_ramp(ID)

load('./corticothalamic-model/p_absence.mat');
%load('/Users/dpyang/Dropbox/Usyd_codes/corticothalamic-model/p_absence.mat');
p=absence.copy();
p.phin=0;       p.re=0.03;
lag=0;        

dy=0.0002;
y1 = [0.017: dy:0.03,  0.03:-dy:0.017];
y2 = [0.043:-dy:0.03,  0.03: dy:0.043];
y  = [y1;y2]; % unit: m

%% spatial setting
L=120;          % grid_edge: 120
N=L*L;          % total nodes
Lx=0.6;         % edge size: 0.6 m
% outputing nodes
gmatrix=zeros(L,L);     gmatrix(1:N)=1:N;   output=gmatrix(L/2,L/2);

%% Parameters: sigma, width of gaussian profile of nu_se 
gprmp=struct('id',9,'pairs',[],'timepoints',[],'sigmas',[],'nu_c',[],'nu_a',[]);

[tps,ys]=ramp_set(lag,y(ID,:),100,10);
gprmp.timepoints =   tps;   %  [50,100];
gprmp.sigmas     =   ys;    %  [0.023 0.023];  
gprmp.nu_c       =   4.4.*1e-3;
gprmp.nu_a       =   1.8e-3;
gprmp.pairs      =   numel(gprmp.timepoints);

int_time = gprmp.timepoints(end);

%% naming configue and output files
fid=ID;    fs=2e4;

subfolder='./GaussProfileRamp';
fprefix=sprintf('%s/re=%.0fmm_gprmp',subfolder,p.re*1e3);
filein=sprintf('%s_%d.conf',fprefix,fid);
filemat=sprintf('%s_%d.mat',fprefix,fid);

%% writing configure file and do simulation, save results
% varargout = write_nf_dpy(p,file_id,firemode,int_time,grid_edge,...
%                           fs,waves,ranseed,fprefix,Lx,CoupleMatrix,...
%                           ramp,profileramp,gaussprofileramp,start,Output)

p.write_nf_dpy(fid,[],int_time,L,...
               fs,[],[],fprefix,Lx,[],...
               [],[],gprmp,lag,output);
 
x_out=nf.run(filein);
save(filemat,'gprmp','x_out','-v7.3');
end

function [tps,ys]=ramp_set(start,y,t_step,ramp_step)

n  =numel(y);
ys=reshape([y;y],1,2*n);

tp_begin=(0:n-1).*t_step;
tp_end  =(1:n).*t_step-ramp_step;
tps=reshape([tp_begin;tp_end],1,2*n)+start;
end
