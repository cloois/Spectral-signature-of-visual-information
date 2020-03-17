peerdir = '/mnt/hpx/home/lewisc/public/bruss/';
addpath('~/Dropbox/code/CircStat2012a/');

% get sessions
sessions_trl

good = [14  32 38 39 50 51 52 54 55 58 59 60 61 62 63 64 66 67 68 69 70 72];
goox = [7 8 10 11 12 13 15 16 17 18 19 20 21 22 24 25 26 29 30 31 36 40 41 42 43 44 47 48 49 57 73];
g=union(good,goox);
session=sessions_all(g);


ori = (-pi/2:pi/8:pi/2); ori=ori(2:end);

% circular corr
for k=1:length(session)
  load(strcat(peerdir,'bayes/TFR/',session{k}(1:9),'_MUA_TFR_paired_ORI_decode'))
  for kk=1:1001
    [r(k,kk) p(k,kk) ]=circ_corrcc(ori(reshape(condPredSPK_append(:,kk,:),[], 1)),ori(reshape(condPredFRQ_append(:,kk,:),[], 1)));
  end
end


% difference in angle...
for k=1:length(session)
  load(strcat(peerdir,'bayes/TFR/',session{k}(1:9),'_MUA_TFR_paired_ORI_decode'))
  for kk=1:1001
    MUA_angle = ori(reshape(condPredSPK_append(:,kk,:),[], 1));
    LFP_angle = ori(reshape(condPredFRQ_append(:,kk,:),[], 1));
  end
end



% PLV
for k=1:length(session)
  load(strcat(peerdir,'bayes/TFR/',session{k}(1:9),'_MUA_TFR_paired_ORI_decode'))
  for kk=1:1001
    
    spk=ori(reshape(condPredSPK_append(:,kk,:),[], 1));
    lfp=ori(reshape(condPredFRQ_append(:,kk,:),[], 1));
    spk_u = [cos(spk) + sin(spk)*i];
    lfp_u = [cos(lfp) + sin(lfp)*i];
    spk_lfp=spk_u.* conj(lfp_u);
    plv_spk_lfp(k,kk) = abs(sum(spk_lfp)./length(spk_lfp));
  end
end

n = 1;
m = 1;

for k = 1:length(goox)
  load(strcat(peerdir,'bayes/',sessions_all{goox(k)}(1:9),'_MUA_TFR_paired_ORI_decode'))
  
  for kk=1:1001
    spk=ori(reshape(condPredSPK_append(:,kk,:),[], 1));
    lfp=ori(reshape(condPredFRQ_append(:,kk,:),[], 1));
    
    RP=n*spk-m*lfp; % relative phase
    plv_spk_lfp(k,kk,:)=abs(sum(exp(i*RP))/length(RP));
  end
end

figure; plot(mean(r))
figure; imagesc(r(5:end-3,:))

%% freq and time resolved correspondence

spk_lfp = [];
plv_spk_lfp_frq_time = [];
for k=1:length(session)
  load(strcat(peerdir,'bayes/',session{k}(1:9),'_MUA_TFR_paired_ORI_decode_time_freqs'))
  
  for f=1:200
    for kk=1:1001
      % circular corr
      [circ_corr_spk_lfp_frq_time(k,f,kk) p(k,f,kk) ]=circ_corrcc(ori(reshape(condPredSPK_append(:,kk,:),[], 1)),ori(reshape(condPredFRQ_append(:,f,kk,:),[], 1)));
      spk=ori(reshape(condPredSPK_append(:,kk,:),[], 1));
      lfp=ori(reshape(condPredFRQ_append(:,f,kk,:),[], 1));
      spk_u = [cos(spk) + sin(spk)*i];
      lfp_u = [cos(lfp) + sin(lfp)*i];
      %  spk_lfp{k}(f,kk,:)=spk_u.* conj(lfp_u);
      %  plv_spk_lfp_frq_time(k,f,kk) = abs(sum(spk_lfp{k}(f,kk,:))./length(spk_lfp{k}(f,kk,:)));
      spk_lfp=spk_u.* conj(lfp_u);
      % PLV
      plv_spk_lfp_frq_time(k,f,kk) = abs(sum(spk_lfp)./length(spk_lfp));
      % compute actual correspondence
      for o1=1:length(ori)
        tmp=lfp(find(spk==ori(o1)));
        for o2=1:length(ori)
          spk_lfp_confu(k,f,kk,o1,o2)=sum(tmp==ori(o2));
        end
      end
    end
  end
