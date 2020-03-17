% combine sessions for ORI decoding

%% setup
%


%%

%% run average
%
cond_rate_perf_all = [];

for j = 1:length(sessions_all)
  load(strcat(TFRdir,sessions_all{j}))
  cond_rate_perf_all = cat(1,cond_rate_perf_all,condPerf);
end



load /mnt/hpx/home/lewisc/public/bruss/bayes/TFR/nic059a02_TFR_wave_1ms3_Dir_decode.mat

figure; imagesc(squeeze(mean(cond_perf_spec)))
set(gca,'YDir','normal');

1ms3_Dir_cmat = cond_cmat;
1ms3_Dir_spec = cond_perf_spec;

load /mnt/hps/home/lewisc/public/bruss/bayes/TFR/nic059a02_TFR_wave_1ms_3_decode.mat
figure; imagesc(squeeze(mean(cond_perf_spec)))
set(gca,'YDir','normal');
1ms3_spec = cond_perf_spec;
1ms3_cmat = cond_cmat;

load /mnt/hps/home/lewisc/public/bruss/bayes/TFR/nic059a02_TFR_wave_1ms_decode.mat
figure; imagesc(squeeze(mean(cond_perf_spec)))
set(gca,'YDir','normal');
ms_cmat = cond_cmat;
ms_spec = cond_perf_spec;

load /mnt/hps/home/lewisc/public/bruss/bayes/TFR/nic059a02_TFR_wave_decode.mat
figure; imagesc(squeeze(mean(cond_perf_spec))), set(gca,'YDir','normal');

sessions_all = {
'lil025a07_TFR_wave_1ms_3_decode'
'lil025a06_TFR_wave_1ms_3_decode'
'lil024a04_TFR_wave_1ms_3_decode'
'lil025a05_TFR_wave_1ms_3_decode'
'lil026a01_TFR_wave_1ms_3_decode'
'nic002a04_TFR_wave_1ms_3_decode'
'lil026a02_TFR_wave_1ms_3_decode'
'lil027a10_TFR_wave_1ms_3_decode'
'lil024a05_TFR_wave_1ms_3_decode'
'lil027a06_TFR_wave_1ms_3_decode'
'lil027a08_TFR_wave_1ms_3_decode'
'lil027a09_TFR_wave_1ms_3_decode'
'lil025a03_TFR_wave_1ms_3_decode'
'jeb008a02_TFR_wave_1ms_3_decode'
'lil027a07_TFR_wave_1ms_3_decode'
'lil025a04_TFR_wave_1ms_3_decode'
'lil027a11_TFR_wave_1ms_3_decode'
'lil025a02_TFR_wave_1ms_3_decode'
'lil029a03_TFR_wave_1ms_3_decode'
'lil025a01_TFR_wave_1ms_3_decode'
'lil027a04_TFR_wave_1ms_3_decode'
'lil029a01_TFR_wave_1ms_3_decode'
'lil032a03_TFR_wave_1ms_3_decode'
'lil030a03_TFR_wave_1ms_3_decode'
'lil028b03_TFR_wave_1ms_3_decode'
'lil028a01_TFR_wave_1ms_3_decode'
'lil031a01_TFR_wave_1ms_3_decode'
'lil032a02_TFR_wave_1ms_3_decode'
'lil028a03_TFR_wave_1ms_3_decode'
'lil028b02_TFR_wave_1ms_3_decode'
'lil028c01_TFR_wave_1ms_3_decode'
'jeb024a01_TFR_wave_1ms_3_decode'
'lil029a04_TFR_wave_1ms_3_decode'
'nic018a02_TFR_wave_1ms_3_decode'
'lil030a02_TFR_wave_1ms_3_decode'
'lil028a02_TFR_wave_1ms_3_decode'
'lil029a05_TFR_wave_1ms_3_decode'
'jeb008a01_TFR_wave_1ms_3_decode'
'jeb013a08_TFR_wave_1ms_3_decode'
'lil029a02_TFR_wave_1ms_3_decode'
'lil031c01_TFR_wave_1ms_3_decode'
'nic042a02_TFR_wave_1ms_3_decode'
'lil031b01_TFR_wave_1ms_3_decode'
'lil031b02_TFR_wave_1ms_3_decode'
'lil030a01_TFR_wave_1ms_3_decode'
'nic033b01_TFR_wave_1ms_3_decode'
'lil028b01_TFR_wave_1ms_3_decode'
'nic049a02_TFR_wave_1ms_3_decode'
'nic043a02_TFR_wave_1ms_3_decode'
'jeb016a08_TFR_wave_1ms_3_decode'
'jeb016a09_TFR_wave_1ms_3_decode'
'jeb014a08_TFR_wave_1ms_3_decode'
'nic050a02_TFR_wave_1ms_3_decode'
'jeb013a07_TFR_wave_1ms_3_decode'
'jeb016a06_TFR_wave_1ms_3_decode'
'nic059a02_TFR_wave_1ms_3_decode'
'nic045a03_TFR_wave_1ms_3_decode'
'jeb015a08_TFR_wave_1ms_3_decode'
'jeb013a02_TFR_wave_1ms_3_decode'
'jeb010a02_TFR_wave_1ms_3_decode'
'jeb011a02_TFR_wave_1ms_3_decode'
'jeb015a07_TFR_wave_1ms_3_decode'
'jeb012a02_TFR_wave_1ms_3_decode'
'jeb025a01_TFR_wave_1ms_3_decode'
'nic018a03_TFR_wave_1ms_3_decode'
'jeb023a02_TFR_wave_1ms_3_decode'
'jeb020a02_TFR_wave_1ms_3_decode'
'jeb014a07_TFR_wave_1ms_3_decode'
'jeb022a02_TFR_wave_1ms_3_decode'
'jeb017a04_TFR_wave_1ms_3_decode'
'nic057a02_TFR_wave_1ms_3_decode'
'nic055a02_TFR_wave_1ms_3_decode'
'nic055a03_TFR_wave_1ms_3_decode'};


