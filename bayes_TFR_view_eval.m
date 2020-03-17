%load('/mnt/hps/slurm/lewisc/all_cond_freq_trls')
pele_visualchans
load /mnt/hps/home/lewisc/public/pele/retino/pele_rfp01_positions.mat

[the  r] = cart2pol(poss(:,1),poss(:,2));
[lth thi] = sort(the);
[l ri] = sort(r);


all_cond_freq_trls = [];
cond_trl = [];
for i=1:60
load(sprintf('/mnt/hps/home/lewisc/public/pele/retino/tfr/data_pos%02i_tfr_trials.mat',i))
all_cond_freq_trls = cat(1,all_cond_freq_trls,freq.powspctrm(:,:,1:100,22:end));
cond_trl_num(i) = size(freq.powspctrm,1);
cond_trl = cat(1,cond_trl,i * ones(cond_trl_num(i),1));
end

cond = unique(cond_trl);
[minTRL minCond] = min(cond_trl_num);
pct_train = 0.8;
examplar = round(minCond.*pct_train);

cond_trl = cond_all;

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


%% old only split data in two...

for i = 1:100
for j = 1:length(freq.time)
cond_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(1:2:end,:,i,j)),cond_trl(1:2:end));
cond_pred = cond_class.predict(squeeze(all_cond_freq_trls(2:2:end,:,i,j)));
cond_cmat(i,j,:,:) = confusionmat(cond_trl(2:2:end),cond_pred);
cond_perf_spec(i,j,:) = sum(diag(squeeze(cond_cmat(i,j,:,:))))/sum(sum(cond_cmat(i,j,:,:)));
end
end

all_cond_freq_trls = [];
for i=1:60
load(sprintf('/mnt/hps/home/lewisc/public/pele/retino/tfr/data_pos%02i_tfr_trials.mat',i))
all_cond_freq_trls = cat(1,all_cond_freq_trls,freq.powspctrm(:,:,101:200,:));
end
cond_perf_all = cond_perf_spec;
for i = 1:100
for j = 1:length(freq.time)
cond_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(1:2:end,:,i,j)),cond_trl(1:2:end));
cond_pred = cond_class.predict(squeeze(all_cond_freq_trls(2:2:end,:,i,j)));
cond_cmat(i,j,:,:) = confusionmat(cond_trl(2:2:end),cond_pred);
cond_perf_spec(i,j,:) = sum(diag(squeeze(cond_cmat(i,j,:,:))))/sum(sum(cond_cmat(i,j,:,:)));
end
end
cond_perf_all = cat(1,cond_perf_all,cond_perf_spec);


figure; surf(cond_perf)
figure; imagesc(time,freq,cond_perf); set(gca,'YDir','normal')
 title('all conditions')
 
for i = 1:60
subplot(2,1,1); hold off;  plot(poss(:,1),poss(:,2),'.'); hold on
scatter(poss(:,1),poss(:,2),cond_cmat(1,33,i,:)*20+1,'r','filled')
plot(poss(i,1),poss(i,2),'k*');
subplot(2,1,2); hold off;  plot(poss(:,1),poss(:,2),'.'); hold on
scatter(poss(:,1),poss(:,2),cond_cmat(1,33,:,i)*20+1,'r','filled')
plot(poss(i,1),poss(i,2),'k*');
pause
end


%% evaluate across all time, for each freq - see the decoding spectrum

all_cond_freq_trls = [];
for i=1:60
load(sprintf('/mnt/hps/home/lewisc/public/pele/retino/tfr/data_pos%02i_tfr_trials.mat',i))
all_cond_freq_trls = cat(1,all_cond_freq_trls,freq.powspctrm(:,:,1:100,22:end));
cond_trl_num(i) = size(freq.powspctrm,1);
end

for i = 1:100
cond_class = NaiveBayes.fit(reshape(squeeze(all_cond_freq_trls(1:2:end,:,i,:)),[],size(all_cond_freq_trls,2)*size(all_cond_freq_trls,4)),cond_trl(1:2:end));
cond_pred = cond_class.predict(reshape(squeeze(all_cond_freq_trls(2:2:end,:,i,:)),[],size(all_cond_freq_trls,2)*size(all_cond_freq_trls,4)));
cond_cmat(i,:,:) = confusionmat(cond_trl(2:2:end),cond_pred);
cond_perf_spec(i,:) = sum(diag(squeeze(cond_cmat(i,:,:))))/sum(sum(cond_cmat(i,:,:)));
end

all_cond_freq_trls = [];
for i=1:60
load(sprintf('/mnt/hps/home/lewisc/public/pele/retino/tfr/data_pos%02i_tfr_trials.mat',i))
all_cond_freq_trls = cat(1,all_cond_freq_trls,freq.powspctrm(:,:,101:200,:));
end

cond_perf_all = cond_perf_spec;
cond_cmat_all = cond_cmat;

for i = 1:100
cond_class = NaiveBayes.fit(reshape(squeeze(all_cond_freq_trls(1:2:end,:,i,:)),[],size(all_cond_freq_trls,2)*size(all_cond_freq_trls,4)),cond_trl(1:2:end));
cond_pred = cond_class.predict(reshape(squeeze(all_cond_freq_trls(2:2:end,:,i,:)),[],size(all_cond_freq_trls,2)*size(all_cond_freq_trls,4)));
cond_cmat(i,:,:) = confusionmat(cond_trl(2:2:end),cond_pred);
cond_perf_spec(i,:) = sum(diag(squeeze(cond_cmat(i,:,:))))/sum(sum(cond_cmat(i,:,:)));
end

cond_perf_all = cat(1,cond_perf_all,cond_perf_spec);
cond_cmat_all = cat(1,cond_cmat_all,cond_cmat);

