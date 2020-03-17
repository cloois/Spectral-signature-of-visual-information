function peer_preproc_lfp_spike(cfg)

% use sessions_trl.m to get sessions and offset
%
% rawdir = '/mnt/hpx/department1/Sergio2/Sergio2/data/';
% peerdir = '/mnt/hpx/home/lewisc/public/bruss/preproc/';
%
% cfg = [];
% for k = 1:length(session)
% cfg{k}.dir = strcat(rawdir,session{k},'/');
% cfg{k}.session = session{k};
% cfg{k}.offset = offset;
% cfg{k}.savename = strcat(peerdir,session{k},'_preproc');
% end
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_preproc_lfp_spike,cfg,'memreq',1024,'timreq',1024,'queue','8GB')


cd(cfg.dir)
[lfp, spike, stm, bhv] = spass2fieldtrip(cfg.session);

c = [];
c.offset = cfg.offset;
lfp = ft_redefinetrial(c,lfp);

c = [];
c.trl = lfp.cfg.previous.trl;
c.trl(:,3) = lfp.cfg.offset;
c.trlunit = 'samples';
c.hdr = lfp.hdr;
c.hdr.Fs = lfp.fsample;

spikeTrials = ft_spike_maketrials(c,spike);

c             = [];
c.binsize     =  0.05; % if cfgPsth.binsize = 'scott' or 'sqrt', we estimate the optimal bin size from the data itself
c.outputunit  = 'rate'; % give as an output the firing rate
c.latency     = [-0.3 0.8];
c.vartriallen = 'yes'; % variable trial lengths are accepted
c.keeptrials  = 'yes'; % keep the psth per trial in the output

psth = ft_spike_psth(c,spikeTrials);

c            = [];
c.latency     = [-0.3 0.8];
c.keeptrials = 'yes';

rate = ft_spike_rate(c,spikeTrials);

[nc.R,nc.P] = corrcoef(rate.trial)

c         = [];
c.timwin  = [-0.025 0.025];
c.latency     = [-0.2 0.8];
c.fsample = 1000; % sample at 1000 hz
sdf = ft_spikedensity(c,spikeTrials);


save(cfg.savename,'lfp','spikeTrials','psth','rate','nc','stm','bhv','sdf')

end