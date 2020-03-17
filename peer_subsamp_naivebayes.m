function peer_subsamp_naivebayes(cfg)

%% subsample the V1 channels...
% 
% pele_visualchans
% 
% load /mnt/hps/home/lewisc/public/pele/retino/raw/positionsPele.mat
% [the  r] = cart2pol(poss(:,1),poss(:,2));
% [lth thi] = sort(the);
% [l ri] = sort(r);
% 
% load /mnt/hps/home/lewisc/public/pele/retino/pele_retino_cond_trls.mat
% 
% %eccs = [1*ones(10,1)' 2*ones(10,1)' 3*ones(10,1)' 4*ones(10,1)' 5*ones(10,1)' 6*ones(10,1)'];
% %elevs = [1*ones(6,1)' 2*ones(6,1)' 3*ones(6,1)' 4*ones(6,1)' 5*ones(6,1)' 6*ones(6,1)' 7*ones(6,1)' 8*ones(6,1)' 9*ones(6,1)' 10*ones(6,1)'];
% %elev_trl = [];
% %ecc_trl = [];
% cond_trl = [];
% for i = 1:60
%   %ecc_trl = cat(1,ecc_trl,eccs(find(ri==i)) * ones(size(f_all{i},1),1));
%   %elev_trl = cat(1,elev_trl,elevs(find(thi==i)) * ones(size(f_all{i},1),1));
%   cond_trl = cat(1,cond_trl,i * ones(cond_trl_num(i),1));
% end
% 
% % across different sample sizes & reps
% 
% cfg = [];
% for i = 1:length(v1_ind) % v4_ind
%   cfg{i}.input = '/mnt/hps/slurm/lewisc/kurt_all_cond_freq_trls_retino.mat'; % /mnt/hps/slurm/lewisc/all_cond_freq_trls_v4
%   cfg{i}.sampz = i;  % size of subsample
%   cfg{i}.chan = v1_ind; % v4_ind
%   cfg{i}.time = 28:34; % kurt is freq.time(17:23)
%   cfg{i}.foi = 1:200;
%   cfg{i}.reps = 100;  % do it 100 times for each subsample size
%   cfg{i}.cond_trl = cond_trl;
%   cfg{i}.savename = sprintf('/mnt/hps/home/lewisc/public/pele/retino/naive/v1_subsamp_%02i_100_perf',i);
% end 
%   
%    cd /mnt/hps/slurm/lewisc/
  %  qsubcellfun(@peer_subsamp_naivebayes,cfg,'memreq',1024,'timreq',1024,'queue','6GB')
  
%   all_cond_freq_trls = [];
%   for i=1:60
%     load(sprintf('/mnt/hps/home/lewisc/public/pele/retino/tfr/data_pos%02i_tfr_trials.mat',i))
%     all_cond_freq_trls = cat(1,all_cond_freq_trls,freq.powspctrm(:,cfg.chan,cfg.foi,cfg.time));
%   end
%  save all_cond_freq_trls_v4 all_cond_freq_trls -v6 


load(cfg.input)
%all_cond_freq_trls = all_cond_freq_trls(:,:,:,cfg.time);

% train models
  
  for i = 1:cfg.reps
    subsam = randsample(1:length(cfg.chan),cfg.sampz);
    cond_class = NaiveBayes.fit(reshape(all_cond_freq_trls(1:2:end,subsam,:,:),[length(1:2:size(all_cond_freq_trls,1)) cfg.sampz*length(cfg.time)*length(cfg.foi)]),cfg.cond_trl(1:2:end));
    cond_pred = cond_class.predict(reshape(all_cond_freq_trls(2:2:end,subsam,:,:),[length(2:2:size(all_cond_freq_trls,1)) cfg.sampz*length(cfg.time)*length(cfg.foi)]));
    cond_test = cond_class.predict(reshape(all_cond_freq_trls(1:2:end,subsam,:,:),[length(1:2:size(all_cond_freq_trls,1)) cfg.sampz*length(cfg.time)*length(cfg.foi)]));
    samp_chans(i,:) = subsam;
    tmp = confusionmat(cfg.cond_trl(1:2:end),cond_test);
    cond_cmat(i,:,:) = confusionmat(cfg.cond_trl(2:2:end),cond_pred);    
    cond_test_spec(i,:) = sum(diag(tmp))/sum(sum(tmp));
    cond_perf_spec(i,:) = sum(diag(squeeze(cond_cmat(i,:,:))))/sum(sum(cond_cmat(i,:,:)));
  end
  
  save(cfg.savename,'cond_cmat','cond_perf_spec','cond_test_spec','samp_chans','-v6')
end
