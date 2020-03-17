function peer_bayes_timeGen(cfg)

% peerdir = '/mnt/hps/home/lewisc/public/pele/retino/';
%
% cfg = [];
% for k = 1:10
% cfg{k}.savename = strcat(peerdir,'bayes/retino_timeGeneralization_rep',int2str(k));
% end
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_bayes_timeGen,cfg,'memreq',1024,'timreq',1024,'queue','48GB')

%76 sustained
% 14 & 109 transient

% for k = 1:10
% load(cfg{k}.savename)
% time_generalization_trans_high_all(k,:,:) = time_generalization_trans_high;
% time_generalization_trans_low_all(k,:,:) = time_generalization_trans_low;
% time_generalization_sustn_all(k,:,:) = time_generalization_sustn;
% end
% figure, imagesc(squeeze(mean(time_generalization_trans_high_all))), set(gca,'YDir','normal')
% figure, imagesc(squeeze(mean(time_generalization_trans_low_all))), set(gca,'YDir','normal')
% figure, imagesc(squeeze(mean(time_generalization_sustn_all))), set(gca,'YDir','normal')
% imagesc(squeeze(mean(time_generalization_trans_high_all)),[0 0.35]), set(gca,'YDir','normal')
% imagesc(squeeze(mean(time_generalization_sustn_all)),[0 0.4]), set(gca,'YDir','normal')
% imagesc(squeeze(mean(time_generalization_trans_high_all)),[0 0.4]), set(gca,'YDir','normal')
% imagesc(squeeze(mean(time_generalization_trans_low_all)),[0 0.4]), set(gca,'YDir','normal')
% axis square



rng('shuffle')

load /mnt/hps/slurm/lewisc/pele_all_cond_freq_time_trls_retino.mat  %all_cond_freq_trls.mat
load /mnt/hps/home/lewisc/public/pele/retino/pele_retino_cond_trls.mat

examplar = round(min(cond_trl_num).*0.9);

cond_trl = [];
for i = 1:60
cond_trl = cat(1,cond_trl,i * ones(cond_trl_num(i),1));
end


image_train = [];
image_test = [];
cond_train = [];
cond_test = [];

for k=1:60
cond_all{k} = randsample(find(cond_trl==k),sum(cond_trl==k));
image_train = cat(1,image_train,ones(examplar,1)*k);
image_test = cat(1,image_test,ones(sum(cond_trl==k)-examplar,1)*k);
cond_train = cat(1,cond_train,cond_all{k}(1:examplar));
cond_test = cat(1,cond_test,cond_all{k}(examplar+1:end));
end

for l = 1:111
cond_class_sustn = NaiveBayes.fit(squeeze(all_cond_freq_trls(cond_train,:,76,l)),image_train);
cond_class_trans_h = NaiveBayes.fit(squeeze(all_cond_freq_trls(cond_train,:,109,l)),image_train);
cond_class_trans_l = NaiveBayes.fit(squeeze(all_cond_freq_trls(cond_train,:,14,l)),image_train);
for k = 1:111
cond_pred = cond_class_sustn.predict(squeeze(all_cond_freq_trls(cond_test,:,76,k)));
cond_cmat_sustn(l,k,:,:) = confusionmat(image_test,cond_pred);
time_generalization_sustn(l,k,:) = sum(diag(squeeze(cond_cmat_sustn(l,k,:,:))))/sum(sum(cond_cmat_sustn(l,k,:,:)));
cond_pred = cond_class_trans_h.predict(squeeze(all_cond_freq_trls(cond_test,:,109,k)));
cond_cmat_trans_high(l,k,:,:) = confusionmat(image_test,cond_pred);
time_generalization_trans_high(l,k,:) = sum(diag(squeeze(cond_cmat_trans_high(l,k,:,:))))/sum(sum(cond_cmat_trans_high(l,k,:,:)));
cond_pred = cond_class_trans_l.predict(squeeze(all_cond_freq_trls(cond_test,:,14,k)));
cond_cmat_trans_low(l,k,:,:) = confusionmat(image_test,cond_pred);
time_generalization_trans_low(l,k,:) = sum(diag(squeeze(cond_cmat_trans_low(l,k,:,:))))/sum(sum(cond_cmat_trans_low(l,k,:,:)));
end
end

save(cfg.savename,'cond_class_trans_h','cond_class_trans_l','cond_class_sustn','cond_cmat_trans_high','time_generalization_trans_high','cond_cmat_trans_low','time_generalization_trans_low','cond_cmat_sustn','time_generalization_sustn')

end
