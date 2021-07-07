%% Initializing script for COMP401 project
% 
% adds test/debug string paths. p_output is set as well. p_edf should be
% manually changed.
%
% Justin Hong

%% code
clear all
userpath('D:\Project\');

test.FileName = 'D:\Project\Recordings from the arousal study\EP1041\EP1041_BF.SIG';
test.MtgName = 'SLEEP';
test.edf = 'D:\Project\Recordings from the arousal study\EP1373\EP1373_2BF.edf';

% for testing, EP1555 was chosen
p_edf = test.edf;
% p_edf = '';
p_output = 'D:\Project\OUT\';
