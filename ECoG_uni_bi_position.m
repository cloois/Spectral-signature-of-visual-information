sess = {'pe_004_01_rfp01_preproc_uni'
'pe_004_02_rfp01_preproc_uni'
'pe_005_02_rfp01_preproc_uni'
'pe_009_01_rfp01_preproc_uni'
'pe_005_01_rfp01_preproc_uni'};

wrkdir='/mnt/hpx/home/lewisc/public/pele/retino/unipolar/raw/';
for s=1:length(sess)
  load(strcat(wrkdir,sess{s}),'data')
  data_all{s}=data;
end

data=ft_appenddata([],data_all{:});


save(strcat(wrkdir,'pe_rfp01_quarterfield_all'),'data')


