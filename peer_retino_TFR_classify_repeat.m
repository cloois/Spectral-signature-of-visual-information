function peer_retino_TFR_classify_repeat(cfg)

% a = ft_channelselection(vis_uni,freq.label);
% [tmp ib ia] = intersect(a,freq.label);
% time = 1:241;
% 
% cfg = [];
% for k = 1:length(time)
% cfg{k}.peerdir = '/mnt/hps/home/lewisc/public/kurt/retino/unipolar/cond/';
% cfg{k}.time = k;
% cfg{k}.pos = 1:60;
% cfg{k}.chan = ia;
% cfg{k}.train = 20;
% cfg{k}.iter = 100;
% cfg{k}.savename = strcat('/mnt/hps/home/lewisc/public/kurt/retino/unipolar/TFRclassify/time_',int2str(k));
% end
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_retino_TFR_classify_repeat,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

cond_trl = [];
all_cond_freq_trls = [];

rng('shuffle')
readorder = randsample(cfg.pos,length(cfg.pos));

for k = 1:length(cfg.pos)
%  load(strcat(cfg.peerdir,'ku_rfpbf_',int2str(readorder(k)),'_hanning'))
load(strcat(cfg.peerdir,'ku_rfpbf_',int2str(readorder(k)),'_TFR_wave'))

  cond_trl = cat(1,cond_trl,readorder(k) * ones(size(freq.powspctrm,1),1));
  cond_count(readorder(k)) = size(freq.powspctrm,1);
  cond{readorder(k)} = find(cond_trl==readorder(k));
 
%  all_cond_freq_trls = cat(1,all_cond_freq_trls,squeeze(freq.powspctrm(:,cfg.chan,:,cfg.time)));
  all_cond_freq_trls = cat(1,all_cond_freq_trls,squeeze(freq.powspctrm(:,:,:,cfg.time)));
end


minCond = min(cond_count);
examplar = round(minCond.*cfg.train);

for l = 1:cfg.iter
train = [];
test = [];
cond_train = [];
cond_test = [];
  for k=1:length(cfg.pos)
  cond_all{k} = randsample(cond{k},length(cond{k}));
  train = cat(1,train,ones(examplar,1)*k);
  test = cat(1,test,ones(length(cond{k})-examplar,1)*k);
  cond_train = cat(1,cond_train,cond_all{k}(1:examplar));
  cond_test = cat(1,cond_test,cond_all{k}(examplar+1:end));
end

% train models

  for j = 1:length(freq.freq)
cond_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(cond_train,:,j)),train);
cond_pred = cond_class.predict(squeeze(all_cond_freq_trls(cond_test,:,j)));
cond_cmat(l,j,:,:) = confusionmat(test,cond_pred);
cond_perf_spec(l,j,:) = sum(diag(squeeze(cond_cmat(l,j,:,:))))/sum(sum(cond_cmat(l,j,:,:)));
  end
end
save(cfg.savename,'cond_cmat','cond_perf_spec')
end