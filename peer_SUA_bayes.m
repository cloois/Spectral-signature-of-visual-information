function peer_SUA_bayes(cfg)
% use sessions_trl.m to get sessions
%
% peerdir = '/mnt/hpx/home/lewisc/public/bruss/';
%
% cfg = [];
% for k = 1:length(session)
% cfg{k}.input = strcat(peerdir,'SUA/',session{k});
% cfg{k}.train = 0.80;
% cfg{k}.iter = 10;
% cfg{k}.ori  = 1;
% cfg{k}.savename = strcat(peerdir,'bayes/',session{k},'_SUA_Ori_decode');
% end
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_MUA_bayes,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

load(cfg.input)

if (length(spikeTrials)<2)
  save(strcat(cfg.savename,'_ONECHAN'),'stm')
else
  
  % condition data NaNs = rand
  sdf_ = sdf{1}
  
  if (length(sdf_.label)>=4)
    sdf_.trial = sdf_.trial(:,4,:);
    sdf_.labelnew{1} = sdf_.label{4};
  else
  end
  
  for k=2:length(sdf);
    if (length(sdf_.label)>=4)
      sdf_.trial(:,k,:) = sdf{k}.trial(:,4,:);
      sdf_.labelnew{k} = sdf{k}.label{4};
    else
      sdf_.trial = sdf{k}.trial(:,1,:);
      sdf_.labelnew{1} = sdf{k}.label{1};
    end
  end
  
  sdf_old = sdf;
  sdf = sdf_;
  sdf.trial(isnan(sdf.trial(:)))=rand(sum(isnan(sdf.trial(:))),1);
  sdf.trial(sdf.trial(:)==0)=rand(sum(sdf.trial(:)==0),1);
  
  if (cfg.ori)
    conds = mod(stm,8);
    cond = unique(conds);
  else
    conds = stm;
    cond = unique(conds);
  end
  
  
  for i = 1:length(unique(conds))
    cond_cnt(i) = sum(conds==cond(i));
    cond_trl{i} = find(conds==cond(i));
  end
  
  minCond = min(cond_cnt);
  examplar = round(minCond.*cfg.train);
  
  for kk = 1:cfg.iter
    trainSet = [];
    testSet = [];
    trainCond = [];
    testCond = [];
    for k=1:length(cond)
      cond_all{k} = randsample(cond_trl{k},length(cond_trl{k}));
      trainSet = cat(1,trainSet,ones(examplar,1)*k);
      testSet = cat(1,testSet,ones(length(cond_trl{k})-examplar,1)*k);
      trainCond = cat(1,trainCond,cond_all{k}(1:examplar));
      testCond = cat(1,testCond,cond_all{k}(examplar+1:end));
    end
    
    for j = 1:length(sdf.time)
      condClass = NaiveBayes.fit(squeeze(sdf.trial(trainCond,:,j)),trainSet);
      condPred = condClass.predict(squeeze(sdf.trial(testCond,:,j)));
      condCmat(kk,j,:,:) = confusionmat(testSet,condPred);
      condPerf(kk,j,:) = sum(diag(squeeze(condCmat(kk,j,:,:))))/sum(sum(condCmat(kk,j,:,:)));
    end
  end
  
  save(strcat(cfg.savename,int2str(size(sdf.trial,2)),'chans'),'sdf','sdf_old','condCmat','condPerf')
end
end

