function peer_MUA_timeWin_bayes(cfg)

% use sessions_trl.m to get sessions
%
% peerdir = '/mnt/hps/home/lewisc/public/bruss/';
%
% cfg = [];
% for k = 1:length(session)
% cfg{k}.input = strcat(peerdir,'preproc/',session{k},'_preproc');
% cfg{k}.train = 0.80;
% cfg{k}.iter = 10;
% cfg{k}.ori  = 1; % 0 = dir , 1 = ori
% cfg{k}.savename = strcat(peerdir,'bayes/',session{k},'_MUA_timwin_ori_decode');
% end
%
% cd /mnt/hpx/slurm/lewisc/
% qsubcellfun(@peer_MUA_timeWin_bayes,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

load(cfg.input)

if (length(sdf.label)<2)
  save(strcat(cfg.savename,'_ONECHAN'),'bhv')
else
  
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
  
  
  for tw=1:215
    win=3/(tw+1);
    c= [];
    c.timwin  = [-win/2 win/2];
    c.latency     = [-0.2 0.8];
    c.fsample = 1000; % sample at 1000 hz
    sdf = ft_spikedensity(c,spikeTrials);
    
    
    %   condition data NaNs = rand
    sdf.trial(isnan(sdf.trial(:)))=rand(sum(isnan(sdf.trial(:))),1);
    sdf.trial(sdf.trial(:)==0)=rand(sum(sdf.trial(:)==0),1);
    
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
        condCmat(tw,kk,j,:,:) = confusionmat(testSet,condPred);
        condPerf(tw,kk,j,:) = sum(diag(squeeze(condCmat(tw,kk,j,:,:))))/sum(sum(condCmat(tw,kk,j,:,:)));
      end
    end
  end
    save(cfg.savename,'condCmat','condPerf')
  end
end

