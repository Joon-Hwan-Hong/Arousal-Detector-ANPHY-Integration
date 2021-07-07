%% run_2010.m
% 
% Class w/ static functions of SigFI that requires use of MATLAB 2010b
% Generally functions by loading transferred varaibles into a workspace,
% then load in MATLAB 2010, and process and transfer output into another
% temp workspace. Then load back into the 2021 MATLAB version.
% 
% Justin Hong
%

%% Currently Implemented Functions
%
% mGetFileLength - get file length in number of records, samples and seconds
% mGetNumChan  - get the number of channels of the recording montage
% mGetMtgList      - get names of all the montages associated with the file 
% mGetDataSamp - read data block given the offset and the duration in number of samples
% mGetChanLabel - get the channel labels of a specific montage
% mGetEvtGrpList - retrieve event group list
%

%% Code
% https://www.mathworks.com/help/matlab/matlab_env/startup-options.html

classdef run_2010
    methods(Static)

        
        %%%%%%%%%%%%%%%%
        function [NumRecs, NumSamps, NumSecs] = mGetFileLength(FileName)
            % transfer required variable(s) to workspace
            assignin('base', 'FileName', FileName);
            save('tmp_workspace');
            
            % run function in MATLAB 2010
            !"C:\Program Files (x86)\MATLAB\R2010bSP2\bin\matlab.exe" -nosplash -r "userpath('D:\Project\'); load('tmp_workspace'); addpath(genpath('SigFI'));  addpath(genpath('Recordings from the arousal study')); [NumRecs, NumSamps, NumSecs] = mGetFileLength(FileName); save('tmp_workspace2'); exit"
            
            % load in data from 2010 function and clean up
           while ~isfile('tmp_workspace2.mat')
                pause(1)
            end
           load('tmp_workspace2');
           assignin('base', 'NumRecs', NumRecs);
           assignin('base', 'NumSamps', NumSamps);
           assignin('base', 'NumSecs', NumSecs);
           delete tmp_workspace.mat tmp_workspace2.mat 
        end
        
        
        %%%%%%%%%%%%%%%%
        function [NumOfChan] = mGetNumChan(FileName)
            % transfer required variable(s) to workspace
            assignin('base', 'FileName', FileName);
            save('tmp_workspace');        
            
            % run function in MATLAB 2010
            !"C:\Program Files (x86)\MATLAB\R2010bSP2\bin\matlab.exe" -nosplash -r "userpath('D:\Project\'); load('tmp_workspace'); addpath(genpath('SigFI'));  addpath(genpath('Recordings from the arousal study')); [NumOfChan] = mGetNumChan(FileName); save('tmp_workspace2'); exit" 
            
            % load in data from 2010 function and clean up
           while ~isfile('tmp_workspace2.mat')
                pause(1)
            end
           load('tmp_workspace2');
           assignin('base', 'NumOfChan', NumOfChan);
           delete tmp_workspace.mat tmp_workspace2.mat             
        end
        
        
        %%%%%%%%%%%%%%%%
        function mGetMtgList(FileName)
            % transfer required variable(s) to workspace
            assignin('base', 'FileName', FileName);
            save('tmp_workspace');
            
            % run function in MATLAB 2010
            !"C:\Program Files (x86)\MATLAB\R2010bSP2\bin\matlab.exe" -nosplash -r "userpath('D:\Project\'); load('tmp_workspace'); addpath(genpath('SigFI'));  addpath(genpath('Recordings from the arousal study')); MtgList = mGetMtgList(FileName); save('tmp_workspace2', 'MtgList'); exit"
            
            % load in data from 2010 function and clean up
            while ~isfile('tmp_workspace2.mat')
                pause(1)
            end
            load('tmp_workspace2');
            assignin('base', 'MtgList', MtgList);
            delete tmp_workspace.mat tmp_workspace2.mat
        end

        
        %%%%%%%%%%%%%%%%
        function [EegData, SampRate] = mGetDataSamp(FileName, OffsetSamp, DurationSamp, MtgName)
            % transfer required variable(s) to workspace
            assignin('base', 'FileName', FileName); 
            assignin('base', 'OffsetSamp', OffsetSamp); 
            assignin('base', 'DurationSamp', DurationSamp); 
            assignin('base', 'MtgName', MtgName); 
            save('tmp_workspace');
            
            % run function in MATLAB 2010
            !"C:\Program Files (x86)\MATLAB\R2010bSP2\bin\matlab.exe" -nosplash -r "userpath('D:\Project\'); load('tmp_workspace'); addpath(genpath('SigFI'));  addpath(genpath('Recordings from the arousal study')); [EegData, SampRate] = mGetDataSamp(FileName, OffsetSamp, DurationSamp, MtgName); EegData = EegData'; save('tmp_workspace2'); exit"
            
            % load in data from 2010 function and clean up
            while ~isfile('tmp_workspace2.mat')
                pause(1)
            end
            load('tmp_workspace2');
            assignin('base', 'EegData', EegData);
            assignin('base', 'SampRate', SampRate);
            delete tmp_workspace.mat tmp_workspace2.mat
        end

        
        %%%%%%%%%%%%%%%%
        function [ChanLabel] = mGetChanLabel(FileName, MtgName)
            % transfer required variable(s) to workspace
            assignin('base', 'FileName', FileName);
            assignin('base', 'MtgName', MtgName); 
            save('tmp_workspace');
            
            % run function in MATLAB 2010
            !"C:\Program Files (x86)\MATLAB\R2010bSP2\bin\matlab.exe" -nosplash -r "userpath('D:\Project\'); load('tmp_workspace'); addpath(genpath('SigFI'));  addpath(genpath('Recordings from the arousal study')); [ChanLabel] = mGetChanLabel(FileName, MtgName); save('tmp_workspace2'); exit"
           
            % load in data from 2010 function and clean up
            while ~isfile('tmp_workspace2.mat')
                 pause(1)
            end
            load('tmp_workspace2');
            assignin('base', 'ChanLabel', ChanLabel);
            clear ans
            delete tmp_workspace.mat tmp_workspace2.mat
        end
        
        function [GrpList] = mGetEvtGrpList(FileName)
            % transfer required variable(s) to workspace
            assignin('base', 'FileName', FileName);
            save('tmp_workspace');      
            
            % run function in MATLAB 2010
            !"C:\Program Files (x86)\MATLAB\R2010bSP2\bin\matlab.exe" -nosplash -r "userpath('D:\Project\'); load('tmp_workspace'); addpath(genpath('SigFI'));  addpath(genpath('Recordings from the arousal study')); [GrpList] = mGetEvtGrpList(FileName); save('tmp_workspace2'); exit"
            
            % load in data from 2010 function and clean up
            while ~isfile('tmp_workspace2.mat')
                 pause(1)
            end
            load('tmp_workspace2');
            assignin('base', 'GrpList', GrpList);
            delete tmp_workspace.mat tmp_workspace2.mat            
            
        end
        
    end
end