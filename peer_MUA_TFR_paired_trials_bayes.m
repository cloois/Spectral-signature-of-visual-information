function peer_MUA_TFR_paired_trials_bayes(cfg)

% use sessions_trl.m to get sessions
%
% peerdir = '/mnt/hpx/home/lewisc/public/bruss/';
%
% cfg = [];
% for k = 1:length(session)
% cfg{k}.input = strcat(peerdir,'TFR/',session{k}(1:9),'_TFR_hann');
% cfg{k}.inputSPK = strcat(peerdir,'preproc/',session{k}(1:9),'_preproc');
% cfg{k}.train = 0.80;
% cfg{k}.iter = 10;
% cfg{k}.ori  = 1;
% cfg{k}.foi  = 100;
% cfg{k}.toi  = 1;
% cfg{k}.time = 1;
% cfg{k}.freqs  = 1;
% cfg{k}.savename = strcat(peerdir,'bayes/',session{k},'_MUA_TFR_paired_ORI_decode');
% end
%
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_MUA_TFR_paired_trials_bayes,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

load(cfg.input)
load(cfg.inputSPK)

bhv = 0;

if (length(freq.label)<2)
  save(strcat(cfg.savename,'_ONECHAN'),'bhv')
else
  
  % condition data NaNs = rand
  freq.powspctrm(isnan(freq.powspctrm(:)))=rand(sum(isnan(freq.powspctrm(:))),1);
  freq.powspctrm(freq.powspctrm(:)==0)=rand(sum(freq.powspctrm(:)==0),1);
  
  sdf.trial(isnan(sdf.trial(:)))=rand(sum(isnan(sdf.trial(:))),1);
  sdf.trial(sdf.trial(:)==0)=rand(sum(sdf.trial(:)==0),1);
  
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
  
  testSet_append = [];
  condPredSPK_append = [];
  condPredFRQ_append = [];
  
  for kk = 1:cfg.iter
    trainSet = [];
    testSet = [];
    trainCond = [];
    testCond = [];
    
    for k=1:length(cond)
      cond_all{k} = randsample(cond_trl{k},length(cond_trl{k}));
      trainSet = cat(1,trainSet,ones(examplar,1)*k);
      testSet = cat(1,testSet,ones(length(cond_trl{k})-examplar,1)*k);
      testSet_append = cat(1,testSet_append,ones(length(cond_trl{k})-examplar,1)*k);
      trainCond = cat(1,trainCond,cond_all{k}(1:examplar));
      testCond = cat(1,testCond,cond_all{k}(examplar+1:end));
    end
    
    if cfg.time
      for k = 1:length(sdf.time)
        condClassSPK = NaiveBayes.fit(squeeze(sdf.trial(trainCond,:,k)),trainSet);
        condPredSPK = condClassSPK.predict(squeeze(sdf.trial(testCond,:,k)));
        condPredSPK_append(kk,k,:) = condPredSPK;
        condCmatSPK(kk,k,:,:) = confusionmat(testSet,condPredSPK);
        condPerfSPK(kk,k,:) = sum(diag(squeeze(condCmatSPK(kk,k,:,:))))/sum(sum(condCmatSPK(kk,k,:,:)));
        
        
        if cfg.freqs
          for f = 1:length(freq.freq)
            condClassFRQ = NaiveBayes.fit(squeeze(reshape(freq.powspctrm(trainCond,:,f,k),[length(trainCond) length(freq.label) 1])),trainSet);
            condPredFRQ = condClassFRQ.predict(squeeze(reshape(freq.powspctrm(testCond,:,f,k),[length(testCond) length(freq.label) 1])));
            condPredFRQ_append(kk,f,k,:) = condPredFRQ;
            condCmatFRQ(kk,f,k,:,:) = confusionmat(testSet,condPredFRQ);
            condPerfFRQ(kk,f,k,:) = sum(diag(squeeze(condCmatFRQ(kk,f,k,:,:))))/sum(sum(condCmatFRQ(kk,f,k,:,:)));
          end
        else
          condClassFRQ = NaiveBayes.fit(squeeze(reshape(mean(freq.powspctrm(trainCond,:,cfg.foi,k),3),[length(trainCond) length(freq.label) 1])),trainSet);
          condPredFRQ = condClassFRQ.predict(squeeze(reshape(mean(freq.powspctrm(testCond,:,cfg.foi,k),3),[length(testCond) length(freq.label) 1])));
          condPredFRQ_append(kk,k,:) = condPredFRQ;
          condCmatFRQ(kk,k,:,:) = confusionmat(testSet,condPredFRQ);
          condPerfFRQ(kk,k,:) = sum(diag(squeeze(condCmatFRQ(kk,k,:,:))))/sum(sum(condCmatFRQ(kk,k,:,:)));
        end
      end
    else
      condClassSPK = NaiveBayes.fit(squeeze(sdf.trial(trainCond,:,cfg.toi)),trainSet);
      condPredSPK = condClassSPK.predict(squeeze(sdf.trial(testCond,:,cfg.toi)));
      condPredSPK_append = cat(1,condPredSPK_append,condPredSPK);
      condCmatSPK(kk,:,:) = confusionmat(testSet,condPredSPK);
      condPerfSPK(kk,:) = sum(diag(squeeze(condCmatSPK(kk,:,:))))/sum(sum(condCmatSPK(kk,:,:)));
      
      condClassFRQ = NaiveBayes.fit(squeeze(reshape(mean(freq.powspctrm(trainCond,:,cfg.foi,cfg.toi),3),[length(trainCond) length(freq.label) 1])),trainSet);
      condPredFRQ = condClassFRQ.predict(squeeze(reshape(mean(freq.powspctrm(testCond,:,cfg.foi,cfg.toi),3),[length(testCond) length(freq.label) 1])));
      condPredFRQ_append = cat(1,condPredFRQ_append,condPredFRQ);
      condCmatFRQ(kk,:,:) = confusionmat(testSet,condPredFRQ);
      condPerfFRQ(kk,:) = sum(diag(squeeze(condCmatFRQ(kk,:,:))))/sum(sum(condCmatFRQ(kk,:,:)));
    end
  end
  
  save(cfg.savename,'conds','testSet_append','condPredSPK_append','condPredFRQ_append','condPredSPK','condCmatSPK','condPerfSPK','condCmatFRQ','condPredFRQ','condPerfFRQ','-v7.3')
end
end
