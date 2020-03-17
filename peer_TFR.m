function peer_TFR(cfg)

% use sessions_trl.m to get sessions and offset
%
% rawdir = '/mnt/hpx/department1/Sergio2/Sergio2/data/';
% peerdir = '/mnt/hpx/home/lewisc/public/bruss/';
%
% cfg = [];
% for k = 1:length(session)
% %cfg{k}.hanning = 1;
% cfg{k}.input    = strcat(peerdir,'preproc/',session{k},'_preproc');
% cfg{k}.savename = strcat(peerdir,'TFR/',session{k},'_TFR_wave_1ms_3');
% end
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_TFR,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

lfp = [];
load(cfg.input)

c = [];
c.detrend = 'yes';
lfp = ft_preprocessing(c,lfp);

c = [];
c.demean = 'yes';
lfp = ft_preprocessing(c,lfp);

if (isfield(cfg,'hanning'))
  powCfg = [];
  powCfg.output     = 'pow';
  powCfg.method     = 'mtmconvol';
  powCfg.taper     = 'hanning';
  powCfg.foi        = 1:215;
  powCfg.toi        = -0.2:0.001:0.8;
  powCfg.pad        = 'maxperlen';
 % powCfg.t_ftimwin  = 1*ones(length(powCfg.foi),1);
   powCfg.t_ftimwin  = 1.5./powCfg.foi;
   powCfg.tapsmofrq  = 5*ones(length(powCfg.foi),1);
 % powCfg.channel    = 1:length(spikeTrials.label);
  powCfg.keeptrials = 'yes';
else
  powCfg = [];
  powCfg.method = 'mtmconvol';
  powCfg.output = 'pow';
  powCfg.taper = 'dpss';
  powCfg.toi        = -0.2:0.001:0.8;
  powCfg.foi          = 1:1:215;
  powCfg.t_ftimwin    = 3./powCfg.foi;  % 7 cycles per time window
  powCfg.tapsmofrq  = 0.5*powCfg.foi
%  powCfg.channel    = 1:length(spikeTrials.label);
  powCfg.keeptrials = 'yes';
  powCfg.pad = 8; % 'maxperlen';
end

freq = ft_freqanalysis(powCfg,lfp);
freq.stm = stm;

save(cfg.savename,'freq','-v7.3')

end