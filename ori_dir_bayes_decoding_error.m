ori = ori = (-pi/2:pi/8:pi/2); % center on 0
ori=ori(2:end);

dir = (pi/8:pi/8:2*pi)-pi/8; % center on 0

range = (0:30:330)*pi/180;


cd /mnt/hpx/home/lewisc/public/bruss/bayes/
load MUA/jeb010a02_MUA_Dir_decode.mat
load TFR/jeb010a02_TFR_wave_1ms3_Dir_decode.mat

tmp = [];
tmpp = squeeze(mean(condCmat(:,261,1,:)))*10;
for k = 1:length(dir)
tmp = cat(1,tmp,ones(tmpp(k),1)*dir(k));
end
rose(tmp)

tmpp = squeeze(mean(cond_cmat(:,63,448,1,:)))*10;
tmp = [];
for k = 1:length(dir)
tmp = cat(1,tmp,ones(tmpp(k),1)*dir(k));
end
rose(tmp)


%% now all together 
% MUA
cc = squeeze(mean(condCmat(:,261,:,:)))*10;
clear cc_
for k = 1:16
cc_(k,:)= circshift(cc(k,:),[0 -k+1]);
end
tot = sum(cc_);
tot=tot./sum(tot)*100;

tmp = [];
for k = 1:length(dir)
tmp = cat(1,tmp,ones(tot(k),1)*dir(k));
end
figure; rose(tmp,range)


% LFP
cc = squeeze(mean(cond_cmat(:,63,448,:,:)))*10;
clear cc_ 
for k = 1:16
cc_(k,:)= circshift(cc(k,:),[0 -k+1]);
end
tot = sum(cc_);
tot=tot./sum(tot)*100;

tmp = [];
for k = 1:length(dir)
tmp = cat(1,tmp,ones(tot(k),1)*dir(k));
end

figure; rose(tmp)

cd /mnt/hps/home/lewisc/public/bruss/bayes/

%% Orientation now all together 
load MUA/jeb010a02_MUA_decode
load TFR/jeb010a02_TFR_wave_1ms_3_decode.mat

%%% COME HERE
%%better ... ori was wrong
% MUA
% MUA
cc = squeeze(mean(condCmat(:,277,:,:)))*10;
cc_ = [];
for k = 1:length(ori)
cc_(k,:)= circshift(cc(k,:),[0 -k+1]);
end
tmp=circshift(sum(cc_)',[3])./sum(cc_(:))*100;
tmpp=[];
for k = 1:length(ori)
tmpp =cat(1,tmpp,ones(round(tmp(k)),1)*ori(k));
end
rose(tmpp,-pi/32:pi/8:2*pi-pi/32)


%LFP
cc = squeeze(mean(cond_cmat(:,63,446,:,:)))*10;
cc_ = [];
for k = 1:length(ori)
cc_(k,:)= circshift(cc(k,:),[0 -k+1]);
end
tmp=circshift(sum(cc_)',[3])./sum(cc_(:))*100;
tmpp=[];
for k = 1:length(ori)
tmpp =cat(1,tmpp,ones(round(tmp(k)),1)*ori(k));
end
figure, rose(tmpp,-pi/32:pi/8:2*pi-pi/32)



% calculate mean distance of errors for each 
mean(tot(2:end)/100.*abs(atan2(sin(ori(2:end)), cos(ori(2:end)))))

% histogram 
tot = sum(cc_);
tot = tot(2:end);
ori_dist = abs(atan2(sin(ori(2:end)), cos(ori(2:end))));

tmp = [];
for k = 1:length(ori_dist)
tmp = cat(1,tmp,ones(tot(k),1)*ori_dist(k));
end
figure; hist(tmp,4)


