% decode with eye position

cfg.channel = [29 30];

for i = 1:112
load(sprintf('condition_%i.mat',i))
data = ft_preprocessing(cfg,data);
eye_data_all{i} = data.trial;
end

for i = 1:112
for j = 1:length(eye_data_all{i})
  eye_data{i}(j,:,:) = eye_data_all{i}{j};

end
end

conds = 1:112;
 
 for i = 1:length(conds)
  cond_cnt(i) = length(eye_data_all{i});
 end
 
eye_data_train = [];
eye_data_test = [];
eye_cat_train = [];
eye_cat_test = [];

for i = 1:112
  
eye_data_train = cat(1,eye_data_train,eye_data{i}(1:40,:,:));
eye_data_test = cat(1,eye_data_test,eye_data{i}(41:end,:,:));
eye_cat_train = cat(1,eye_cat_train,ones(40,1)*i);
eye_cat_test = cat(1,eye_cat_test,ones(cond_cnt(i)-40,1)*i);
end

  for i = 1:1301
cond_class = NaiveBayes.fit(squeeze(freq.powspctrm(cond_train,:,cfg.band,i)),image_cat_train);
cond_pred = cond_class.predict(squeeze(freq.powspctrm(cond_test,:,cfg.band,i)));
cond_cmat(i,:,:) = confusionmat(image_cat_test,cond_pred);
cond_perf_spec(i,:) = sum(diag(squeeze(cond_cmat(i,:,:))))/sum(sum(cond_cmat(i,:,:)));
  end

  save(cfg.savename,'cond_class','cond_pred','cond_cmat','cond_perf_spec');
end