cond_perf_spec_all = [];
for j = 1:length(sessions_all)
load(strcat(TFRdir,sessions_all{j}))
cond_perf_spec_all = cat(1,cond_perf_spec_all,cond_perf_spec);
end

figure; imagesc(squeeze(mean(cond_perf_spec_all)))
set(gca,'YDir','normal');

load /mnt/hps/home/lewisc/public/bruss/bayes/MUA/lil031b01_MUA_decode
figure; plot(mean(condPerf))

sessions_all = {
'jeb012a02_MUA_decode'
'jeb011a02_MUA_decode'
'jeb013a07_MUA_decode'
'jeb014a07_MUA_decode'
'jeb016a06_MUA_decode'
'jeb016a09_MUA_decode'
'jeb010a02_MUA_decode'
'jeb017a04_MUA_decode'
'jeb015a08_MUA_decode'
'jeb024a01_MUA_decode'
'jeb014a08_MUA_decode'
'jeb025a01_MUA_decode'
'jeb013a02_MUA_decode'
'jeb013a08_MUA_decode'
'jeb015a07_MUA_decode'
'jeb016a08_MUA_decode'
'lil027a04_MUA_decode'
'lil026a02_MUA_decode'
'lil026a01_MUA_decode'
'lil027a06_MUA_decode'
'nic002a04_MUA_decode'
'nic018a03_MUA_decode'
'jeb023a02_MUA_decode'
'nic042a02_MUA_decode'
'nic050a02_MUA_decode'
'jeb022a02_MUA_decode'
'jeb020a02_MUA_decode'
'nic049a02_MUA_decode'
'nic043a02_MUA_decode'
'nic057a02_MUA_decode'
'nic059a02_MUA_decode'
'nic018a02_MUA_decode'
'nic055a03_MUA_decode'
'nic033b01_MUA_decode'
'nic045a03_MUA_decode'
'nic055a02_MUA_decode'
'jeb008a01_MUA_decode'
'lil024a05_MUA_decode'
'lil025a02_MUA_decode'
'jeb008a02_MUA_decode'
'lil025a04_MUA_decode'
'lil027a07_MUA_decode'
'lil024a04_MUA_decode'
'lil025a07_MUA_decode'
'lil027a09_MUA_decode'
'lil025a05_MUA_decode'
'lil027a10_MUA_decode'
'lil025a01_MUA_decode'
'lil027a11_MUA_decode'
'lil028a02_MUA_decode'
'lil028a03_MUA_decode'
'lil025a03_MUA_decode'
'lil025a06_MUA_decode'
'lil028b02_MUA_decode'
'lil028c01_MUA_decode'
'lil027a08_MUA_decode'
'lil028b03_MUA_decode'
'lil029a01_MUA_decode'
'lil028b01_MUA_decode'
'lil029a02_MUA_decode'
'lil029a03_MUA_decode'
'lil029a05_MUA_decode'
'lil029a04_MUA_decode'
'lil030a01_MUA_decode'
'lil030a02_MUA_decode'
'lil030a03_MUA_decode'
'lil031b01_MUA_decode'
'lil031a01_MUA_decode'
'lil031b02_MUA_decode'
'lil031c01_MUA_decode'
'lil032a02_MUA_decode'
'lil032a03_MUA_decode'
'lil028a01_MUA_decode'};
cond_rate_perf_all = [];
for j = 1:length(sessions_all)
load(strcat(TFRdir,sessions_all{j}))
cond_rate_perf_all = cat(1,cond_rate_perf_all,condPerf);
end

figure; plot(mean(cond_rate_perf_all))

cond_perf2_spec_all = [];
for j = 1:length(sessions_all)
load(strcat(TFRdir,sessions_all{j}))
cond_perf2_spec_all = cat(1,cond_perf2_spec_all,cond_perf_spec);
end
TFRdir =  '/mnt/hps/home/lewisc/public/bruss/bayes/TFR/';
cond_perf2_spec_all = [];
for j = 1:length(sessions_all)
load(strcat(TFRdir,sessions_all{j}))
cond_perf2_spec_all = cat(1,cond_perf2_spec_all,cond_perf_spec);
end
figure; imagesc(squeeze(mean(cond_perf2_spec_all)))

set(gca,'YDir','normal');
edit peer_TFR.m
addpath('~/matlab/noise_correlations/')
edit sessions_trl.m
edit session_stim_params.txt
edit peer_preproc_lfp_spike.m
load /mnt/hps/home/lewisc/public/bruss/preproc/lil028a02_preproc.mat

figure; plot(squeeze(lfp.trial{1}(1,:)))
figure; plot(squeeze(lfp.trial{1}(2,:)))
figure; plot(squeeze(lfp.trial{4}(2,:)))
edit sessions_trl.m
figure; plot(lfp.time{4},squeeze(lfp.trial{4}(1,:)))
figure; plot(lfp.time{4},squeeze(lfp.trial{1}(1,:)))


for j = 1:length(sessions_all)
load(strcat('/mnt/hps/home/lewisc/public/bruss/preproc/',sessions_all{j}(1:9),'_preproc'))
lfp_all{j} = lfp;
end

data_all = ft_appenddata([],lfp_all{:})
time = ft_timelockanalysis([],data_all);


