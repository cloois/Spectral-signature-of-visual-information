function peer_decode_MUA_LFP_correspondence_angle(cfg)
%
% peerdir = '/mnt/hpx/home/lewisc/public/bruss/';
%
% sessions_trl
% good = [14  32 38 39 50 51 52 54 55 58 59 60 61 62 63 64 66 67 68 69 70 72];
% goox = [7 8 10 11 12 13 15 16 17 18 19 20 21 22 24 25 26 29 30 31 36 40 41 42 43 44 47 48 49 57 73];
% g=union(good,goox);
% session=sessions_all(g);
%
% cfg = [];
% for k=1:length(session)
% cfg{k}.input = strcat(peerdir,'bayes/',session{k}(1:9),'_MUA_TFR_paired_ORI_decode_time_freqs');
% cfg{k}.save = strcat(peerdir,'bayes/',session{k}(1:9),'_MUA_LFP_correspondence_angle');
% end
%
% cd /mnt/hps/slurm/lewisc/
% qsubcellfun(@peer_decode_MUA_LFP_correspondence_angle,cfg,'memreq',1024,'timreq',1024,'queue','8GB')


addpath('/mnt/hpx/slurm/lewisc/matlab/utilities/CircStat2012a/');
ori = (-pi/2:pi/8:pi/2); ori=ori(2:end);

load(cfg.input)

spk_lfp_diff = [];

for f=1:200
  for kk=1:1001
    spk_lfp_diff(f,kk) =mean(abs(diag(circ_dist2(ori(reshape(condPredSPK_append(:,kk,:),[], 1)),ori(reshape(condPredFRQ_append(:,f,kk,:),[], 1))))));
    spk_lfp_std(f,kk) =std(abs(diag(circ_dist2(ori(reshape(condPredSPK_append(:,kk,:),[], 1)),ori(reshape(condPredFRQ_append(:,f,kk,:),[], 1))))));
    spk_lfp_dist(f,kk,:) =diag(circ_dist2(ori(reshape(condPredSPK_append(:,kk,:),[], 1)),ori(reshape(condPredFRQ_append(:,f,kk,:),[], 1))));
    
  end
end

save(cfg.save,'spk_lfp_diff','spk_lfp_std','spk_lfp_dist')

end