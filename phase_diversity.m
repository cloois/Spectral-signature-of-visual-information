cfg.method = 'plv';
cfg.complex = 'complex';

cfg.trials = 1:2:240;
plv_odd = ft_connectivityanalysis(cfg,freq);
cfg.trials = 2:2:240;
plv_even = ft_connectivityanalysis(cfg,freq);


figure; plot(squeeze(angle(plv_odd.plvspctrm(1,5,65,:))))
figure; plot(squeeze(abs(plv_odd.plvspctrm(1,5,65,:))))
figure; imagesc(squeeze(abs(plv_odd.plvspctrm(1,5,:,:))))

figure; plot(squeeze(angle(plv_even.plvspctrm(1,2:5,65,400:1000))),squeeze(angle(plv_odd.plvspctrm(1,2:5,65,400:1000))),'.')
hold all; plot(squeeze(angle(plv_even.plvspctrm(2,3:5,65,400:1000))),squeeze(angle(plv_odd.plvspctrm(2,3:5,65,400:1000))),'.')
plot(squeeze(angle(plv_even.plvspctrm(3,4:5,65,400:1000))),squeeze(angle(plv_odd.plvspctrm(3,4:5,65,400:1000))),'.')
plot(squeeze(angle(plv_even.plvspctrm(4,5,65,400:1000))),squeeze(angle(plv_odd.plvspctrm(4,5,65,400:1000))),'.')


for k = 1:16
tmp = find(freq.stm==k);
cfg.trials = 1:2:length(tmp);
plv_even_cond{k} = ft_connectivityanalysis(cfg,freq);
cfg.trials = 2:2:length(tmp);
plv_odd_cond{k} = ft_connectivityanalysis(cfg,freq);
end

k=2;
j=16;
toi = 600;
foi = 65;

figure; plot(squeeze(angle(plv_even_cond{k}.plvspctrm(1,2:5,foi,toi))),squeeze(angle(plv_odd_cond{j}.plvspctrm(1,2:5,foi,toi))),'.')
hold all; plot(squeeze(angle(plv_even_cond{k}.plvspctrm(2,3:5,foi,toi))),squeeze(angle(plv_odd_cond{j}.plvspctrm(2,3:5,foi,toi))),'.')
plot(squeeze(angle(plv_even_cond{k}.plvspctrm(3,4:5,foi,toi))),squeeze(angle(plv_odd_cond{j}.plvspctrm(3,4:5,foi,toi))),'.')
plot(squeeze(angle(plv_even_cond{k}.plvspctrm(4,5,foi,toi))),squeeze(angle(plv_odd_cond{j}.plvspctrm(4,5,foi,toi))),'.')


trl_angle = angle(freq.fourierspctrm(:,:,:,600));
figure; imagesc(squeeze(trl_angle(:,4,:)))


% no mean removal
trl_angle = angle(freq.fourierspctrm(:,:,:,:));

% remove mean 
trl_angle = angle(freq.fourierspctrm(:,:,:,:))-repmat(angle(mean(freq.fourierspctrm(:,:,:,:),2)),[1 5 1 1]);

for k = 1:240
for kk = 1:215
  for j = 1:1001
tmp = bsxfun(@minus,squeeze(trl_angle(k,:,kk,j)),squeeze(trl_angle(k,:,kk,j))');
phs_diff(k,:,kk,j) = tmp(find(~tril(ones(size(tmp)))));
end
end
end

%% decode


phs_diff(isnan(phs_diff(:)))=rand(sum(isnan(phs_diff(:))),1);
phs_diff(phs_diff(:)==0)=rand(sum(phs_diff(:)==0),1);

conds = mod(freq.stm,8);
cond = unique(conds);

% conds = freq.stm;
% cond = unique(conds);


for i = 1:length(unique(conds))
  cond_cnt(i) = sum(conds==cond(i));
  cond_trl{i} = find(conds==cond(i));
end

minCond = min(cond_cnt);
examplar = round(minCond.*0.8);

for kk = 1:1
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
  
  for l = 1:215
  for j = 1:1001
    cond_class = NaiveBayes.fit(squeeze(phs_diff(cond_train,:,l,j)),image_train);
      cond_pred = cond_class.predict(squeeze(phs_diff(cond_test,:,l,j)));
      cond_cmat(kk,l,j,:,:) = confusionmat(image_test,cond_pred);
      cond_perf_spec(kk,l,j,:) = sum(diag(squeeze(cond_cmat(kk,l,j,:,:))))/sum(sum(cond_cmat(kk,l,j,:,:)));
    
  end
end
end


%% bandpass

for k=1:200
  bpfreq{k} = [k+1 k+7];
  bands{k} = int2str(bpfreq{k}(1));
  bpf(k) = (k+1+k+7)/2;
end

cfg = [];
cfg.bpfilter = 'yes';
cfg.hilbert = 'complex';

for k=1:200
  cfg.bpfreq = bpfreq{k};
  data_bp{k} = ft_preprocessing(cfg,lfp);
end

for k=1:200
for kk = 1:length(data_bp{1}.trial)
  data(kk,k,:,:) = data_bp{k}.trial{kk};
end
end

cfg = [];
cfg.hilbert = 'complex';
cfg.channel = 1:5;
lfp_hilbert = ft_preprocessing(cfg,lfp);

figure; plot3(lfp.time{1},real(lfp_hilbert.trial{1}(1,:)),imag(lfp_hilbert.trial{1}(1,:)));

for kk = 1:length(lfp.trial)
data_raw(kk,:,:) = lfp.trial{kk}(1:5,:);
end
figure; imagesc(squeeze(data_raw(4,:,:)))

