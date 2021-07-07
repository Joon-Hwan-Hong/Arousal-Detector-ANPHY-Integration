%% NOTE
% to control debugging and testing process during scrip editing.
% 
% for the recordings, the following are required:
% 
% need EDF for preprocessing
% EKG/ECG label or channel is necessary
% EMG derivations (L & R Flex or chin)
%
% also the remote desktop crashes when I try to load the entire .EDF, need
% to load specific channels
%
% currently, two patient samples seem to fit the criteria EP1659 and EP1373
% out of all of them.
%

%% INITIALIZING
% restarting to initial conditions
disp('starting testing script ...');
initialize;

%% PREPROCESSING
% mimics PreprocessNewData.m
des_fs = 128;
dirIndex = paths;
ftype = 'mni';
p_edf = 'D:\Project\Sana\P1\FA536671.edf';

% --> into LoadEDF
disp('starting LoadEDF ...');
% get A2, A1, EKG1-EKG2, C3, EOG, RFLEX-LFLEX
list_signals = [11, 22, 53:54, 55:56, 152, 221:224];
[hdr,data] = LoadEDF(p_edf, ftype);

% --> into preprocess.resampleData
disp('starting preprocess.resampleData ...');
[hdr,data] = preprocess.resampleData(data, hdr, des_fs);
 
% --> into preprocess.filterData
disp('starting preprocess.filterData ...');
data = preprocess.filterData(data,hdr,1);

% back to PreprocessNewData.m
int_size = int64(size(data,2)/des_fs);
ar_seq = zeros(1,int_size);
W = ar_seq;

% --> into exportData
disp('starting exportData ...');
file_name = 'FA536671_C3.txt';
dir_name = 'D:\Project\MAD_OUT\';
MAD_output = filepath(dir_name, file_name);
exportData(data, ar_seq, W, hdr, filepath(p_output, file_name));

%% ***** POSTPROCESSING I: Binerization *****
% use these after python script ran.

T1 = 0.15;          % arousal prediction threshold (o.g. 0.225)
T2 = 0.45;          % wake prediction threshold
[ar_prob,w_prob,ar_prob2,w_prob2] = getPred(MAD_output, T1, T2);

% summarizing & clean up.
prediction.arousal = ar_prob; 
prediction.arousal_BEE = ar_prob2; % with batch edge error
prediction.wake = w_prob;
prediction.wake_BEE = w_prob2;
clear ar_prob ar_prob2 w_prob w_prob2 dir_name file_name T1 T2

% Arousal result plotting
%basic_plot(prediction);
%basic_hist(prediction);

%% ***** POSTPROCESSING II: Reformat & exclude wake*****

% Reshaping to indicate onset and duration
%[ans_arousal, ans_wake] = reformatting(prediction);
%[ans_arousal_128, ans_wake_128] = reformatting(prediction, 1);
[ans_arousal_2000, ~] = reformatting(prediction, 2);
ans_arousal_2000(:,1) = ans_arousal_2000(:,1) + 2000;
clear prediction MAD_output

% Exclude samples in wake
ans_arousal = removeWake(StatusItems, ans_arousal_2000, 36000);
clear StatusItems ans_arousal_2000 
save('tmp_workspace');

% now run 2010 matlab version to run the sigFi scripts
!"C:\Program Files (x86)\MATLAB\R2010bSP2\bin\matlab.exe" -nosplash -r "userpath('D:\Project\'); addpath(genpath('SigFI')); addpath(genpath('Recordings from the arousal study'));

% afterwards
delete tmp_workspace.mat


%% extracting from .EDF to matlab?
% remember to load mat file for the results from mGetStatusItemTime
%extractTimes(RecStartTime, EvtTimes);
%closeness = 5 * 2000;   % arbitrary window of 5 seconds to define 'close enough'







