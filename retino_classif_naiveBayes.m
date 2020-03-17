                  
pele_visualchans

% all trials concatenated is here :
% /mnt/hps/slurm/lewisc/pele_all_cond_freq_time_trls_retino.mat
for i=1:60
load(sprintf('/mnt/hps/home/lewisc/public/pele/retino/fft/data_pos%02i_fft_trials.mat',i))
f_all{i} = freq.powspctrm(:,visual,:);
end

load results/positionsPele.mat
[the  r] = cart2pol(poss(:,1),poss(:,2));
[lth thi] = sort(the);
[l ri] = sort(r);

eccs = [1*ones(10,1)' 2*ones(10,1)' 3*ones(10,1)' 4*ones(10,1)' 5*ones(10,1)' 6*ones(10,1)'];
elevs = [1*ones(6,1)' 2*ones(6,1)' 3*ones(6,1)' 4*ones(6,1)' 5*ones(6,1)' 6*ones(6,1)' 7*ones(6,1)' 8*ones(6,1)' 9*ones(6,1)' 10*ones(6,1)'];

elev_trl = [];
ecc_trl = [];
cond_trl = [];

for i = 1:60
ecc_trl = cat(1,ecc_trl,eccs(find(ri==i)) * ones(size(f_all{i},1),1));
elev_trl = cat(1,elev_trl,elevs(find(thi==i)) * ones(size(f_all{i},1),1));
cond_trl = cat(1,cond_trl,i * ones(size(f_all{i},1),1));
end


%% just gamma 
all_cond_trls = [];
for i = 1:60
all_cond_trls = cat(1,all_cond_trls,mean(f_all{i}(:,:,70:85),3));
end

elev_class = NaiveBayes.fit(all_cond_trls,elev_trl);
elev_pred = elev_class.predict(all_cond_trls);
elev_cmat = confusionmat(elev_trl,elev_pred);

ecc_class = NaiveBayes.fit(all_cond_trls,ecc_trl);
ecc_pred = ecc_class.predict(all_cond_trls);
ecc_cmat = confusionmat(ecc_trl,ecc_pred)

cond_class = NaiveBayes.fit(all_cond_trls,cond_trl);
cond_pred = cond_class.predict(all_cond_trls);
cond_cmat = confusionmat(cond_trl,cond_pred)

imagesc(cond_cmat)

% even/odd split

elev_class = NaiveBayes.fit(all_cond_trls(1:2:end,:),elev_trl(1:2:end));
elev_pred = elev_class.predict(all_cond_trls(2:2:end,:));
elev_cmat = confusionmat(elev_trl(2:2:end),elev_pred);
sum(diag(elev_cmat))/sum(elev_cmat(:))

ecc_class = NaiveBayes.fit(all_cond_trls(1:2:end,:),ecc_trl(1:2:end));
ecc_pred = ecc_class.predict(all_cond_trls(2:2:end,:));
ecc_cmat = confusionmat(ecc_trl(2:2:end),ecc_pred)
sum(diag(ecc_cmat))/sum(ecc_cmat(:))

cond_class = NaiveBayes.fit(all_cond_trls(1:2:end,:),cond_trl(1:2:end));
cond_pred = cond_class.predict(all_cond_trls(2:2:end,:));
cond_cmat = confusionmat(cond_trl(2:2:end),cond_pred)
sum(diag(cond_cmat))/sum(cond_cmat(:))

% v1/v4

v1_elev_class = NaiveBayes.fit(all_cond_trls(1:2:end,v1_ind),elev_trl(1:2:end));
v1_elev_pred = v1_elev_class.predict(all_cond_trls(2:2:end,v1_ind));
v1_elev_cmat = confusionmat(elev_trl(2:2:end),v1_elev_pred);
sum(diag(v1_elev_cmat))/sum(v1_elev_cmat(:))

v4_elev_class = NaiveBayes.fit(all_cond_trls(1:2:end,v4_ind),elev_trl(1:2:end));
v4_elev_pred = v4_elev_class.predict(all_cond_trls(2:2:end,v4_ind));
v4_elev_cmat = confusionmat(elev_trl(2:2:end),v4_elev_pred);
sum(diag(v4_elev_cmat))/sum(v4_elev_cmat(:))


v1_cond_class = NaiveBayes.fit(all_cond_trls(1:2:end,v1_ind),cond_trl(1:2:end));
v1_cond_pred = v1_cond_class.predict(all_cond_trls(2:2:end,v1_ind));
v1_cond_cmat = confusionmat(cond_trl(2:2:end),v1_cond_pred);
sum(diag(v1_cond_cmat))/sum(v1_cond_cmat(:))



v4_cond_class = NaiveBayes.fit(all_cond_trls(1:2:end,v4_ind),cond_trl(1:2:end));
v4_cond_pred = v4_cond_class.predict(all_cond_trls(2:2:end,v4_ind));
v4_cond_cmat = confusionmat(cond_trl(2:2:end),v4_cond_pred);
sum(diag(v4_cond_cmat))/sum(v4_cond_cmat(:))


%% across frequencies


do_bands

all_cond_freq_trls = [];
for j = 1:200 % 185
  tmp = [];
for i = 1:60
tmp = cat(1,tmp,mean(f_all{i}(:,:,bpfreq{j}),3));
end
all_cond_freq_trls(j,:,:) = tmp;
end

% train models

for i = 1:200
  for j = 1:111