cfg.vartrllength = 2;
time = ft_timelockanalysis(cfg,data_all);

figure; plot(squeeze(time.avg(1,:)))
figure; plot(squeeze(time.avg(2,:)))
figure; imagesc(-0.2:0.001:0.8,1:215,squeeze(mean(cond_perf2_spec_all)))
set(gca,'YDir','normal');
figure; plot(time.time,squeeze(time.avg(1,:)))

for j = 1:length(sessions_all)
timee{j} = ft_timelockanalysis(cfg,lfp_all{j});
end

figure
hold all
for j = 1:length(sessions_all)
plot(timee{j}.time,timee{j}.avg(1,:))
end

figure
hold all
for j = 1:length(sessions_all)
plot(timee{j}.time,timee{j}.avg(2,:))
end

figure
for j = 1:length(sessions_all)
hold off
plot(time.time,time.avg(1,:))
hold all
plot(timee{j}.time,timee{j}.avg(1,:))
j
pause
end

peerdir = '/mnt/hpx/home/lewisc/public/bruss/';


cfg = [];
for k = 1:length(sessions_all)
cfg{k}.input = strcat(peerdir,'TFR/',sessions_all{k}(1:9),'_TFR');
cfg{k}.train = 0.80;
cfg{k}.iter = 10;
cfg{k}.ori  = 1;
cfg{k}.savename = strcat(peerdir,'bayes/',sessions_all{k}(1:9),'_TFR_han_ORI_decode');
end
cd /mnt/hps/slurm/lewisc/
qsubcellfun(@peer_TFR_bayes,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

figure;
for j = 1:length(sessions_all)
hold off
plot(time.time,time.avg(1,:))
hold all
plot(timee{j}.time,timee{j}.avg(1,:))
j
pause
end

figure;
plot(time.time,time.avg(1,:))
hold all
plot(timee{49}.time,timee{49}.avg(2,:))

figure; plot(timee{49}(1,:))
figure; plot(timee{49}.avg(1,:))
figure; plot(timee{49}.avg(2,:))
figure; plot(timee{49}.avg(3,:))
figure; plot(timee{49}.avg(4,:))
figure; plot(timee{49}.avg(5,:))
figure; plot(timee{49}.avg(6,:))
figure; hold all;
plot(time.time,time.avg(1,:))

figure; plot(time.avg(1,:))

figure
hold all
for j = 1:length(sessions_all)
plot(timee{j}.time,timee{j}.avg(1,:))
end


qsubcellfun(@peer_TFR_bayes,cfg([1:48 50:end]),'memreq',1024,'timreq',1024,'queue','8GB')

figure; plot(timee{49}.avg(1,:))
figure; plot(timee{49}.time,timee{49}.avg(1,:))



for j = 1:length(sessions_all)
load(strcat('/mnt/hps/home/lewisc/public/bruss/preproc/',sessions_all{j}(1:9),'_preproc'))
lfp_all{j} = lfp;  spikeTrials_all{j} = spikeTrials;
end

figure;
for i=1:length(lfp_all)
plot(lfp_all{i}.trial{1}')
i
pause
end



extra=[14 32 38];
spikeTrials_all{38}
for i=39:length(lfp_all)
plot(lfp_all{i}.trial{1}'), i, pause, end
spikeTrials_all{39}
extra=[14 32 38 29];
extra=[14 32 38 39];
for i=39:length(lfp_all)
plot(lfp_all{i}.trial{1}'), i, pause, end
spikeTrials_all{42}
extra=[14 32 38 39 42];
for i=43:length(lfp_all)
plot(lfp_all{i}.trial{1}'), i, pause, end
extra=[14 32 38 39 42 48];
spikeTrials_all{48}
for i=49:length(lfp_all)
plot(lfp_all{i}.trial{1}'), i, pause, end
extra=[14 32 38 39 42 48 49];


for i=54:length(lfp_all)
plot(lfp_all{i}.trial{1}'), i, pause, end

extra=[14 32 38 39 42 48:55];

for i=54:length(lfp_all)
plot(lfp_all{i}.trial{1}'), i, pause, end
extra=[14 32 38 39 42 48:55 57:64];

for i=54:length(lfp_all)
plot(lfp_all{i}.trial{1}'), i, pause, end
extra=[14 32 38 39 42 48:55 57:64 66:70];




qsubcellfun(@peer_TFR_bayes,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

cond_HANN_perf_spec_all = [];
for k = 1:length(sessions_all)
load(cfg{k}.savename)
cond_HANN_perf_spec_all = cat(1,cond_HANN_perf_spec_all,cond_perf_spec);
end
figure, imagesc(squeeze(mean(cond_HANN_perf_spec_all))), set(gca,'YDir','normal');


cfg = [];
for k = 1:length(sessions_all)
cfg{k}.input    = strcat(peerdir,'preproc/',sessions_all{k}(1:9),'_preproc');
cfg{k}.hanning = 1;
cfg{k}.savename = strcat(peerdir,'TFR/',sessions_all{k}(1:9),'_TFR_hann');
end
qsubcellfun(@peer_TFR,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

cfg = [];
for k = 1:length(sessions_all)
cfg{k}.input = strcat(peerdir,'TFR/',sessions_all{k}(1:9),'_TFR_hann');
cfg{k}.train = 0.80;
cfg{k}.iter = 10;
cfg{k}.ori  = 1;
cfg{k}.savename = strcat(peerdir,'bayes/',sessions_all{k}(1:9),'_TFR_hann_ORI_decode');
end
qsubcellfun(@peer_TFR_bayes,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

for k = 1:length(sessions_all)
cfg{k}.input = strcat(peerdir,'TFR/',sessions_all{k}(1:9),'_TFR_wave_1ms_158');
cfg{k}.savename = strcat(peerdir,'TFR/',sessions_all{k}(1:9),'_TFR_wave_1ms_158_ORI_decode');
end
qsubcellfun(@peer_TFR_bayes,cfg,'memreq',1024,'timreq',1024,'queue','8GB')


cond_HANN2_perf_spec_all = [];
for k = 1:length(sessions_all)
load(strcat(peerdir,'bayes/',sessions_all{k}(1:9),'_TFR_hann_ORI_decode'))
cond_HANN2_perf_spec_all = cat(1,cond_HANN2_perf_spec_all,cond_perf_spec);
end

figure, imagesc(freq.time,freq.freq,squeeze(mean(cond_HANN2_perf_spec_all))), set(gca,'YDir','normal');


cond_Wave_perf_spec_all = []; for k = 1:length(sessions_all)
load(strcat(peerdir,'bayes/TFR/',sessions_all{k}(1:9),'_TFR_wave_1ms_158_ORI_decode'))
cond_Wave_perf_spec_all = cat(1,cond_Wave_perf_spec_all,cond_perf_spec);
end

figure; imagesc(freq.time,freq.freq,squeeze(mean(cond_Wave_perf_spec_all)))
powCfg.toi        = -0.2:0.001:0.8;
powCfg.foi          = 1:1:215;

figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all)))
set(gca,'YDir','normal');
sessions_all{1}
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(1:20,:,:))))
sessions_all{1}
set(gca,'YDir','normal');
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(1:40,:,:))))
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(1:50,:,:))))
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(1:60,:,:))))
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(1:80,:,:))))
for i =1:73
imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(10*(i-1)+1:10*i,:,:))))
set(gca,'YDir','normal');
i
pause
end

