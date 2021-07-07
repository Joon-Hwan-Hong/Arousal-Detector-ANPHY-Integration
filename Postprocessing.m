clear 

%% param vars
FileName = 'D:\Project\Sana\P3\JA5650SL.edf';
GroupName = 'arousal_detection';
file_name = 'JA5650SL.txt';
dir_name = 'D:\Project\MAD_OUT\';
original_fs = 2000;
T1 = 0.05;          % arousal prediction threshold (o.g. 0.225)
T2 = 0.45;          % wake prediction threshold
LabelLoc = 'P4-M1';

%% script process
% Binerize perdictions
MAD_output = filepath(dir_name, file_name);
[ar_prob,w_prob,ar_prob2,w_prob2] = getPred(MAD_output, T1, T2);
prediction.arousal = ar_prob; 
prediction.arousal_BEE = ar_prob2;
prediction.wake = w_prob;
prediction.wake_BEE = w_prob2;

% Reshaping to indicate onset and duration
[ans_arousal_2000, ~] = reformatting(prediction, 2);
ans_arousal_2000(:,1) = ans_arousal_2000(:,1) + original_fs;

% Obtain StatusItems for sleep stages
save('tmp_workspace');
while exist('tmp_workspace.mat', 'file')==0
    pause(1);
end
!"C:\Program Files (x86)\MATLAB\R2010bSP2\bin\matlab.exe" -nosplash -r "userpath('D:\Project\'); addpath(genpath('SigFI')); addpath(genpath('Project Scripts')); load('tmp_workspace'); [PropHeader, StatusItems, DetChan] = mGetStatusItems(FileName, 'Stage', 'AllEventInGroup'); save('tmp_StatusItem'); clear EventName GroupName; exit"
count = 0;
while exist('tmp_StatusItem.mat', 'file')==0
    pause(1);
end
delete tmp_workspace.mat
load('tmp_StatusItem');

% Exclude samples in wake
ans_arousal = removeWake(StatusItems, ans_arousal_2000, StatusItems(1,2), StatusItems(1,3));
save('tmp_workspace');

% Run 2010 matlab version to run the sigFi scripts to load into .STS
while exist('tmp_workspace.mat', 'file')==0
    pause(1);
end
!"C:\Program Files (x86)\MATLAB\R2010bSP2\bin\matlab.exe" -nosplash -r "userpath('D:\Project\'); addpath(genpath('SigFI')); addpath(genpath('Recordings from the arousal study')); addpath(genpath('Project Scripts')); load('tmp_workspace'); mCreateGroup(FileName, GroupName, 'YELLOW', 'INTERV', 'ANY', 'Addition$'); multi_add_event(FileName, GroupName, ans_arousal, LabelLoc); mFileClose; exit"

% Clean up temporary files and workspace
disp('Postprocessing Pipeline Finished, Check Recording.');
pause(2);       % could implement a FLAG to see if 2010 ran properly but this also works.
delete tmp_workspace.mat tmp_StatusItem.mat
