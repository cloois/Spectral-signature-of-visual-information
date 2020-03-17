function peer_MUA_rate(cfg)

% use sessions_trl.m to get sessions and offset
%
% rawdir = '/mnt/hps/department1/Sergio2/Sergio2/data/';
% peerdir = '/mnt/hps/home/lewisc/public/bruss/TFR/';
%
% cfg = [];
% for k = 1:length(session)
% cfg{k}.dir = strcat(rawdir,session{k},'/');
% cfg{k}.session = session{k};
% cfg{k}.offset = offset;
% cfg{k}.savename = strcat(peerdir,session{k},'_TFR_wave');
% end
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_TFR,cfg,'memreq',1024,'timreq',1024,'queue','8GB')


cd(cfg.dir)
[lfp, spike, stm, bhv] = spass2fieldtrip(cfg.session);

c.offset = cfg.offset;
lfp = ft_redefinetrial(c,lfp);

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
powCfg.toi        = -0.2:0.01:0.8;
powCfg.pad        = 'maxperlen';
powCfg.t_ftimwin  = 0.5*ones(length(powCfg.foi),1);
powCfg.tapsmofrq  = 2*ones(length(powCfg.foi),1);
powCfg.channel    = 1:length(spike.label);
powCfg.keeptrials = 'yes';
else
powCfg = [];
powCfg.method = 'mtmconvol';
powCfg.output = 'pow';
powCfg.taper = 'dpss';
powCfg.toi        = -0.2:0.01:0.8;
powCfg.foi          = 1:1:215;
powCfg.t_ftimwin    = 3./powCfg.foi;  % 7 cycles per time window
powCfg.tapsmofrq  = 0.5 *powCfg.foi
powCfg.channel    = 1:length(spike.label);
powCfg.keeptrials = 'yes';
powCfg.pad = 8; % 'maxperlen';
end

freq = ft_freqanalysis(powCfg,lfp);
freq.stm = stm;

save(cfg.savename,'freq')

end