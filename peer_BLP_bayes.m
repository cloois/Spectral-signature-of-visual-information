function peer_BLP_bayes(cfg)

% use sessions_trl.m to get sessions
%
% peerdir = '/mnt/hps/home/lewisc/public/bruss/';
%
% cfg = [];
% for k = 1:length(good)
% cfg{k}.input = strcat(peerdir,'bandpass/',sessions_all{good(k)}(1:9),'_bndpass');
% cfg{k}.bands = bands;
% cfg{k}.train = 0.90;
% cfg{k}.iter = 5;
% cfg{k}.ori  = 1;
% cfg{k}.savename = strcat(peerdir,'bayes/',sessions_all{good(k)}(1:9),'_BLP_ORI_decode');
% end
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_TFR_bayes,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

freq = [];
for k = 1:length(cfg.bands)
load(strcat(cfg.input,'_',cfg.bands{k},'.mat'))
tmp = permute(reshape(cell2mat(lfp.trial),[length(lfp.label) length(lfp.time{1}) length(lfp.time)]),[3 1 4 2]);
freq = cat(3,freq,tmp);
end

bhv = 0;

if (length(lfp.label)<2)
  save(strcat(cfg.savename,'_ONECHAN'),'bhv')
else
  
  % condition data NaNs = rand
freq(isnan(freq(:)))=rand(sum(isnan(freq(:))),1);
freq(freq(:)==0)=rand(sum(freq(:)==0),1);

if (cfg.ori)
conds = mod(lfp.stm,8);
cond = unique(conds);
else
conds = lfp.stm;
cond = unique(conds);
end

for i = 1:length(unique(conds))
  cond_cnt(i) = sum(conds==cond(i));
  cond_trl{i} = find(conds==cond(i));
end

minCond = min(cond_cnt);
examplar = round(minCond.*cfg.train);

for kk = 1:cfg.iter
  image_train = [];
  image_test = [];
  cond_train = [];
  cond_test = [];
  for k=1:length(cond)
    cond_all{k} = randsample(cond_trl{k},length(cond_trl{k}));
    image_train = cat(1,image_train,ones(examplar,1)*k);
    image_test = cat(1,image_test,ones(length(cond_trl{k})-examplar,1)*k);
    cond_train = cat(1,cond_train,cond_all{k}(1:examplar));
    cond_test = cat(1,cond_test,cond_all{k}(examplar+1:end));
  end
  
  for l = 1:size(freq,3)
    for j = 1:size(freq,4)
      cond_class = NaiveBayes.fit(squeeze(freq(cond_train,:,l,j)),image_train);
      cond_pred = cond_class.predict(squeeze(freq(cond_test,:,l,j)));
      cond_cmat(kk,l,j,:,:) = confusionmat(image_test,cond_pred);
      cond_perf_spec(kk,l,j,:) = sum(diag(squeeze(cond_cmat(kk,l,j,:,:))))/sum(sum(cond_cmat(kk,l,j,:,:)));
    end
  end
end

save(cfg.savename,'cond_cmat','cond_perf_spec','-v7.3')
end
end
