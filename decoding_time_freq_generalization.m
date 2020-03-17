examplar = round(min(cond_trl_num).*0.9);

image_train = [];
image_test = [];
cond_train = [];
cond_test = [];

for k=1:length(cond)
cond_all{k} = randsample(find(cond_trl==k),sum(cond_trl==k));
image_train = cat(1,image_train,ones(examplar,1)*k);
image_test = cat(1,image_test,ones(sum(cond_trl==k)-examplar,1)*k);
cond_train = cat(1,cond_train,cond_all{k}(1:examplar));
cond_test = cat(1,cond_test,cond_all{k}(examplar+1:end));
end


for l = 1:length(freq.freq)
cond_class = NaiveBayes.fit(mean(mean(all_cond_freq_trls(cond_train,:,l,30),4),3),image_train);
for k = 1:length(freq.freq)
cond_pred = cond_class.predict(squeeze(all_cond_freq_trls(cond_test,:,k,30)));
cond_cmat(l,k,:,:) = confusionmat(image_test,cond_pred);
freq_generalization_transient(l,k,:) = sum(diag(squeeze(cond_cmat(l,k,:,:))))/sum(sum(cond_cmat(l,k,:,:)));
end
end


figure, imagesc(freq_generalization_transient'), set(gca,'YDir','normal')

for l = 1:length(freq.freq)
cond_class = NaiveBayes.fit(mean(mean(all_cond_freq_trls(cond_train,:,l,61),4),3),image_train);
for k = 1:length(freq.freq)
cond_pred = cond_class.predict(squeeze(all_cond_freq_trls(cond_test,:,k,61)));
cond_cmat(l,k,:,:) = confusionmat(image_test,cond_pred);
freq_generalization_sustained(l,k,:) = sum(diag(squeeze(cond_cmat(l,k,:,:))))/sum(sum(cond_cmat(l,k,:,:)));
end
end

figure, imagesc(freq_generalization_sustained'), set(gca,'YDir','normal');




%76 sustained
% 14 & 109 transient

for l = 1:length(freq.time)
cond_class = NaiveBayes.fit(squeeze(all_cond_freq_trls(cond_train,:,76,l)),image_train);
cond_class_t = NaiveBayes.fit(squeeze(all_cond_freq_trls(cond_train,:,109,l)),image_train);
cond_class_t_l = NaiveBayes.fit(squeeze(all_cond_freq_trls(cond_train,:,14,l)),image_train);
for k = 1:length(freq.time)
cond_pred = cond_class.predict(squeeze(all_cond_freq_trls(cond_test,:,76,k)));
cond_cmat(l,k,:,:) = confusionmat(image_test,cond_pred);
time_generalization_sustained(l,k,:) = sum(diag(squeeze(cond_cmat(l,k,:,:))))/sum(sum(cond_cmat(l,k,:,:)));
cond_pred = cond_class_t.predict(squeeze(all_cond_freq_trls(cond_test,:,109,k)));
cond_cmat(l,k,:,:) = confusionmat(image_test,cond_pred);
time_generalization_transient_high(l,k,:) = sum(diag(squeeze(cond_cmat(l,k,:,:))))/sum(sum(cond_cmat(l,k,:,:)));
cond_pred = cond_class_t_l.predict(squeeze(all_cond_freq_trls(cond_test,:,14,k)));
cond_cmat(l,k,:,:) = confusionmat(image_test,cond_pred);
time_generalization_transient_low(l,k,:) = sum(diag(squeeze(cond_cmat(l,k,:,:))))/sum(sum(cond_cmat(l,k,:,:)));
end
end

figure, imagesc(freq.time,freq.time,time_generalization_sustained'), set(gca,'YDir','normal')
figure, imagesc(freq.time,freq.time,time_generalization_transient_high'), set(gca,'YDir','normal')
figure, imagesc(freq.time,freq.time,time_generalization_transient_low'), set(gca,'YDir','normal')