% elev_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(i,1:2:end,:)),elev_trl(1:2:end));
% elev_pred = elev_class.predict(squeeze(all_cond_freq_trls(i,2:2:end,:)));
% elev_cmat(i,:,:) = confusionmat(elev_trl(2:2:end),elev_pred);
% elev_perf_spec(i,:) = sum(diag(squeeze(elev_cmat(i,:,:))))/sum(sum(elev_cmat(i,:,:)));
% 
% ecc_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(i,1:2:end,:)),ecc_trl(1:2:end));
% ecc_pred = ecc_class.predict(squeeze(all_cond_freq_trls(i,2:2:end,:)));
% ecc_cmat(i,:,:) = confusionmat(ecc_trl(2:2:end),ecc_pred);
% ecc_perf_spec(i,:) = sum(diag(squeeze(ecc_cmat(i,:,:))))/sum(sum(ecc_cmat(i,:,:)));

cond_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(1:2:end,:,i,j)),cond_trl(1:2:end));
cond_pred = cond_class.predict(squeeze(all_cond_freq_trls(2:2:end,:,i,j)));
cond_cmat(i,j,:,:) = confusionmat(cond_trl(2:2:end),cond_pred);
cond_perf_spec(i,j,:) = sum(diag(squeeze(cond_cmat(i,j,:,:))))/sum(sum(cond_cmat(i,j,:,:)));
end
end


figure; 
hold all
plot(bpf(1:200),elev_perf_spec)
plot(bpf(1:200),1/10*ones(200,1),'b')
plot(bpf(1:200),ecc_perf_spec)
plot(bpf(1:200),cond_perf_spec)
plot(bpf(1:200),1/60*ones(200,1),'r')
plot(bpf(1:200),1/6*ones(200,1),'g')
title('v1')

for i = 1:185
elev_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(i,1:2:end,v1_ind)),elev_trl(1:2:end));
elev_pred = elev_class.predict(squeeze(all_cond_freq_trls(i,2:2:end,v1_ind)));
elev_cmat_v1(i,:,:) = confusionmat(elev_trl(2:2:end),elev_pred);
elev_perf_spec_v1(i,:) = sum(diag(squeeze(elev_cmat_v1(i,:,:))))/sum(sum(elev_cmat_v1(i,:,:)));

elev_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(i,1:2:end,v4_ind)),elev_trl(1:2:end));
elev_pred = elev_class.predict(squeeze(all_cond_freq_trls(i,2:2:end,v4_ind)));
elev_cmat_v4(i,:,:) = confusionmat(elev_trl(2:2:end),elev_pred);
elev_perf_spec_v4(i,:) = sum(diag(squeeze(elev_cmat_v4(i,:,:))))/sum(sum(elev_cmat_v4(i,:,:)));

ecc_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(i,1:2:end,v1_ind)),ecc_trl(1:2:end));
ecc_pred = ecc_class.predict(squeeze(all_cond_freq_trls(i,2:2:end,v1_ind)));
ecc_cmat_v1(i,:,:) = confusionmat(ecc_trl(2:2:end),ecc_pred);
ecc_perf_spec_v1(i,:) = sum(diag(squeeze(ecc_cmat_v1(i,:,:))))/sum(sum(ecc_cmat_v1(i,:,:)));


ecc_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(i,1:2:end,v4_ind)),ecc_trl(1:2:end));
ecc_pred = ecc_class.predict(squeeze(all_cond_freq_trls(i,2:2:end,v4_ind)));
ecc_cmat_v4(i,:,:) = confusionmat(ecc_trl(2:2:end),ecc_pred);
ecc_perf_spec_v4(i,:) = sum(diag(squeeze(ecc_cmat_v4(i,:,:))))/sum(sum(ecc_cmat_v4(i,:,:)));

cond_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(i,1:2:end,v1_ind)),cond_trl(1:2:end));
cond_pred = cond_class.predict(squeeze(all_cond_freq_trls(i,2:2:end,v1_ind)));
cond_cmat_v1(i,:,:) = confusionmat(cond_trl(2:2:end),cond_pred);
cond_perf_spec_v1(i,:) = sum(diag(squeeze(cond_cmat_v1(i,:,:))))/sum(sum(cond_cmat_v1(i,:,:)));

cond_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(i,1:2:end,v4_ind)),cond_trl(1:2:end));
cond_pred = cond_class.predict(squeeze(all_cond_freq_trls(i,2:2:end,v4_ind)));
cond_cmat_v4(i,:,:) = confusionmat(cond_trl(2:2:end),cond_pred);
cond_perf_spec_v4(i,:) = sum(diag(squeeze(cond_cmat_v4(i,:,:))))/sum(sum(cond_cmat_v4(i,:,:)));
end


figure; 
hold all
plot(bpf(1:185),elev_perf_spec_v1)
plot(bpf(1:185),1/10*ones(185,1),'b')
plot(bpf(1:185),ecc_perf_spec_v1)
plot(bpf(1:185),cond_perf_spec_v1)
plot(bpf(1:185),1/60*ones(185,1),'r')
plot(bpf(1:185),1/6*ones(185,1),'g')
title('v1')

figure; 
hold all;
plot(bpf(1:185),elev_perf_spec_v4)
plot(bpf(1:185),1/10*ones(185,1),'b')
plot(bpf(1:185),ecc_perf_spec_v4)
plot(bpf(1:185),cond_perf_spec_v4)
plot(bpf(1:185),1/60*ones(185,1),'r')
plot(bpf(1:185),1/6*ones(185,1),'g')
title('v4')


 for i = 1:60
subplot(2,1,1); hold on;  plot(poss(:,1),poss(:,2),'.')
scatter(poss(:,1),poss(:,2),cond_cmat(75,:,i)*20+1,'r','filled')
subplot(2,1,2); hold on;  plot(poss(:,1),poss(:,2),'.')
scatter(poss(:,1),poss(:,2),cond_cmat(75,i,:)*20+1,'r','filled')
pause
end
