
sessions_all = {
'lil025a07_TFR_wave_1ms_decode'
'lil025a06_TFR_wave_1ms_decode'
'lil024a04_TFR_wave_1ms_decode'
'lil025a05_TFR_wave_1ms_decode'
'lil026a01_TFR_wave_1ms_decode'
'nic002a04_TFR_wave_1ms_decode'
'lil026a02_TFR_wave_1ms_decode'
'lil027a10_TFR_wave_1ms_decode'
'lil024a05_TFR_wave_1ms_decode'
'lil027a06_TFR_wave_1ms_decode'
'lil027a08_TFR_wave_1ms_decode'
'lil027a09_TFR_wave_1ms_decode'
'lil025a03_TFR_wave_1ms_decode'
'jeb008a02_TFR_wave_1ms_decode'
'lil027a07_TFR_wave_1ms_decode'
'lil025a04_TFR_wave_1ms_decode'
'lil027a11_TFR_wave_1ms_decode'
'lil025a02_TFR_wave_1ms_decode'
'lil029a03_TFR_wave_1ms_decode'
'lil025a01_TFR_wave_1ms_decode'
'lil027a04_TFR_wave_1ms_decode'
'lil029a01_TFR_wave_1ms_decode'
'lil032a03_TFR_wave_1ms_decode'
'lil030a03_TFR_wave_1ms_decode'
'lil028b03_TFR_wave_1ms_decode'
'lil028a01_TFR_wave_1ms_decode'
'lil031a01_TFR_wave_1ms_decode'
'lil032a02_TFR_wave_1ms_decode'
'lil028a03_TFR_wave_1ms_decode'
'lil028b02_TFR_wave_1ms_decode'
'lil028c01_TFR_wave_1ms_decode'
'jeb024a01_TFR_wave_1ms_decode'
'lil029a04_TFR_wave_1ms_decode'
'nic018a02_TFR_wave_1ms_decode'
'lil030a02_TFR_wave_1ms_decode'
'lil028a02_TFR_wave_1ms_decode'
'lil029a05_TFR_wave_1ms_decode'
'jeb008a01_TFR_wave_1ms_decode'
'jeb013a08_TFR_wave_1ms_decode'
'lil029a02_TFR_wave_1ms_decode'
'lil031c01_TFR_wave_1ms_decode'
'nic042a02_TFR_wave_1ms_decode'
'lil031b01_TFR_wave_1ms_decode'
'lil031b02_TFR_wave_1ms_decode'
'lil030a01_TFR_wave_1ms_decode'
'nic033b01_TFR_wave_1ms_decode'
'lil028b01_TFR_wave_1ms_decode'
'nic049a02_TFR_wave_1ms_decode'
'nic043a02_TFR_wave_1ms_decode'
'jeb016a08_TFR_wave_1ms_decode'
'jeb016a09_TFR_wave_1ms_decode'
'jeb014a08_TFR_wave_1ms_decode'
'nic050a02_TFR_wave_1ms_decode'
'jeb013a07_TFR_wave_1ms_decode'
'jeb016a06_TFR_wave_1ms_decode'
'nic059a02_TFR_wave_1ms_decode'
'nic045a03_TFR_wave_1ms_decode'
'jeb015a08_TFR_wave_1ms_decode'
'jeb013a02_TFR_wave_1ms_decode'
'jeb010a02_TFR_wave_1ms_decode'
'jeb011a02_TFR_wave_1ms_decode'
'jeb015a07_TFR_wave_1ms_decode'
'jeb012a02_TFR_wave_1ms_decode'
'jeb025a01_TFR_wave_1ms_decode'
'nic018a03_TFR_wave_1ms_decode'
'jeb023a02_TFR_wave_1ms_decode'
'jeb020a02_TFR_wave_1ms_decode'
'jeb014a07_TFR_wave_1ms_decode'
'jeb022a02_TFR_wave_1ms_decode'
'jeb017a04_TFR_wave_1ms_decode'
'nic057a02_TFR_wave_1ms_decode'
'nic055a02_TFR_wave_1ms_decode'
'nic055a03_TFR_wave_1ms_decode'};

good = [14  32 38 39 50 51 52 54 55 58 59 60 61 62 63 64 66 67 68 69 70 72];

chan={[1:4],[1:3],[1:4],[1:5],[1:5],[1:5],[1:5], [1:5],[1:5],[1:5],[1:5],[1:5],[1:5],[1:5],[1:5],[1:5],[1:5],[1:5],[1:5],[1:5],[1:5],[]};

cfg = [];
c = [];
cfg.keeptrials = 'yes';
c.toilim=[-0.2 0.8];

for j = 1:length(good)
load(strcat('/mnt/hps/home/lewisc/public/bruss/preproc/',sessions_all{good(j)}(1:9),'_preproc'))
lfp_all{j} = lfp;
lfp_all{j}.stm=stm;
cfg.channel=chan{j};
time{j} = ft_timelockanalysis(cfg,lfp_all{j});
time{j} = ft_redefinetrial(c,time{j});
time{j}.stm=stm;
end



%% train models
cfg = [];
cfg.ori = 1;
cfg.train = 0.8;
cfg.iter = 10;

for s=1:length(good)
if (cfg.ori)
conds = mod(time{s}.stm,8);
cond = unique(conds);
else
conds = time{s}.stm;
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
  
  for j = 1:length(time{s}.time)
    condClass = NaiveBayes.fit(squeeze(time{s}.trial(trainCond,:,j)),trainSet);
    condPred = condClass.predict(squeeze(time{s}.trial(testCond,:,j)));
    condCmat(s,kk,j,:,:) = confusionmat(testSet,condPred);
    condPerf(s,kk,j,:) = sum(diag(squeeze(condCmat(s,kk,j,:,:))))/sum(sum(condCmat(s,kk,j,:,:)));
  end
end
end




figure, plot(-0.2:0.001:0.8,squeeze(mean(mean(condPerf_dir))))
hold on; ciplot(squeeze(mean(reshape(condPerf_dir,[],1001)))-(squeeze(std(reshape(condPerf_dir,[],1001)))/sqrt(220)*1.96),squeeze(mean(reshape(condPerf_dir,[],1001)))+(squeeze(std(reshape(condPerf_dir,[],1001)))/sqrt(220)*1.96),-0.2:0.001:0.8)
set(gca,'TickDir','out'), axis([-0.2 0.8 0 0.35]), axis square


figure, plot(-0.2:0.001:0.8,squeeze(mean(mean(condPerf_ori))))
hold on; ciplot(squeeze(mean(reshape(condPerf_ori,[],1001)))-(squeeze(std(reshape(condPerf_ori,[],1001)))/sqrt(220)*1.96),squeeze(mean(reshape(condPerf_ori,[],1001)))+(squeeze(std(reshape(condPerf_ori,[],1001)))/sqrt(220)*1.96),-0.2:0.001:0.8)
set(gca,'TickDir','out'), axis([-0.2 0.8 0 0.35]), axis square