good = [32 50 51 52 54 55 58 59 60 61 63 64 66 67 68 69 70 72];
sessions_all(good)

for i =1:73
imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(10*(i-1)+1:10*i,:,:))))
set(gca,'YDir','normal');
i
pause
end

%%
good = [8 32 50 51 52 54 55 58 59 60 61 63 64 66 67 68 69 70 72];

good_indx = [];
for i =1:length(good)
good_indx = cat(2,good_indx,10*(good(i)-1)+1:10*good(i));
end

figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(good_indx,:,:))))
set(gca,'YDir','normal');


figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_HANN2_perf_spec_all(good_indx,:,:))))
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_HANN_perf_spec_all(good_indx,:,:))))


clear cond_WAVE_perf_spec_all
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_perf_spec_all(good_indx,:,:))))

set(gca,'YDir','normal');
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_perf_spec_all(:,:,:))))
set(gca,'YDir','normal');
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_HANN_perf_spec_all(good_indx,:,:))))
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(good_indx,:,:))))
set(gca,'YDir','normal');
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(:,:,:))))
set(gca,'YDir','normal');


figure
for k = 1:length(sessions_all)
load(strcat('/mnt/hps/home/lewisc/public/bruss/TFR/',sessions_all{k}(1:9),'_TFR_wave_1ms_158'))
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(freq.powspctrm(:,1,:,:))))
set(gca,'YDir','normal');
k
pause
end

two_bumps = [8 10 11 12 15 16 17 19 21 25 26 29 30 31 33 35 36 37 41 43 44 47];
sessions_all(two_bumps)

good = [14  32 38 39 50 51 52 54 55 58 59 60 61 62 63 64 66 67 68 69 70 72];

good_indx = [];
for i =1:length(good)
good_indx = cat(2,good_indx,10*(good(i)-1)+1:10*good(i));
end

figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(good_indx,:,:))))
set(gca,'YDir','normal');
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(good_indx,:,:))))
set(gca,'YDir','normal');
clims([0 0.35])
figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_perf_spec_all(good_indx,:,:))))
set(gca,'YDir','normal');

load /mnt/hps/home/lewisc/public/bruss/TFR/jeb014a07_TFR_wave_1ms.mat
load /mnt/hps/home/lewisc/public/bruss/TFR/jeb014a07_TFR_wave_1ms_3.mat

do_bands
edit do_bands.m

