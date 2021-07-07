function [ans_arousal, ans_wake] = reformatting(prediction, int_type, BOOL_wake)
    % based on: 
    % https://www.mathworks.com/matlabcentral/answers/16356-finding-sequences-of-1-s-values
    % https://www.mathworks.com/matlabcentral/answers/392391-find-position-of-when-0-goes-to-1
    %
    % input:
    % results from getPred() from MAD, int_type is choosing if you want to
    % know in sample # instead of time in seconds.
    %
    % output: 
    % length:2 matrix where 1st column indicate onset timesteps, 2nd column
    % indicate duration.
    %
    if ~exist('BOOL_wake', 'var')
        BOOL_wake = 0;
    end
    if ~exist('int_type','var')
        int_type = 0;
    else
        samp_freq = 128;
        orig_freq = 2000;
    end
    
    % calculate durations and index of onset
    arousal_durations = [regionprops(prediction.arousal, 'Area').Area]';
    arousal_onset = strfind(prediction.arousal', [0 1])';
    ans_arousal = cat(2, arousal_onset, arousal_durations);
    
    if (BOOL_wake == 1)
        wake_durations = [regionprops(prediction.wake, 'Area').Area]';
        wake_onset = strfind(prediction.wake', [0 1])';
        ans_wake = cat(2, wake_onset, wake_durations);
    else
        ans_wake = [];
    end
    
    % if want to look at the sample # instead of time in sec.
    if int_type == 1
        ans_arousal = ans_arousal * samp_freq;
        %ans_wake = ans_wake * samp_freq;
    elseif int_type == 2
        ans_arousal = ans_arousal * orig_freq;
        %ans_wake = ans_wake * orig_freq;
    end
    
end