if 1
  
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

  
else


% StimulusProtocol description:
% jeb, lil, nic

% StimulusProtocol description: GratingToPlaids

% jeb has only 1 channel
% session = {'jeb004a01','lil028a01'};
% offset = -1000;
% spontaneous= [-1 0];
% gratings = [0 1];
% plaids = [1 2];

session = {'jeb007a01','jeb007a04','jeb007a05','jeb008a01','jeb008a02','lil024a04',...
  'lil024a05','lil025a01','lil025a02','lil025a03','lil025a04','lil025a05','lil025a06'...
  ,'lil025a07','lil027a07','lil027a08','lil027a09','lil027a10','lil027a11','lil028a02'...
  ,'lil028a03','lil028b01','lil028b02','lil028b03','lil028c01','lil029a01','lil029a02'...
  ,'lil029a03','lil029a04','lil029a05','lil030a01','lil030a02','lil030a03','lil031a01'...
  ,'lil031b01','lil031b02','lil031c01','lil032a02','lil032a03'};

offset = -800;
spontaneous= [-0.8 0];
gratings = [0 1.2];
plaids = [1.2 2.2];

session = {'jeb009a02'};

offset = -800;
spontaneous= [-0.8 0];
gratings = [0 0.7];
plaids = [0.7 2.2];

session = {'jeb010a02','jeb011a02','jeb012a02','jeb013a02','jeb013a07','jeb013a08'...
  'jeb014a07','jeb014a08','jeb015a07','jeb015a08','jeb016a06','jeb016a08','jeb016a09'...
  ,'jeb017a04','jeb024a01','jeb025a01'};

offset = -800;
spontaneous= [-0.8 0];
gratings = [0 1];
plaids = [1 2.2];

session = {'lil026a01','lil026a02','lil026b01','lil027a04','lil027a06'};

offset = -500;
spontaneous= [-0.5 0];
gratings = [0 1.5];
plaids = [1.5 2.5];

% StimulusProtocol description: GratingToPlaidsToGrating
session = {'jeb020a02','jeb022a02','jeb023a02','nic002a04','nic018a02','nic018a03',...
  'nic033b01','nic042a02','nic043a02','nic045a03','nic049a02','nic050a02','nic055a02'...
  ,'nic055a03','nic057a02','nic059a02'};

offset = -800;
spontaneous= [-0.8 0];
gratings = [0 0.8];
plaids = [0.8 1.6];
gratings = [1.6 2.4];

% StimulusProtocol description: PlaidsToGratingsToPlaids
session = {'jeb021a03','nic002a02','nic002a03','nic002a05','nic003a02','nic003b01','nic004b02'...
  ,'nic005a02','nic006a02','nic007a02','nic008a02','nic009a02','nic010a02','nic011a02'...
  ,'nic012a02','nic013a02','nic014a02','nic015a02','nic016b02','nic016c01','nic016c03'...
  ,'nic017a02','nic018a05','nic019a02','nic021a02','nic021a03','nic022a02','nic023a02'...
  ,'nic023a03','nic024a02','nic025a02','nic026a02','nic027a02','nic028a02','nic029a02'...
  ,'nic029a03','nic030a02','nic031a02','nic032a02','nic033a02','nic041a02','nic044a02'...
  ,'nic045a02','nic046a02','nic047a02','nic048a02'};

offset = -800;
spontaneous= [-0.8 0];
plaids = [0 0.8];
gratings = [0.8 1.6];
plaids = [1.6 2.4];


%% sessions with sorted SUA

session = {'jeb007a05','jeb016a09','lil031b01','nic013a02','nic025a02','nic043a02','jeb008a01',...
  'jeb017a04','lil031b02','nic015a02','nic026a02','nic044a02','jeb011a02','jeb020a02',...
  'lil031c01','nic016b02','nic028a02','nic045a02','jeb012a02','nic048a02','nic049a02',...
  'jeb021a03','lil027a07','lil032a02','nic016c01','nic029a02','nic045a03','jeb013a02',...
  'jeb013a07','jeb025a01','lil027a10','lil027a09','nic002a02','nic016c03','nic029a03','nic046a02',...
  'jeb013a08','lil024a04','lil027a11','nic002a04','nic002a03','nic017a02','nic030a02','nic047a02',...
  'jeb014a07','lil024a05','lil028a01','nic002a05','nic019a02','nic040a02','nic018a05','nic031a02',...
  'jeb014a08','lil025a05','lil028c01','nic003a02','nic021a02','nic040a03','nic050a02',...
  'jeb015a07','lil025a06','lil029a02','nic004b02','nic021a03','nic040a04','nic055a02',...
  'jeb015a08','lil025a07','lil029a03','nic005a02','nic023a02','nic040a05','nic055a03',...
  'jeb016a06','lil029a04','nic009a02','nic023a03','nic041a02','nic057a02','jeb023a02',...
  'jeb016a08','lil030a01','nic011a02','nic024a02','nic042a02','nic059a02'};
offset = -800;

session = {'lil026a01','lil026a02','lil026b01','lil027a04','lil027a06'};
offset = -500;

% all

session = {'jeb007a05','jeb016a09','lil031b01','nic013a02','nic025a02','nic043a02','jeb008a01',...
  'jeb017a04','lil031b02','nic015a02','nic026a02','nic044a02','jeb011a02','jeb020a02','lil026a01',...
  'lil031c01','nic016b02','nic028a02','nic045a02','jeb012a02','nic048a02','nic049a02','lil026a02',...
  'jeb021a03','lil027a07','lil032a02','nic016c01','nic029a02','nic045a03','jeb013a02','lil026b01',...
  'jeb013a07','jeb025a01','lil027a10','lil027a09','nic002a02','nic016c03','nic029a03','nic046a02',...
  'jeb013a08','lil024a04','lil027a11','nic002a04','nic002a03','nic017a02','nic030a02','nic047a02',...
  'jeb014a07','lil024a05','lil028a01','nic002a05','nic019a02','nic040a02','nic018a05','nic031a02',...
  'jeb014a08','lil025a05','lil028c01','nic003a02','nic021a02','nic040a03','nic050a02','lil027a04',...
  'jeb015a07','lil025a06','lil029a02','nic004b02','nic021a03','nic040a04','nic055a02','lil027a06',...
  'jeb015a08','lil025a07','lil029a03','nic005a02','nic023a02','nic040a05','nic055a03',...
  'jeb016a06','lil029a04','nic009a02','nic023a03','nic041a02','nic057a02','jeb023a02',...
  'jeb016a08','lil030a01','nic011a02','nic024a02','nic042a02','nic059a02'};

end