for i=1:9
bpfreq{i} = [i i+2];
bands{i} = int2str(bpfreq{i}(1));
bpf(i) = (i+i+2)/2;
end
for i=10:50
bpfreq{i} = [i i+4];
bands{i} = int2str(bpfreq{i}(1));
bpf(i) = (i+i+4)/2;
end
for i=51:200
bpfreq{i} = [i i+8];
bands{i} = int2str(bpfreq{i}(1));
bpf(i) = (i+i+8)/2;
end
cfg = [];
for i=1:length(good)
cfg{i}.inputfile = strcat(peerdir,'preproc/',sessions_all{good(i)}(1:9),'_preproc');
cfg{i}.bands = bands;
cfg{i}.bpfreq = bpfreq;
cfg{i}.downsample = 0;
cfg{i}.power = 1;
cfg{i}.continuous = 0;
cfg{i}.savename = strcat(peerdir,'bandpass/',sessions{i}(1:9),'_bndpass');
end
cfg = [];
for i=1:length(good)
cfg{i}.inputfile = strcat(peerdir,'preproc/',sessions_all{good(i)}(1:9),'_preproc');
cfg{i}.bands = bands;
cfg{i}.bpfreq = bpfreq;
cfg{i}.downsample = 0;
cfg{i}.power = 1;
cfg{i}.continuous = 0;
cfg{i}.savename = strcat(peerdir,'bandpass/',sessions_all{good(i)}(1:9),'_bndpass');
end
qsubcellfun(@peer_bandpass,cfg,'memreq',1024,'timreq',1024,'queue','6GB')
for i =1:73
imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(10*(i-1)+1:10*i,:,:))))
set(gca,'YDir','normal');
i
pause
end
for i =1:73
imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(10*(i-1)+1:10*i,:,:))))
set(gca,'YDir','normal');
i
pause
end
for i =1:73
imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(10*(i-1)+1:10*i,:,:))))
set(gca,'YDir','normal');
i
pause
end
qsubcellfun(@peer_bandpass_bruss,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

cfg = [];
for k = 1:length(good)
cfg{k}.input = strcat(peerdir,'bandpass/',sessions_all{good(k)}(1:9),'_bndpass');
cfg{k}.bands = bands;
cfg{k}.train = 0.90;
cfg{k}.iter = 5;
cfg{k}.ori  = 1;
cfg{k}.savename = strcat(peerdir,'bayes/',sessions_all{good(k)}(1:9),'_BLP_ORI_decode');
end

load(strcat(peerdir,'bandpass/',sessions_all{good(1)}(1:9),'_bndpass_1'))


cfg = [];
for i=1:length(good)
cfg{i}.inputfile = strcat(peerdir,'preproc/',sessions_all{good(i)}(1:9),'_preproc');
cfg{i}.bands = bands;
cfg{i}.bpfreq = bpfreq;
cfg{i}.downsample = 0;
cfg{i}.power = 1;
cfg{i}.continuous = 0;
cfg{i}.savename = strcat(peerdir,'bandpass/',sessions_all{good(i)}(1:9),'_bndpass');
end
qsubcellfun(@peer_bandpass_bruss,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

figure; plot(lfp.trial{1}(1,:))
figure; plot(lfp.time{1},lfp.trial{1}(1,:))
tmp = cell2mat(lfp.trial);

tmp = reshape(cell2mat(lfp.trial),[6 1101 160]);
figure; plot(lfp.time{1},lfp.trial{1}(1,:))
hold on
plot(lfp.time{1},tmp(1,:,1))
plot(lfp.time{1},tmp(1,:,1),'g')
figure; plot(lfp.time{1},lfp.trial{2}(2,:))
hold on
plot(lfp.time{1},tmp(2,:,2),'g')

tmp = reshape(cell2mat(lfp.trial),[ 160 6 1101]);
figure; plot(lfp.time{1},lfp.trial{2}(2,:))
hold on
plot(lfp.time{1},tmp(2,2,:),'g')
plot(lfp.time{1},squeeze(tmp(2,2,:)),'g')
plot(lfp.time{1},squeeze(tmp(2,5,:)),'g')
plot(lfp.time{1},squeeze(tmp(23,5,:)),'g')

spikeTrials
qsubcellfun(@peer_bandpass_bruss,cfg,'memreq',1024,'timreq',1024,'queue','8GB')

tmp = permute(reshape(cell2mat(lfp.trial),[6 1101 160]),[3 1 4 2]);
size(tmp)
cfg = [];
for k = 1:length(good)
cfg{k}.input = strcat(peerdir,'bandpass/',sessions_all{good(k)}(1:9),'_bndpass');
cfg{k}.bands = bands;
cfg{k}.train = 0.90;
cfg{k}.iter = 5;
cfg{k}.ori  = 1;
cfg{k}.savename = strcat(peerdir,'bayes/',sessions_all{good(k)}(1:9),'_BLP_ORI_decode');
end
cfg{1}
qsubcellfun(@peer_BLP_bayes,cfg,'memreq',1024,'timreq',1024,'queue','8GB')
qsubcellfun(@peer_BLP_bayes,cfg(1),'memreq',1024,'timreq',1024,'queue','8GB')

cfg{1}.iter = 1;
qsubcellfun(@peer_BLP_bayes,cfg(1),'memreq',1024,'timreq',1024,'queue','8GB')
load(cfg{1}.savename)
figure; imagesc(-0.25:0.001:0.85,1:200,squeeze(cond_perf_spec))
set(gca,'YDir','normal');

figure; imagesc(powCfg.toi,powCfg.foi,squeeze(mean(cond_Wave_perf_spec_all(10*(14-1)+1:10*14,:,:))))
set(gca,'YDir','normal');
figure; imagesc(-0.25:0.001:0.85,1:200,squeeze(cond_perf_spec))
set(gca,'YDir','normal');

figure; imagesc(-0.25:0.001:0.85,1:200,squeeze(cond_perf_spec))
set(gca,'YDir','normal');

load(strcat(peerdir,'bandpass/',sessions_all{good(10)}(1:9),'_bndpass_60'))

figure; plot(lfp.time{1},lfp.trial{2}(2,:))

for k = 1:length(good)
cfg{k}.iter = 2;
end
qsubcellfun(@peer_BLP_bayes,cfg,'memreq',1024,'timreq',1024,'queue','8GB')


for k = 1:length(good)
load(cfg{k}.savename)
cond_perf_blp = cat(1,cond_perf_all);
end

for k = 1:length(good)
load(cfg{k}.savename)
cond_perf_blp = cat(1,cond_perf_spec);
end

cond_perf_blp = [];
for k = 1:length(good)
load(cfg{k}.savename)'
cond_perf_blp = cat(1,cond_perf_blp,cond_perf_spec);
end

figure; imagesc(-0.2:0.001:0.8,1:200,squeeze(mean(cond_perf_blp)))
set(gca,'YDir','normal');
figure; plot(-0.2:0.001:0.8,squeeze(mean(mean(cond_perf_blp),2)))
length(squeeze(mean(mean(cond_perf_blp),2)))
length(-0.2:0.001:0.8)
figure; plot(-0.25:0.001:0.85,squeeze(mean(mean(cond_perf_blp),2)))

for k = 1:length(good)
imagesc(-0.25:0.001:0.85,1:200,squeeze(mean(cond_Wave_perf_spec_all(2*(k-1)+1:2*k,:,:))))
pause
k
end

for k = 1:length(good)
imagesc(-0.25:0.001:0.85,1:200,squeeze(mean(cond_perf_blp(2*(k-1)+1:2*k,:,:))))
set(gca,'YDir','normal');
k
pause
end

cond_perf_blp = [];
for k = 1:length(good)
load(cfg{k}.savename)
cond_perf_blp = cat(1,cond_perf_blp,cond_perf_spec);
end
figure; imagesc(-0.25:0.001:0.85,1:200,squeeze(mean(cond_perf_blp)))
set(gca,'YDir','normal');

figure
for k = 1:length(good)
imagesc(-0.25:0.001:0.85,1:200,squeeze(mean(cond_perf_blp(2*(k-1)+1:2*k,:,:))))
set(gca,'YDir','normal');
k
pause
end


for k = 1:length(good)
load(strcat(peerdir,'bayes/TFR/',sessions_all{good(k)}(1:9),'_TFR_wave_1ms3_Dir_decode'))
cond_perf_spec_DIR=cat(1,cond_perf_spec_DIR,cond_perf_spec);
end

figure; imagesc(-0.2:0.001:0.8,1:215,squeeze(mean(cond_perf_spec_DIR)))
set(gca,'YDir','normal');
axis off

for k = 1:length(good)
load(strcat(peerdir,'bayes/MUA/',sessions_all{good(k)}(1:9),'_MUA_Dir_decode'))
cond_MUA_perf = cat(1,cond_MUA_perf,condPerf);
end
figure; plot(-0.2:0.001:0.8,squeeze(mean(cond_MUA_perf)))

for k = 1:length(good)
load(strcat(peerdir,'bayes/MUA/',sessions_all{good(k)}(1:9),'_MUA_decode'))
cond_MUA_ORI_perf = cat(1,cond_MUA_ORI_perf,condPerf);
end
figure; plot(-0.2:0.001:0.8,squeeze(mean(cond_MUA_ORI_perf)))

plot(-0.2:0.001:0.8,squeeze(mean(cond_MUA_ORI_perf)))
plot(-0.2:0.001:0.8,squeeze(mean(cond_MUA_DIR_perf)))
plot(-0.2:0.001:0.8,squeeze(mean(cond_MUA_perf)))
plot(-0.2:0.001:0.8,squeeze(mean(cond_MUA_DIR_perf)))
plot(-0.2:0.001:0.8,squeeze(mean(cond_MUA_ORI_perf)))

figure; imagesc(-0.2:0.001:0.8,1:215,squeeze(mean(cond_perf_spec_DIR)))
hold on; ciplot(squeeze(mean(cond_MUA_ORI_perf))-(squeeze(std(cond_MUA_ORI_perf))/sqrt(220)),squeeze(mean(cond_MUA_ORI_perf))+(squeeze(std(cond_MUA_ORI_perf))/sqrt(220)),-0.2:0.001:0.8)

figure; plot(-0.2:0.001:0.8,squeeze(mean(cond_MUA_ORI_perf)))
hold on; ciplot(squeeze(mean(cond_MUA_ORI_perf))-(squeeze(std(cond_MUA_ORI_perf))),squeeze(mean(cond_MUA_ORI_perf))+(squeeze(std(cond_MUA_ORI_perf))),-0.2:0.001:0.8)

figure; plot(-0.2:0.001:0.8,squeeze(std(cond_MUA_ORI_perf)))
hold on; ciplot(squeeze(mean(cond_MUA_ORI_perf))-(squeeze(std(cond_MUA_ORI_perf))/sqrt(220)*1.96),squeeze(mean(cond_MUA_ORI_perf))+(squeeze(std(cond_MUA_ORI_perf))/sqrt(220)*1.96),-0.2:0.001:0.8)

figure; plot(-0.2:0.001:0.8,squeeze(std(cond_MUA_ORI_perf)))
figure; plot(-0.2:0.001:0.8,squeeze(mean(cond_MUA_ORI_perf)))
hold on; ciplot(squeeze(mean(cond_MUA_ORI_perf))-(squeeze(std(cond_MUA_ORI_perf))/sqrt(220)*1.96),squeeze(mean(cond_MUA_ORI_perf))+(squeeze(std(cond_MUA_ORI_perf))/sqrt(220)*1.96),-0.2:0.001:0.8)
hold off; plot(-0.2:0.001:0.8,squeeze(mean(cond_MUA_ORI_perf)))
hold on; ciplot(squeeze(mean(cond_MUA_ORI_perf))-(squeeze(std(cond_MUA_ORI_perf))/sqrt(220)*1.96),squeeze(mean(cond_MUA_ORI_perf))+(squeeze(std(cond_MUA_ORI_perf))/sqrt(220)*1.96),-0.2:0.001:0.8)
hold off; plot(-0.2:0.001:0.8,squeeze(mean(cond_MUA_DIR_perf)))
hold off; plot(-0.2:0.001:0.8,squeeze(mean(cond_MUA_perf)))
hold on; ciplot(squeeze(mean(cond_MUA_perf))-(squeeze(std(cond_MUA_perf))/sqrt(220)*1.96),squeeze(mean(cond_MUA_perf))+(squeeze(std(cond_MUA_perf))/sqrt(220)*1.96),-0.2:0.001:0.8)

figure; plot(-0.2:0.001:0.8,squeeze(mean(mean(cond_perf_spec_DIR),2)))


cond_Wave_perf_spec_all2 = []; for k = 1:length(good)
load(strcat(peerdir,'bayes/TFR/',sessions_all{good(k)}))
cond_Wave_perf_spec_all2 = cat(1,cond_Wave_perf_spec_all2,cond_perf_spec);
end

cond_Wave_perf_spec_all3 = []; for k = 1:length(good)
load(strcat(peerdir,'bayes/TFR/',sessions_all{good(k)}))
cond_Wave_perf_spec_all3 = cat(1,cond_Wave_perf_spec_all3,cond_perf_spec);
end

cond_rate_timwin_perf_spec_all = []; for k = 1:length(good)
load(strcat(peerdir,'bayes/',sessions_all{good(k)}(1:9),'_MUA_timwin_ori_decode'))
cond_rate_timwin_perf_spec_all = cat(1,cond_rate_timwin_perf_spec_all,condPerf);
end


figure
plot(powCfg.toi,squeeze(max(mean(cond_Wave_perf_spec_all2(:,40:90,:)))))
hold on; ciplot(squeeze(max(mean(cond_Wave_perf_spec_all2(:,40:90,:))))-(squeeze(std(max(cond_Wave_perf_spec_all2(:,40:90,:),[],2)))/sqrt(220)*1.96),squeeze(max(mean(cond_Wave_perf_spec_all2(:,40:90,:))))+(squeeze(std(max(cond_Wave_perf_spec_all2(:,40:90,:),[],2)))/sqrt(220)*1.96),-0.2:0.001:0.8)
axis square
set(gca,'TickDir','out')

goox = [7 8 10 11 12 13 15 16 17 18 19 20 21 22 24 25 26 29 30 31 36 40 41 42 43 44 47 48 49 57 73];
g=union(good,goox);

cond_Wave_perf_spec_all2 = []; for k = 1:length(g)
load(strcat(peerdir,'bayes/TFR/',sessions_all{g(k)}))
cond_Wave_perf_spec_all2 = cat(1,cond_Wave_perf_spec_all2,cond_perf_spec);
end

cond_Wave_perf_spec_all3 = []; for k = 1:length(g)
load(strcat(peerdir,'bayes/TFR/',sessions_all{g(k)}))
cond_Wave_perf_spec_all3 = cat(1,cond_Wave_perf_spec_all3,cond_perf_spec);
end

cond_rate_perf_spec_all = []; for k = 1:length(g)
load(strcat(peerdir,'bayes/MUA/',sessions_all{g(k)}(1:9),'_MUA_decode'))
cond_rate_perf_spec_all = cat(1,cond_rate_perf_spec_all,condPerf);
end

figure, imagesc(freq.time,freq.freq,squeeze(mean(cond_Wave_perf_spec_all3)))
axis square
set(gca,'TickDir','out','YDir','normal');


figure 
hold off
plot(powCfg.toi,squeeze(max(mean(cond_Wave_perf_spec_all2(:,40:90,:)))))
hold on; ciplot(squeeze(max(mean(cond_Wave_perf_spec_all2(:,40:90,:))))-(squeeze(std(mean(cond_Wave_perf_spec_all2(:,40:90,:),2)))/sqrt(530)*1.96),squeeze(max(mean(cond_Wave_perf_spec_all2(:,40:90,:))))+(squeeze(std(mean(cond_Wave_perf_spec_all2(:,40:90,:),2)))/sqrt(530)*1.96),-0.2:0.001:0.8)
plot(powCfg.toi,squeeze(max(mean(cond_Wave_perf_spec_all2(:,3:20,:)))))
ciplot(squeeze(max(mean(cond_Wave_perf_spec_all2(:,3:20,:))))- ...
  (squeeze(std(mean(cond_Wave_perf_spec_all2(:,3:20,:),2)))/sqrt(530)*1.96), ...
  squeeze(max(mean(cond_Wave_perf_spec_all2(:,3:20,:))))+ ...
  (squeeze(std(mean(cond_Wave_perf_spec_all2(:,3:20,:),2)))/sqrt(530)*1.96),-0.2:0.001:0.8)
plot(powCfg.toi,ones(length(powCfg.toi))*1/8,'r')
axis([-0.2 0.8 0 0.35])
axis square
set(gca,'TickDir','out')
plot(powCfg.toi,squeeze(mean(cond_rate_perf_spec_all)))
hold on; ciplot(squeeze(mean(cond_rate_perf_spec_all))-(squeeze(std(cond_rate_perf_spec_all))/sqrt(530)*1.96),squeeze(mean(cond_rate_perf_spec_all))+(squeeze(std(cond_rate_perf_spec_all))/sqrt(530)*1.96),-0.2:0.001:0.8)



figure; 
scatterhist(squeeze(mean(cond_rate_perf_spec_all(:,202:end-30),2)), squeeze(mean(max(cond_Wave_perf_spec_all2(:,40:90,202:end),[],2),3)))



plot(powCfg.toi,squeeze(max(mean(cond_Wave_perf_spec_all2(:,5:20,:)))))
ciplot(squeeze(max(mean(cond_Wave_perf_spec_all2(:,5:20,:))))- ...
  (squeeze(std(mean(cond_Wave_perf_spec_all2(:,5:20,:),2)))/sqrt(530)*1.96), ...
  squeeze(max(mean(cond_Wave_perf_spec_all2(:,5:20,:))))+ ...
  (squeeze(std(mean(cond_Wave_perf_spec_all2(:,5:20,:),2)))/sqrt(530)*1.96),-0.2:0.001:0.8)



cond_Wave_DIR_perf_spec_all2 = []; for k = 1:length(g)
load(strcat(peerdir,'bayes/TFR/',sessions_all{g(k)}(1:22),'3_Dir_decode'))
cond_Wave_DIR_perf_spec_all2 = cat(1,cond_Wave_DIR_perf_spec_all2,cond_perf_spec);
end

cond_Wave_DIR_perf_spec_all3 = []; for k = 1:length(g)
load(strcat(peerdir,'bayes/TFR/',sessions_all{g(k)}(1:22),'3_Dir_decode')))
cond_Wave_DIR_perf_spec_all3 = cat(1,cond_Wave_DIR_perf_spec_all3,cond_perf_spec);
end

cond_rate_DIR_perf_spec_all = []; for k = 1:length(g)
load(strcat(peerdir,'bayes/MUA/',sessions_all{g(k)}(1:9),'_MUA_Dir_decode'))
cond_rate_DIR_perf_spec_all = cat(1,cond_rate_DIR_perf_spec_all,condPerf);
end

figure, imagesc(freq.time,freq.freq,squeeze(mean(cond_Wave_DIR_perf_spec_all3)))
axis square
set(gca,'TickDir','out','YDir','normal');


figure
plot(powCfg.toi,squeeze(max(mean(cond_Wave_DIR_perf_spec_all2(:,40:90,:)))))
hold on; ciplot(squeeze(max(mean(cond_Wave_DIR_perf_spec_all2(:,40:90,:))))-(squeeze(std(mean(cond_Wave_DIR_perf_spec_all2(:,40:90,:),2)))/sqrt(530)*1.96),squeeze(max(mean(cond_Wave_DIR_perf_spec_all2(:,40:90,:))))+(squeeze(std(mean(cond_Wave_DIR_perf_spec_all2(:,40:90,:),2)))/sqrt(530)*1.96),-0.2:0.001:0.8)
plot(powCfg.toi,ones(length(powCfg.toi))*1/16,'r')
axis([-0.2 0.8 0 0.35])
axis square
set(gca,'TickDir','out')
plot(powCfg.toi,squeeze(mean(cond_rate_DIR_perf_spec_all)))
hold on; ciplot(squeeze(mean(cond_rate_DIR_perf_spec_all))-(squeeze(std(cond_rate_DIR_perf_spec_all))/sqrt(530)*1.96),squeeze(mean(cond_rate_DIR_perf_spec_all))+(squeeze(std(cond_rate_DIR_perf_spec_all))/sqrt(530)*1.96),-0.2:0.001:0.8)


figure
plot(powCfg.toi,squeeze(max(mean(cond_Wave_DIR_perf_spec_all2(:,40:90,:)))))
hold on; ciplot(squeeze(max(mean(cond_Wave_DIR_perf_spec_all2(:,40:90,:))))-(squeeze(std(mean(cond_Wave_DIR_perf_spec_all2(:,40:90,:),2)))/sqrt(530)*1.96),squeeze(max(mean(cond_Wave_DIR_perf_spec_all2(:,40:90,:))))+(squeeze(std(mean(cond_Wave_DIR_perf_spec_all2(:,40:90,:),2)))/sqrt(530)*1.96),-0.2:0.001:0.8)
plot(powCfg.toi,squeeze(max(mean(cond_Wave_DIR_perf_spec_all2(:,5:20,:)))))
ciplot(squeeze(max(mean(cond_Wave_DIR_perf_spec_all2(:,5:20,:))))- ...
  (squeeze(std(mean(cond_Wave_DIR_perf_spec_all2(:,5:20,:),2)))/sqrt(530)*1.96), ...
  squeeze(max(mean(cond_Wave_DIR_perf_spec_all2(:,5:20,:))))+ ...
  (squeeze(std(mean(cond_Wave_DIR_perf_spec_all2(:,5:20,:),2)))/sqrt(530)*1.96),-0.2:0.001:0.8)
plot(powCfg.toi,ones(length(powCfg.toi))*1/16,'r')
axis([-0.2 0.8 0 0.35])
axis square
set(gca,'TickDir','out')
plot(powCfg.toi,squeeze(mean(cond_rate_DIR_perf_spec_all)))
hold on; ciplot(squeeze(mean(cond_rate_DIR_perf_spec_all))-(squeeze(std(cond_rate_DIR_perf_spec_all))/sqrt(530)*1.96),squeeze(mean(cond_rate_DIR_perf_spec_all))+(squeeze(std(cond_rate_DIR_perf_spec_all))/sqrt(530)*1.96),-0.2:0.001:0.8)


%% compare sessions (MUA/LFP)

figure;
scatterhist(squeeze(mean(cond_rate_perf_spec_all(:,202:end-30),2)), squeeze(mean(max(cond_Wave_perf_spec_all2(:,40:90,202:end),[],2),3)))
axis([0.1 0.5 0.1 0.5])
hold on
plot(0.1:0.01:0.5,0.1:0.01:0.5,'r')
axis square

figure, scatterhist(squeeze(mean(cond_rate_DIR_perf_spec_all(:,202:end-30),2)), squeeze(mean(max(cond_Wave_DIR_perf_spec_all2(:,40:90,202:end),[],2),3)))
axis([0.1 0.5 0.1 0.5])
hold on
plot(0.1:0.01:0.5,0.1:0.01:0.5,'r')
axis square
axis([0.1 0.4 0.1 0.4])
set(gca,'TickDir','out')
scatterhist(squeeze(mean(cond_rate_perf_spec_all(:,202:end-30),2)), squeeze(mean(max(cond_Wave_perf_spec_all2(:,40:90,202:end),[],2),3)),'.')




