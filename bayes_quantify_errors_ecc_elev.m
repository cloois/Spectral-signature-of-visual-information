
load monkey/pele/retinotopy/pele_bayes_retino_classify_errorDist.mat


% evaluate the MI of the eccentricity and the elevation in the 60 Cond
% classification CMat


figure;
for i = 1:60
  for t=1:111
    subplot(2,1,1); hold off;  plot(poss(:,1),poss(:,2),'.'); hold on
    scatter(poss(:,1),poss(:,2),cond_cmat(75,t,i,:)*20+1,'r','filled')
    plot(poss(i,1),poss(i,2),'k*'); title(sprintf('cond %d time point = %f',i,time(t)))
    subplot(2,1,2); hold off;  plot(poss(:,1),poss(:,2),'.'); hold on
    scatter(poss(:,1),poss(:,2),cond_cmat(75,t,:,i)*20+1,'r','filled')
    plot(poss(i,1),poss(i,2),'k*'); title(sprintf('cond %d time point = %f',i,time(t)))
    pause
  end
end

load /mnt/hps/home/lewisc/donders/pele/retinotopy/results/positionsPele.mat
poss_dist = dist(poss');

% compute intersection of each stimulus
[the  r] = cart2pol(poss(:,1),poss(:,2));
[lth thi] = sort(the);
[l ri] = sort(r);
ecc_rad = [0.60*ones(10,1)
            0.67*ones(10,1)
            0.73*ones(10,1)
            0.80*ones(10,1)
          0.87*ones(10,1)
          0.93*ones(10,1)];

for i = 1:60
g(ri(i),:)=[poss(ri(i),1),poss(ri(i),2),ecc_rad(i)];
poss_area(ri(i),:)=pi*ecc_rad(i).^2;
end

% absolute intersect 
poss_intersect = area_intersect_circle_analytical(g);
% percentage intersect
poss_intrsct_per = bsxfun(@rdivide,area_intersect_circle_analytical(g),poss_area);

cond_intersect = cond_cmat .* permute(repmat(poss_intersect,[1 1 200 111]),[3 4 1 2]);
cond_intersect_per = cond_cmat .* permute(repmat(poss_intrsct_per,[1 1 200 111]),[3 4 1 2]);

all_cond_intsct = sum(reshape(cond_intersect,[200 111 60*60]),3)./sum(reshape(cond_cmat,[200 111 60*60]),3);
all_cond_intsct_per = sum(reshape(cond_intersect_per,[200 111 60*60]),3)./sum(reshape(cond_cmat,[200 111 60*60]),3);

%figure; surf(all_cond_intsct(:,:))
figure; imagesc(all_cond_intsct), set(gca,'YDir','normal','TickDir','out'), colorbar
figure; imagesc(all_cond_intsct_per), set(gca,'YDir','normal','TickDir','out'), colorbar

% compute intersection for each time point & each freq JUST FOR ERRORS


cond_cmat_noSelf = cond_cmat;
for i = 1:200
for j = 1:111, for k = 1:60, 
cond_cmat_noSelf(i,j,k,k) = 0;
end
end
end

cond_error_intersect = cond_cmat_noSelf .* permute(repmat(poss_intersect,[1 1 200 111]),[3 4 1 2]);
cond_error_intersect_per = cond_cmat_noSelf .* permute(repmat(poss_intrsct_per,[1 1 200 111]),[3 4 1 2]);

all_cond_error_intrsct = sum(reshape(cond_error_intersect,[200 111 60*60]),3)./sum(reshape(cond_cmat_noSelf,[200 111 60*60]),3);
all_cond_error_intsct_per = sum(reshape(cond_error_intersect_per,[200 111 60*60]),3)./sum(reshape(cond_cmat_noSelf,[200 111 60*60]),3);

figure, imagesc(all_cond_error_intrsct), set(gca,'YDir','normal','TickDir','out'), colorbar
figure; imagesc(all_cond_error_intsct_per), set(gca,'YDir','normal','TickDir','out'), colorbar


%% compute mean distance off for each time point & each freq

cond_dist = cond_cmat .* permute(repmat(poss_dist,[1 1 200 111]),[3 4 1 2]);

all_cond_dist = sum(reshape(cond_dist,[200 111 60*60]),3)./sum(reshape(cond_cmat,[200 111 60*60]),3);

%figure; surf(all_cond_dist(:,:))
figure; imagesc(all_cond_dist(:,:)), set(gca,'YDir','normal','TickDir','out'), colorbar


% compute mean distance off for each time point & each freq JUST FOR ERRORS

cond_dist = cond_cmat .* permute(repmat(poss_dist,[1 1 200 111]),[3 4 1 2]);

cond_cmat_noSelf = cond_cmat;
for i = 1:200
for j = 1:111, for k = 1:60, 
cond_cmat_noSelf(i,j,k,k) = 0;
end
end
end

all_cond_error_dist = sum(reshape(cond_dist,[200 111 60*60]),3)./sum(reshape(cond_cmat_noSelf,[200 111 60*60]),3);

figure; imagesc(all_cond_error_dist,[0 mean(poss_dist(:))]), set(gca,'YDir','normal','TickDir','out'), colorbar




%% likelihood weighted 

load /mnt/hps/slurm/lewisc/pele_all_cond_freq_time_trls_retino.mat
load /mnt/hps/slurm/lewisc/pele_all_cond_freq_time_trls_retino_CONDS.mat

load /mnt/hps/home/lewisc/public/pele/retino/bayes/posterior/classify_even_odd.mat


for i = 1:200
for j = 1:111
cond_class{i,j} = NaiveBayes.fit(squeeze(all_cond_freq_trls(1:2:end,:,i,j)),cond_trl(1:2:end));
[posterior(i,j,:,:) pred(i,j,:) logp(i,j,:)] = cond_class{i,j}.posterior(squeeze(all_cond_freq_trls(2:2:end,:,i,j)));
cond_cmat(i,j,:,:) = confusionmat(cond_trl(2:2:end),squeeze(pred(i,j,:)));
cond_perf_spec(i,j,:) = sum(diag(squeeze(cond_cmat(i,j,:,:))))/sum(sum(cond_cmat(i,j,:,:)));
end
end

figure; plot(squeeze(posterior(80,22,1,:)))

veridical = cond_trl(2:2:end);

load /mnt/hps/home/lewisc/donders/pele/retinotopy/results/positionsPele.mat
poss_dist = dist(poss');

for i = 1:200
for j = 1:111
  time_freq_trial_dist(i,j,:) =  squeeze(max(posterior(i,j,:,:),[],4)) .* poss_dist(sub2ind([60 60],squeeze(pred(i,j,:)),veridical(:)));
end
end
  
figure; imagesc(squeeze(mean(time_freq_trial_dist,3)),[0 mean(poss_dist(:))]), set(gca,'YDir','normal');

% compute mean distance off for each time point & each freq JUST FOR ERRORS
time_freq_trial_dist_error  = time_freq_trial_dist;
time_freq_trial_dist_error(time_freq_trial_dist_error==0)=nan;
figure; imagesc(nanmean(time_freq_trial_dist,3),[0 mean(poss_dist(:))]), set(gca,'YDir','normal');



%% look at elevation and eccentricity
[ecc tmp ecc_ind]=unique(round(r));
[elev tmp elev_ind]=unique(round(the*10));
elev_ind(elev_ind==10) = 9;
elev_ind(elev_ind==11) = 10;
elev = 1:10;


ecc_cmat = zeros(200,111,6,6);
elev_cmat = zeros(200,111,10,10);

for i=1:length(ecc)
  for j=1:length(ecc)
    ecc_cmat(:,:,i,j) = sum(reshape(cond_cmat(:,:,ecc_ind==i,ecc_ind==j),[200 111 10*10]),3);
  end
end

for i=1:length(elev)
  for j=1:length(elev)
    elev_cmat(:,:,i,j) = sum(reshape(cond_cmat(:,:,elev_ind==i,elev_ind==j),[200 111 6*6]),3);
  end
end

for i = 1:length(freq)
for j = 1:length(time)
ecc_perf_spec(i,j,:) = sum(diag(squeeze(ecc_cmat(i,j,:,:))))/sum(sum(ecc_cmat(i,j,:,:)));
elev_perf_spec(i,j,:) = sum(diag(squeeze(elev_cmat(i,j,:,:))))/sum(sum(elev_cmat(i,j,:,:)));
end
end


