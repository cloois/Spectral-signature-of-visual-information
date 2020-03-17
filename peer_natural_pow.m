function peer_natural_pow(cfg)

%   cfg = [];
% 
%   cfg{1}.name = '/mnt/hps/home/lewisc/public/pele/natural/Pele_080.mat';
%   cfg{1}.savename = '/mnt/hps/home/lewisc/public/pele/natural/Pele_080_pre_dpss.mat';
%   cfg{2}.name = '/mnt/hps/home/lewisc/public/pele/natural/Pele_096.mat';
%   cfg{2}.savename = '/mnt/hps/home/lewisc/public/pele/natural/Pele_096_pre_dpss.mat';
%   cfg{3}.name = '/mnt/hps/home/lewisc/public/kaas/natural/Kaas_018.mat';
%   cfg{3}.savename = '/mnt/hps/home/lewisc/public/kaas/natural/Kaas_018_pre_dpss.mat';
%   cfg{4}.name = '/mnt/hps/home/lewisc/public/kaas/natural/Kaas_022.mat';
%   cfg{4}.savename = '/mnt/hps/home/lewisc/public/kaas/natural/Kaas_022_pre_dpss.mat';
%   
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_natural_pow,cfg,'memreq',1024,'timreq',1024,'queue','8GB')


load(cfg.name);

c = [];
c.channel = 3:76;
c.detrend = 'yes';
data = ft_preprocessing(c,data);

for k = 1:length(data.trial)
  data.trial{k} = ft_preproc_standardize(data.trial{k});
end

pow_cfg = [];
pow_cfg.method = 'mtmconvol';
pow_cfg.output = 'pow';
pow_cfg.taper = 'hanning'; %'hanning'; % dpss;

pow_cfg.toi          = -0.5:0.01:1.4;
pow_cfg.foi          = 1:1:200;

pow_cfg.t_ftimwin  = 0.3*ones(length(pow_cfg.foi),1);
%pow_cfg.t_ftimwin  = 3./pow_cfg.foi;

pow_cfg.tapsmofrq  = 5 *ones(length(pow_cfg.foi),1);
%pow_cfg.tapsmofrq  = 0.2 .* pow_cfg.foi;

pow_cfg.keeptrials = 'yes';
pow_cfg.pad =  'maxperlen';


freq = ft_freqanalysis(pow_cfg,data);

save(cfg.savename,'freq','-v7.3') 

end
