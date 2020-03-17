function peer_natural_TFR_classify(cfg)

%
% iter = 20;
% 
% cfg = [];
% for i = 1:iter
% cfg{i}.iter = i;
% cfg{i}.all_cond_trial_tfr = '/mnt/hps/home/lewisc/public/pele/natural/pele_096_natural_TFR.mat';
% cfg{i}.savename = sprintf('/mnt/hps/home/lewisc/public/pele/natural/pele_096_natural_class_%i.mat',i);
% end
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_natural_TFR_classify,cfg,'memreq',1024,'timreq',1024,'queue','12GB')


% train models

load(cfg.all_cond_trial_tfr)

rng('shuffle')

freq.powspctrm(isnan(freq.powspctrm(:)))=rand(sum(isnan(freq.powspctrm(:))),1);

conds = unique(freq.cfg.previous.previous.alltrl(:,4));
 
 for i = 1:length(conds)
  cond_cnt(i) = sum(freq.cfg.previous.previous.alltrl(:,4)==conds(i));
  cond{i} = find(freq.cfg.previous.previous.alltrl(:,4)==conds(i));
 end

 conds = conds(cond_cnt>=10);
 cond = cond(cond_cnt>=10);
 cond_cnt = cond_cnt(cond_cnt>=10);
 
  
image_train = [];
image_test = [];
cond_train = [];
cond_test = [];

for i=1:length(conds)
  cond_all{i} = randsample(cond{i},length(cond{i}));
  image_train = cat(1,image_train,ones(9,1)*i);
  image_test = cat(1,image_test,ones(length(cond{i})-9,1)*i);
  cond_train = cat(1,cond_train,cond_all{i}(1:9));
  cond_test = cat(1,cond_test,cond_all{i}(10:end));
end


  for kk = 1:length(freq.freq)
  for i = 1:length(freq.time)
cond_class = NaiveBayes.fit(squeeze(freq.powspctrm(cond_train,:,kk,i)),image_train);
cond_pred = cond_class.predict(squeeze(freq.powspctrm(cond_test,:,kk,i)));
cond_cmat(kk,i,:,:) = confusionmat(image_test,cond_pred);
cond_perf_spec(kk,i,:) = sum(diag(squeeze(cond_cmat(kk,i,:,:))))/sum(sum(cond_cmat(kk,i,:,:)));
  end
 end
  save(cfg.savename,'cond_cmat','cond_perf_spec');
 end
