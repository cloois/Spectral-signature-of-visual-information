

all_cond_freq_trls = [];
for i=1:60
  load(sprintf('/mnt/hps/home/lewisc/public/pele/retino/tfr/data_pos%02i_wave_dpss.mat',i))
  %load(sprintf('/mnt/hps/home/lewisc/public/pele/retino/tfr/data_pos%02i_tfr_trials.mat',i))
  all_cond_freq_trls = cat(1,all_cond_freq_trls,freq.powspctrm);
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

do_bands


% train models

for i = 1:200
  for j = 1:length(freq.time)
elev_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(1:2:end,:,i,j)),elev_trl(1:2:end));
elev_pred = elev_class.predict(squeeze(all_cond_freq_trls(2:2:end,:,i,j)));
elev_cmat(i,j,:,:) = confusionmat(elev_trl(2:2:end),elev_pred);
elev_perf_spec(i,j,:) = sum(diag(squeeze(elev_cmat(i,j,:,:))))/sum(sum(elev_cmat(i,j,:,:)));

ecc_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(1:2:end,:,i,j)),ecc_trl(1:2:end));
ecc_pred = ecc_class.predict(squeeze(all_cond_freq_trls(2:2:end,:,i,j)));
ecc_cmat(i,j,:,:) = confusionmat(ecc_trl(2:2:end),ecc_pred);
ecc_perf_spec(i,j,:) = sum(diag(squeeze(ecc_cmat(i,j,:,:))))/sum(sum(ecc_cmat(i,j,:,:)));

cond_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(1:2:end,:,i,j)),cond_trl(1:2:end));
cond_pred = cond_class.predict(squeeze(all_cond_freq_trls(2:2:end,:,i,j)));
cond_cmat(i,j,:,:) = confusionmat(cond_trl(2:2:end),cond_pred);
cond_perf_spec(i,j,:) = sum(diag(squeeze(cond_cmat(i,j,:,:))))/sum(sum(cond_cmat(i,j,:,:)));
  end
end