end

%% difference in vectors

% can do this on the cluster now,  see peer_decode_MUA_LFP_correspondence_angle

peer_decode_MUA_LFP_correspondence_angle(cfg)


% if you do that... then you have to correct for maximum angle being 90 deg

spk_lfp_dist_abs = abs(single(spk_lfp_dist));
spk_lfp_dist_abs(spk_lfp_dist_abs>2.5)=pi/8;
spk_lfp_dist_abs(spk_lfp_dist_abs>2.2)=pi/4;
spk_lfp_dist_abs(spk_lfp_dist_abs>1.8)=pi/2;

% figure, imagesc(mean(spk_lfp_dist_abs,3))

% so you can

for k=1:length(cfg)
  load(cfg{k}.save)
  all_spk_lfp_diff(k,:,:) = spk_lfp_diff;
  all_spk_lfp_std(k,:,:) = spk_lfp_std;
  all_spk_lfp_dist{k} = spk_lfp_dist;
  
  tmp = abs(single(spk_lfp_dist));
  tmp(tmp>2.5)=pi/8;
  tmp(tmp>2.2)=pi/4;
  tmp(tmp>1.8)=pi/2;

  all_spk_lfp_dist_mean(k,:,:) = mean(tmp,3);
end

figure, imagesc(squeeze(mean(all_spk_lfp_dist_mean))*180/pi)
figure, plot(squeeze(mean(all_spk_lfp_dist_mean(:,:,250:600),3))'*180/pi)


%%
spk_lfp_diff = [];
for k=1:length(session)
  load(strcat(peerdir,'bayes/',session{k}(1:9),'_MUA_TFR_paired_ORI_decode_time_freqs'))
  
  for f=1:200
    for kk=1:1001
      
      spk_lfp_diff(k,f,kk) =mean(abs(diag(circ_dist2(ori(reshape(condPredSPK_append(:,kk,:),[], 1)),ori(reshape(condPredFRQ_append(:,f,kk,:),[], 1))))));
    end
  end
end


%% compute actual ori correspondence
% baseline
spk=ori(reshape(condPredSPK_append(:,80,:),[], 1));
lfp=ori(reshape(condPredFRQ_append(:,65,80,:),[], 1));
spk_u = [cos(spk) + sin(spk)*i];
lfp_u = [cos(lfp) + sin(lfp)*i];
spk_lfp=spk_u.* conj(lfp_u);
mean(angle(spk_lfp))
figure, rose(angle(spk_lfp))

% stim
spk=ori(reshape(condPredSPK_append(:,280,:),[], 1));
lfp=ori(reshape(condPredFRQ_append(:,65,280,:),[], 1));
spk_u = [cos(spk) + sin(spk)*i];
lfp_u = [cos(lfp) + sin(lfp)*i];
spk_lfp=spk_u.* conj(lfp_u);
mean(angle(spk_lfp))
figure, rose(angle(spk_lfp))

% spk lfp confusion matrix
spk_lfp_confu=[];
for o1=1:length(ori)
  tmp=lfp(find(spk==ori(o1)));
  for o2=1:length(ori)
    spk_lfp_confu(o1,o2)=sum(tmp==ori(o2));
  end
end

%% plot scatter of SPK - LFP correspondence

[p,q]=meshgrid(ori);
pairs=[p(:) q(:)];

figure, hold on
scatter(pairs(:,1),pairs(:,2),spk_lfp_confu(:)*20+1,'r','filled')




%% joint errors



condPredSPK_append_all = [];
condPredFRQ_append_all = [];
frq_error_id = [];
spk_error_id = [];
correct_id = [];

for k=1:length(good)
  load(cfg{k}.savename)
  for kk=1:10
    condPredSPK_append_all = cat(1,condPredSPK_append_all,squeeze(condPredSPK_append(kk,:,:))');
    condPredFRQ_append_all = cat(1,condPredFRQ_append_all,squeeze(condPredFRQ_append(kk,:,:))');
  end
  correct_id = cat(1,correct_id,testSet_append);
end

ori = (pi/4:pi/4:2*pi)-pi/4;
figure; plot(mean(abs(ori(condPredFRQ_append_all)-repmat(ori(correct_id)',1,1001))))
figure; plot(mean(abs(ori(condPredSPK_append_all)-repmat(ori(correct_id)',1,1001))))

figure; plot(-0.2:0.001:0.8,mean(abs(ori(condPredSPK_append_all)-repmat(ori(correct_id)',1,1001))))
hold on; ciplot(mean(abs(ori(condPredSPK_append_all)-repmat(ori(correct_id)',1,1001)))-1.96*(std(abs(ori(condPredSPK_append_all)-repmat(ori(correct_id)',1,1001)))/sqrt(13000)),mean(abs(ori(condPredSPK_append_all)-repmat(ori(correct_id)',1,1001)))+1.96*(std(abs(ori(condPredSPK_append_all)-repmat(ori(correct_id)',1,1001)))/sqrt(13000)),-0.2:0.001:0.8)
set(gca,'ytick',0:pi/16:pi)
set(gca,'yticklabel',{'0','pi/16','pi/8','3 pi/16','pi/4','5 pi/16','3 pi/8', '7 pi/16', 'pi/2', '9 pi/16', '5 pi/8', '11 pi/16', '3 pi/4', '13 pi/16', '7 pi/8', '15 pi/16', 'pi'})

hold off; plot(-0.2:0.001:0.8,mean(abs(ori(condPredFRQ_append_all)-repmat(ori(correct_id)',1,1001))))
hold on; ciplot(mean(abs(ori(condPredFRQ_append_all)-repmat(ori(correct_id)',1,1001)))-1.96*(std(abs(ori(condPredFRQ_append_all)-repmat(ori(correct_id)',1,1001)))/sqrt(13000)),mean(abs(ori(condPredFRQ_append_all)-repmat(ori(correct_id)',1,1001)))+1.96*(std(abs(ori(condPredFRQ_append_all)-repmat(ori(correct_id)',1,1001)))/sqrt(13000)),-0.2:0.001:0.8)
set(gca,'ytick',0:pi/16:pi)
set(gca,'yticklabel',{'0','pi/16','pi/8','3 pi/16','pi/4','5 pi/16','3 pi/8', '7 pi/16', 'pi/2', '9 pi/16', '5 pi/8', '11 pi/16', '3 pi/4', '13 pi/16', '7 pi/8', '15 pi/16', 'pi'})


for k=1:length(good)
  load(cfg{k}.savename)
  for kk=1:1001
    [r(k,kk) p(k,kk) ]=corr(reshape(condPredSPK_append(:,kk,:),[], 1),reshape(condPredFRQ_append(:,kk,:),[], 1));
  end
end

figure; imagesc(r)

figure; plot(-0.2:0.001:0.8,squeeze(mean(r)))
hold on; ciplot(squeeze(mean(r))-1.96*squeeze(std(r))/sqrt(22),squeeze(mean(r))+1.96*squeeze(std(r))/sqrt(22),-0.2:0.001:0.8);


for k=1:1001
  spk_error{k} = find(~(condPredSPK_append_all(:,k)-correct_id)==0);
  frq_error{k} = find(~(condPredFRQ_append_all(:,k)-correct_id)==0);
  both_error{k} = intersect(spk_error{k},frq_error{k});
  relative_spk(k) = length(both_error{k})/length(spk_error{k});
  relative_frq(k) = length(both_error{k})/length(frq_error{k});
end


figure; plot(-0.2:0.001:0.8,relative_frq)
figure; plot(-0.2:0.001:0.8,relative_spk)

figure; plot(-0.2:0.001:0.8,relative_spk)
hold all; plot(-0.2:0.001:0.8,relative_frq)



