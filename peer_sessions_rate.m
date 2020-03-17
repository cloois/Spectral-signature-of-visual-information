function peer_sessions_rate(cffg)
%
% see ~/matlab/noise_correlations/peer_setup.m

cd /mnt/hps/department1/Sergio2/Sergio2/data_nex/data_nex/SU/

for k = 1:length(cffg.chans)

  spike = ft_read_spike(cffg.chans(k).name);
  
%   cfg             = [];
%   cfg.fsample     = spike.hdr.FileHeader.Frequency;
%   cfg.interpolate = 1; % keep the density of samples as is
  %[wave, spikeCleaned] = ft_spike_waveform(cfg,spike);

  spikeTrials{k} = ft_spike_maketrials(cffg,spike);

  
  cfg             = [];
  cfg.binsize     =  0.1; % if cfgPsth.binsize = 'scott' or 'sqrt', we estimate the optimal bin size from the data itself
  cfg.outputunit  = 'rate'; % give as an output the firing rate
 % cfg.latency     = [-1 3]; % between -1 and 3 sec.
  cfg.vartriallen = 'yes'; % variable trial lengths are accepted
  cfg.keeptrials  = 'yes'; % keep the psth per trial in the output
  
  ccfg            = [];
%  ccfg.latency    = [1 1.7]; % sustained response period
  ccfg.keeptrials = 'yes';

  cc         = [];
  cc.timwin  = [-0.025 0.025];
  cc.latency     = [-0.2 0.8];
  cc.fsample = 1000; % sample at 1000 hz

if (cffg.conds)    
   conds = unique(cffg.stm);

  for kk = 1:length(conds)
    
    cfg.trials = find(cffg.stm==kk);
    ccfg.trials = find(cffg.stm==kk);
    c.trials = find(cffg.stm==kk);
    
    spikeTrialsCond{kk} = ft_spike_select(c,spikeTrials{k});
    ppsth{kk} = ft_spike_psth(cfg,spikeTrials{k});
    rrate{kk} = ft_spike_rate(ccfg,spikeTrials{k});
    [nnc{kk}.R,nnc{kk}.P] = corrcoef(rrate{kk}.trial)
  
  end
  
  spikeTrialsConds{k} = spikeTrialsCond;
  psth{k} = ppsth;
  rate{k} = rrate;
  nc{k} = nnc;
else
  psth{k} = ft_spike_psth(cfg,spikeTrials{k});
  rate{k} = ft_spike_rate(ccfg,spikeTrials{k});
  sdf{k}  = ft_spikedensity(cc,spikeTrials{k});

end
  
end
  if (exist('psth'))
  stm = cffg.stm;
  if (cffg.conds)
  save(cffg.savename,'spikeTrials','spikeTrialsConds','psth','rate','nc','stm')
  else
  save(cffg.savename,'spikeTrials','psth','rate','sdf','stm')
  end
  end
end