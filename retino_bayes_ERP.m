cd /mnt/hps/home/lewisc/public/pele/retino/

pele_visualchans

cond_trl = [];
for k = 1:60
load(sprintf('raw/data_pos%02d',k))
data_all{k}=data;
cond_trl_num(k) = length(data_all{k}.trial);
cond_trl = cat(1,cond_trl,k * ones(cond_trl_num(k),1));
end

data_append=[];
for k = 1:60
for kk = 1:length(data_all{k}.trial)
data_append = cat(3,data_append,data_all{k}.trial{kk}(visual,:));
end
end

examplar = round(min(cond_trl_num).*0.9);

tt=101:1201;

ccond_cmat = [];
ERP_decoding = [];
for kk = 1:20
  
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

%for k = 1:1301
for k = 1:length(tt)
cond_class = NaiveBayes.fit(squeeze(data_append(:,tt(k),cond_train))',image_train);
cond_pred = cond_class.predict(squeeze(data_append(:,tt(k),cond_test))');
ccond_cmat(kk,k,:,:) = confusionmat(image_test,cond_pred);
ERP_decoding(kk,k,:) = sum(diag(squeeze(ccond_cmat(kk,k,:,:))))/sum(sum(ccond_cmat(kk,k,:,:)));
end, end

figure; plot(data.time{1},mean(ERP_decoding))
hold all
plot(data.time{1},max(ERP_decoding),'.')
plot(data.time{1},min(ERP_decoding),'.')

figure; plot(data.time{1},mean(ERP_decoding))
hold all
plot(data.time{1},min(ERP_decoding),'b-')
plot(data.time{1},max(ERP_decoding),'b-')

%% train instead on sum(abs(1:300))
time = 301:600;

data_ERP_append = [];
for k = 1:60
for kk = 1:length(data_all{k}.trial)
data_ERP_append = cat(1,data_append,data_all{k}.trial{kk}(:,time));
end
end





