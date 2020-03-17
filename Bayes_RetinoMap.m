cd monkey/pele/retinotopy/

load pele_bayes_retino_classify

edit retino_classify_withTime.m

%load /mnt/hpx/slurm/lewisc/pele_all_cond_freq_time_trls_retino.mat  %all_cond_freq_trls.mat

all_cond_freq_trans_trls = [];
all_cond_freq_sust_trls = [];
for k=1:60
load(sprintf('/mnt/hpx/home/lewisc/public/pele/retino/tfr/data_pos%02i_tfr_trials.mat',k))
all_cond_freq_trans_trls = cat(1,all_cond_freq_trans_trls,freq.powspctrm(:,:,:,29:36)); 
all_cond_freq_sust_trls = cat(1,all_cond_freq_sust_trls,mean(freq.powspctrm(:,:,:,49:110),4));
end

load /mnt/hpx/home/lewisc/public/pele/retino/pele_retino_cond_trls.mat

cond_trl = [];
for i = 1:60
cond_trl = cat(1,cond_trl,i * ones(cond_trl_num(i),1));
end

trans_gamma_cond_class = NaiveBayes.fit(mean(mean(all_cond_freq_trans_trls(1:2:end,:,84:130,1:4),4),3),cond_trl(1:2:end));
trans_low_cond_class = NaiveBayes.fit(mean(mean(all_cond_freq_trans_trls(1:2:end,:,12:20,4:end),4),3),cond_trl(1:2:end));
sust_gamma_cond_class = NaiveBayes.fit(mean(all_cond_freq_sust_trls(1:2:end,:,62:86),3),cond_trl(1:2:end));

load /mnt/hpx/home/lewisc/monkey/pele/retinotopy/rf_erp_gamma_topo pele_cfg pele_results
pele_visualchans

pele_cfg.parameter = 'ecc_locorr_slope';
pele_cfg.comment = 'no';
pele_cfg.shading = 'flat';
pele_cfg.style = 'straight';
pele_cfg.interplimits = 'head';
pele_cfg.type = 'corr_slope';

pele_results.ecc_corr_slope = zeros(218,1);
pele_results.elev_corr_slope = zeros(218,1);

pele_trans_gamma = pele_results;
pele_trans_low = pele_results;
pele_sust_gamma = pele_results;

for i = 1:60
for j = 1:length(visual)
pele_trans_gamma.ecc_corr_slope(visual(j),i) = trans_gamma_cond_class.Params{i,j}(1);
pele_trans_gamma.elev_corr_slope(visual(j),i) = trans_gamma_cond_class.Params{i,j}(2);
pele_trans_low.ecc_corr_slope(visual(j),i) = trans_low_cond_class.Params{i,j}(1);
pele_trans_low.elev_corr_slope(visual(j),i) = trans_low_cond_class.Params{i,j}(2);
pele_sust_gamma.ecc_corr_slope(visual(j),i) = sust_gamma_cond_class.Params{i,j}(1);
pele_sust_gamma.elev_corr_slope(visual(j),i) = sust_gamma_cond_class.Params{i,j}(2);
end
end

[the  r] = cart2pol(pele_cfg.poss(:,1),pele_cfg.poss(:,2));
[lth thi] = sort(the);
[l ri] = sort(r);
ecc_rad = [0.60*ones(10,1)
            0.67*ones(10,1)
            0.73*ones(10,1)
            0.80*ones(10,1)
          0.87*ones(10,1)
          0.93*ones(10,1)];

  ecc_rad=ecc_rad(ri);
        
pele_cfg.interpolation = 'nearest';
pele_cfg.parameter = 'ecc_corr_slope';

tmp=pele_sust_gamma;

figure
for k=1:60
pe.ecc_corr_slope=pele_sust_gamma.ecc_corr_slope(:,k);
subplot(2,2,1)
ft_topoplotER(pele_cfg,pe)
pe.ecc_corr_slope=pele_trans_gamma.ecc_corr_slope(:,k);
subplot(2,2,2)
ft_topoplotER(pele_cfg,pe)
pe.ecc_corr_slope=pele_trans_low.ecc_corr_slope(:,k);
subplot(2,2,4)
ft_topoplotER(pele_cfg,pe)
subplot(2,2,3)
hold off
plot(pele_cfg.poss(:,1),pele_cfg.poss(:,2),'.')
hold on
circle(pele_cfg.poss(k,1),pele_cfg.poss(k,2),ecc_rad(k))
axis square
plot(pele_cfg.poss(k,1),pele_cfg.poss(k,2),'*')
title(sprintf('position %d',k))
pause

end

ft_topoplotER(pele_cfg,pele_trans_gamma);

       
       
       
       
       

tmp = pele_results.ecc_corr_slope(visual,:);


