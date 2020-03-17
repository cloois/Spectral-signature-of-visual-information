function peer_retino_TFR_classify(cfg)

% bands = 1:215;
% 
% cfg = [];
% for i = 1:length(bands)
% cfg{i}.bands = bands;
% cfg{i}.all_cond_trial_tfr
%
% end

% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_concat_and_blp_spectrum,cfg,'memreq',1024,'timreq',1024,'queue','6GB')


load(cfg.all_cond_trial_tfr)

cond_trl = [];
for i = 1:60
cond_trl = cat(1,cond_trl,i * ones(size(f_all{i},1),1));
end




% train models

for i = 1:200
  for j = 1:length(freq.time)
cond_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(1:2:end,:,i,j)),cond_trl(1:2:end));
cond_pred = cond_class.predict(squeeze(all_cond_freq_trls(2:2:end,:,i,j)));
cond_cmat(i,j,:,:) = confusionmat(cond_trl(2:2:end),cond_pred);
cond_perf_spec(i,j,:) = sum(diag(squeeze(cond_cmat(i,j,:,:))))/sum(sum(cond_cmat(i,j,:,:)));
  end
end

end