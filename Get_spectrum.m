itn=15;
fmax=30;    fres=0.04;   bfmax=20;
for sigma=5:0.1:6
    %% calculate
%     fin=sprintf('data/sigma=%.1fcm_itn=%d.mat',sigma,itn);
%     load(fin);
%     cd codes
%     [bfreq,bispec,freq,spec]=Get_powers(x_out,fmax,fres,bfmax);
%     cd ..
%     save(sprintf('data_spec/sigma=%.1fcm_spec.mat',sigma),...
%         'bfreq','bispec','freq','spec');
    
%% ploting
    load(sprintf('data_spec/sigma=%.1fcm_spec.mat',sigma));
    hfig=figure();
    hpos=get(hfig,'Position');
    set(hfig,'Position',hpos.*[1 1 2 1]);
    subplot(1,3,1)
    plot(x_out.time(1:2e3),phie_c(round(sigma*10),1:2e3));
    xlabel('time t (s)')
    ylabel('$\phi_e$ (s$^{-1}$)','interpreter','latex');
    set(gca,'fontsize',15);
    
    % figure for spectrum
    subplot(1,3,2)
    data_spec=spec(1:numel(freq));
    plot(freq,pow2db(abs(data_spec).^2));
    xlim([0,fmax]);
    xlabel('Frequency $f$ (Hz)','interpreter','latex');
    ylabel('Spectrum (dB)')
    title(sprintf('$\\sigma$ = %.1f cm',sigma),'interpreter','latex');
    set(gca,'fontsize',15);
    
    % figure for bispectrum
    subplot(1,3,3)
    m=max(abs(bispec(:)));
    imagesc(bfreq,bfreq,abs(bispec)./m); box on; grid on;
    set(gca,'YDir','normal')
    
    shading flat
    colorbar
    
    xlim([0,bfreq(end)]);
    ylim([0,bfreq(end)]);
    xlabel('Frequency (Hz)','interpreter','latex'); 
    ylabel('Frequency (Hz)','interpreter','latex');
    title('Bispectrum','interpreter','latex');
    set(gca,'fontsize',15,'clim',[0,1e-2]); 
end