pele_results.freq = 1;
pele_results.ecc_corr_slope = zeros(218,1);
pele_results.ecc_corr_slope(visual) = max(tmp');
topoplot_explore(pele_cfg,pele_results)

[xx mind] = max(tmp');
[xx sind] = sort(tmp');

r(sind(end-5:end,:));
pele_cfg.zlim = [0 6];

pele_results.ecc_corr_slope(visual) = r(mind);
topoplot_explore(pele_cfg,pele_results)
colormap(flipud(colormap))

pele_results.ecc_corr_slope(visual) = mean(r(sind(end-5:end,:)));
topoplot_explore(pele_cfg,pele_results)
colormap(flipud(colormap))








cond_class = NaiveBayes.fit(mean(mean(all_cond_freq_trls(1:2:end,:,:,:),4),3),cond_trl(1:2:end));
cond_class = NaiveBayes.fit(mean(mean(all_cond_freq_trls(1:2:end,:,60:260,:),4),3),cond_trl(1:2:end));
cond_class = NaiveBayes.fit(mean(mean(all_cond_freq_trls(1:2:end,:,60:160,:),4),3),cond_trl(1:2:end));





topoplot_explore(pele_cfg,pele_results)

pele_results.freq = 1:60;

pele_results.ecc_corr_slope = zeros(218,60);
for i = 1:60
for j = 1:length(v1)
pele_results.ecc_corr_slope(v1(j),i) = cond_class.Params{i,j}(1);
pele_results.elev_corr_slope(v1(j),i) = cond_class.Params{i,j}(2);
end
end

pele_cfg.xlim = [1 1];
topoplot_explore(pele_cfg,pele_results)

tmp = pele_results.ecc_corr_slope(v1,:);

%% all visual 
for i = 1:60
for j = 1:length(visual)
pele_results.ecc_corr_slope(visual(j),i) = cond_class.Params{i,j}(1);
pele_results.elev_corr_slope(visual(j),i) = cond_class.Params{i,j}(2);
end
end

tmp = pele_results.ecc_corr_slope(visual,:);


pele_results.freq = 1;
pele_results.ecc_corr_slope = zeros(218,1);
pele_results.ecc_corr_slope(visual) = max(tmp');
topoplot_explore(pele_cfg,pele_results)

[xx mind] = max(tmp');
[xx sind] = sort(tmp');

r(sind(end-5:end,:));
pele_cfg.zlim = [0 6];

pele_results.ecc_corr_slope(visual) = r(mind);
topoplot_explore(pele_cfg,pele_results)
colormap(flipud(colormap))

pele_results.ecc_corr_slope(visual) = mean(r(sind(end-5:end,:)));
topoplot_explore(pele_cfg,pele_results)
colormap(flipud(colormap))

pele_results.ecc_corr_slope(visual) = median(r(sind(end-5:end,:)));
topoplot_explore(pele_cfg,pele_results)
colormap(flipud(colormap))

pele_results.ecc_corr_slope(visual) = mode(r(sind(end-5:end,:)));
topoplot_explore(pele_cfg,pele_results)
colormap(flipud(colormap))

pele_results.ecc_corr_slope(visual) = the(mind);
pele_cfg.zlim = [-1.8 0.15];
topoplot_explore(pele_cfg,pele_results)

pele_results.ecc_corr_slope(visual) = mean(the(sind(end-5:end,:)));
topoplot_explore(pele_cfg,pele_results)

pele_results.ecc_corr_slope(visual) = median(the(sind(end-5:end,:)));
topoplot_explore(pele_cfg,pele_results)

pele_results.ecc_corr_slope(visual) = mode(the(sind(end-5:end,:)));
topoplot_explore(pele_cfg,pele_results)

%% 
for j = 1:length(v1)
for i = 1:60
pele_results.ecc_corr_slope(v1(j),i) = cond_class.Params{i,j}(2);
end
end

tmpp = pele_results.ecc_corr_slope(v1,:);

[xx mindd] = max(tmpp');
pele_results.ecc_corr_slope = zeros(218,1);
pele_results.ecc_corr_slope(v1) = the(mindd);
topoplot_explore(pele_cfg,pele_results)
[xx mindd] = min(tmpp');
pele_results.ecc_corr_slope(v1) = the(mindd);
topoplot_explore(pele_cfg,pele_results)
pele_results.ecc_corr_slope(v1) = r(mindd);
topoplot_explore(pele_cfg,pele_results)
[xx mindd] = max(tmpp');
pele_results.ecc_corr_slope(v1) = r(mindd);
topoplot_explore(pele_cfg,pele_results)
cond_class.posterior
cond_post = cond_class.posterior(mean(mean(all_cond_freq_trls(2:2:end,:,60:160,:),4),3));

cond_post(1,:)
figure; plot(cond_post(1,:))
figure; plot(cond_post(2,:))
figure; plot(cond_post(4,:))

figure; plot(cond_post(4,:))
[ii jj] = find(cond_post>0.005);

cond_class.ClassLevels
cond_class.Dist
cond_class.NClasses
cond_class.NDims
cond_class.Params
cond_class.Prior


figure; plot(cond_post(4,:))
figure; plot(cond_post(1,:))
topoplot_explore(pele_cfg,pele_results)

