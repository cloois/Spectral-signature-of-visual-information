function peer_single_chan_naivebayes(cfg)

% load /mnt/hps/home/lewisc/public/pele/retino/pele_retino_cond_trls.mat
%
% cfg = [];
% for i = 1:100 % number of reps
%   cfg{i}.input = '/mnt/hps/slurm/lewisc/all_cond_freq_trls'; % /mnt/hps/slurm/lewisc/all_cond_freq_trls_v4
%   cfg{i}.chan = v1_ind; % v4_ind
%   cfg{i}.time = 28:34; % kurt is freq.time(17:23)
%   cfg{i}.foi = 1:200;
%   cfg{i}.cond_trl = cond_trl;
%   cfg{i}.savename = sprintf('/mnt/hps/home/lewisc/public/pele/retino/naive/v1_singlechan_%02i_perf',i);
% end 
%   
%    cd /mnt/hps/slurm/lewisc/
  %  qsubcellfun(@peer_single_chan_naivebayes,cfg,'memreq',1024,'timreq',1024,'queue','12GB')
  
load(cfg.input)


% 80/20 train/test split
trls = size(all_cond_freq_trls,1);
traintrl = int32(trls*0.8);
testtrl = int32(trls*0.2);

reset(RandStream.getDefaultStream,sum(100*clock));   
shuff = randperm(trls);
  
  for i = 1:length(cfg.chan)
    cond_class = NaiveBayes.fit(reshape(all_cond_freq_trls(shuff(1:traintrl),i,:,:),[traintrl length(cfg.time)*length(cfg.foi)]),cfg.cond_trl(shuff(1:traintrl)));
    cond_pred = cond_class.predict(reshape(all_cond_freq_trls(shuff(traintrl+1:end),i,:,:),[length(shuff(traintrl+1:end)) length(cfg.time)*length(cfg.foi)]));
    cond_cmat(i,:,:) = confusionmat(cfg.cond_trl(shuff(traintrl+1:end)),cond_pred);
    cond_perf_spec(i,:) = sum(diag(squeeze(cond_cmat(i,:,:))))/sum(sum(cond_cmat(i,:,:)));
  end

save(cfg.savename,'cond_cmat','cond_perf_spec','shuff','-v6')

end
