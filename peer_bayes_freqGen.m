function peer_bayes_freqGen(cfg)

% peerdir = '/mnt/hps/home/lewisc/public/pele/retino/';
%
% cfg = [];
% for k = 1:10
% cfg{k}.savename = strcat(peerdir,'bayes/retino_freqGeneralization_rep',int2str(k));
% end
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_bayes_freqGen,cfg,'memreq',1024,'timreq',1024,'queue','48GB')


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


for l = 1:200
cond_class_trans = NaiveBayes.fit(mean(mean(all_cond_freq_trls(cond_train,:,l,30),4),3),image_train);
cond_class_sustn = NaiveBayes.fit(mean(mean(all_cond_freq_trls(cond_train,:,l,61),4),3),image_train);
for k = 1:200
cond_pred = cond_class_trans.predict(squeeze(all_cond_freq_trls(cond_test,:,k,30)));
cond_cmat_trans(l,k,:,:) = confusionmat(image_test,cond_pred);
freq_generalization_trans(l,k,:) = sum(diag(squeeze(cond_cmat_trans(l,k,:,:))))/sum(sum(cond_cmat_trans(l,k,:,:)));
cond_pred = cond_class_sustn.predict(squeeze(all_cond_freq_trls(cond_test,:,k,61)));
cond_cmat_sustn(l,k,:,:) = confusionmat(image_test,cond_pred);
freq_generalization_sustn(l,k,:) = sum(diag(squeeze(cond_cmat_sustn(l,k,:,:))))/sum(sum(cond_cmat_sustn(l,k,:,:)));
end
end

save(cfg.savename,'cond_class_trans','cond_class_sustn','cond_cmat_trans','freq_generalization_trans','cond_cmat_sustn','freq_generalization_sustn')
end