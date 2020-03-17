% OUTSIDE RF decoding
% see here :: edit peer_single_chan_naivebayes.m

for i = 1:100 % number of reps
  load(sprintf('/mnt/hps/home/lewisc/public/pele/retino/bayes/singleChanDecoding/v1_singlechan_%02i_perf',i))
  cond_cmat_all(i,:,:,:) = cond_cmat;
  cond_perf_spec_all(i,:,:) = cond_perf_spec;
end

load /mnt/hps/home/lewisc/donders/pele/retinotopy/rf_erp_gamma_topo.mat

pele_cfg.zlim = [0 6];
topoplot_explore(pele_cfg,pele_results)

size(cond_cmat_all)

% limit to v1
[v1_pref v1_pref_ind] = sort(pele_results.ecc_corr_slope(v1));

[l ri] 

% small eccentricity chans 
%[v1_pref(1:28) v1_pref_ind(1:28)]

% large ecc stim
%[l(end-19:end) ri(end-19:end)]

cond_cmat_small = cond_cmat_all(:,v1_pref_ind(1:28),  ri(end-19:end),ri(end-19:end));

 % big eccentricity chans 
 %[v1_pref(end-16:end) v1_pref_ind(end-16:end)]

 % small ecc stim
 [l(1:20) ri(1:20)]

cond_cmat_large = cond_cmat_all(:,v1_pref_ind(end-16:end),  ri(1:20),ri(1:20));


for k = 1:100 
  for kk = 1:28 
 cond_perf_spec_small(k,kk,:) = sum(diag(squeeze(cond_cmat_small(k,kk,:,:))))/sum(sum(cond_cmat_small(k,kk,:,:)));
  end
  for kk = 1:17 
 cond_perf_spec_large(k,kk,:) = sum(diag(squeeze(cond_cmat_large(k,kk,:,:))))/sum(sum(cond_cmat_large(k,kk,:,:)));
end
end


figure; boxplot(cat(1,cond_perf_spec_small(:),cond_perf_spec_large(:))), set(gca,'ytick',0:0.05:0.2)
figure; hist(cat(1,cond_perf_spec_small(:),cond_perf_spec_large(:))), set(gca,'xtick',0:0.05:0.25)


