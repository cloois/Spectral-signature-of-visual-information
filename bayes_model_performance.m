for i = 1:68
load(cfg{i}.savename)
perf_all(i,:) = cond_perf_spec;
chans{i} = samp_chans;
end

figure; boxplot(perf_all'); hold on; plot(0:68,ones(69,1)*1/60); title('v1 performance'); xlabel('number of chans');

% look at topo

[b, i, j]= unique(chans{1});

pele_results.ecc_corr_slope = zeros(1,218)';
pele_results.ecc_corr_slope(v1(b)) = perf_all(1,i)';
topoplot_explore(pele_cfg,pele_results)

% 2 chan by distance
pos_dist = dist(vis_pos);
v1_dist = pos_dist(v1_ind,v1_ind);
[r p ] =corr(samp_dist,perf_all(2,:)')

for i = 1:100
samp_dist(i,:) = v1_dist(samp_chans_all{2}(i,1),samp_chans_all{2}(i,2));
end
figure; plot(samp_dist,perf_all(2,:),'.')

for i = 1:17
load(sprintf('/mnt/hps/home/lewisc/public/pele/retino/naive/v4_subsamp_%02i_100_perf',i))
perf_all_v4(i,:) = cond_perf_spec;
chans_v4{i} = samp_chans;
end

figure; boxplot(perf_all_v4'); hold on; plot(0:68,ones(69,1)*1/60); title('v4 performance'); xlabel('number of chans');

for i = 1:68
load(sprintf('/mnt/hps/home/lewisc/public/pele/retino/naive/v1_subsamp_%02i_20_test_perf',i))
perf_all(i,:) = cond_perf_spec;
test_all(i,:) = cond_test_spec;
end

figure; subplot(2,1,1)
boxplot(perf_all'); hold on; plot(0:68,ones(69,1)*1/60)
title('20 reps, chan subselection V1, test')
subplot(2,1,2)
boxplot(test_all'); hold on; plot(0:68,ones(69,1)*1/60)
title('20 reps, chan subselection V1, train')

for i = 1:17
load(sprintf('/mnt/hps/home/lewisc/public/pele/retino/naive/v4_subsamp_%02i_20_test_perf',i))
perf_all_v4(i,:) = cond_perf_spec;
test_all(i,:) = cond_test_spec; end

figure
subplot(2,1,1)
boxplot(perf_all_v4'); hold on; plot(0:68,ones(69,1)*1/60)
title('20 reps, chan subselection V4, test')
subplot(2,1,2)
boxplot(test_all'); hold on; plot(0:68,ones(69,1)*1/60)
title('20 reps, chan subselection V4, train')
