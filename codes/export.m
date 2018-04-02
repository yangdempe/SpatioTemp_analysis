function export(filein)
close all
h=openfig(filein);
% set(h,'InvertHardcopy','off',...
%       'PaperOrientation','landscape',...
%       'PaperUnits','normalized');
% saveas(h,[filein(1:end-4),'.pdf']);
saveas(h,[filein(1:end-4),'.tif'],'tiff');
clear
