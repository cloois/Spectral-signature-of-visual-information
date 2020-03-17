function peer_bandpass_bruss(cffg)

lfp = [];

load(cffg.inputfile)

%bandpass filtering parameters
cfg = [];
cfg.bpfilter = 'yes';
cfg.bpfiltord = 2;
cfg.bpfilttype = 'but';
cfg.bpfiltdir = 'onepass';

c = [];
c.toilim = [-0.25 0.85]
lfp = ft_redefinetrial(c,lfp);

c = [];
c.detrend = 'yes';
lfp = ft_preprocessing(c,lfp);

c = [];
c.demean = 'yes';
c.channel = 1:length(spikeTrials.label);
lfp = ft_preprocessing(c,lfp);

% normalize
for j = 1:length(lfp.trial)
    lfp.trial{j} = ft_preproc_standardize(lfp.trial{j});
end
  
data_orig = lfp;

for band_indx = 1:length(cffg.bands)
  lfp = [];
  
  %bandpass
  cfg.bpfreq = cffg.bpfreq{band_indx};
  
  % get power
  if (cffg.power)    
    cfg.hilbert = 'abs';    
  end
  
  lfp = ft_preprocessing(cfg, data_orig);
  
  c = [];
  c.toilim = [-0.2 0.8]
  lfp = ft_redefinetrial(c,lfp);

  lfp.stm = stm;
  save_name = strcat(cffg.savename,'_',cffg.bands{band_indx},'.mat');
  save(save_name,'lfp','-V6')
end
end