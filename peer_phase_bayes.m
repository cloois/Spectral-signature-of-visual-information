function peer_phase_bayes(cfg)

% use sessions_trl.m to get sessions
%
% peerdir = '/mnt/hps/home/lewisc/public/bruss/';
%
% cfg = [];
% for k = 1:length(session)
% cfg{k}.input = strcat(peerdir,'TFR/',session{k},'_TFR_wave_1ms_3');
% cfg{k}.train = 0.80;
% cfg{k}.iter = 10;
% cfg{k}.ori  = 1;
% cfg{k}.savename = strcat(peerdir,'bayes/',session{k},'_phase_wave_1ms3_Dir_decode');
% end
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_phase_bayes,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

load(cfg.input)

bhv = 0;

if (length(freq.label)<2)
  save(strcat(cfg.savename,'_ONECHAN'),'bhv')
else
  
  % condition data NaNs = rand
freq.powspctrm(isnan(freq.powspctrm(:)))=rand(sum(isnan(freq.powspctrm(:))),1);
freq.powspctrm(freq.powspctrm(:)==0)=rand(sum(freq.powspctrm(:)==0),1);

if (cfg.ori)
conds = mod(freq.stm,8);
cond = unique(conds);
else
conds = freq.stm;
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
  
  for l = 1:length(freq.freq)
    for j = 1:length(freq.time)
      cond_class = NaiveBayes.fit(squeeze(freq.powspctrm(cond_train,:,l,j)),image_train);
      cond_pred = cond_class.predict(squeeze(freq.powspctrm(cond_test,:,l,j)));
      cond_cmat(kk,l,j,:,:) = confusionmat(image_test,cond_pred);
      cond_perf_spec(kk,l,j,:) = sum(diag(squeeze(cond_cmat(kk,l,j,:,:))))/sum(sum(cond_cmat(kk,l,j,:,:)));
    end
  end
end

save(cfg.savename,'cond_cmat','cond_perf_spec','-v7.3')
end
end
