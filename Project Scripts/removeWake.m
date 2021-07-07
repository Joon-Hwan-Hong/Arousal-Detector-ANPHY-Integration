function [cleaned_arr_arousal] = removeWake(StatusItems, arr_arousal, beginTime, lengthTime)
    % Removes arousal indices and onset if it is detected during wake phase
    % of the PSG recordings. StatusItems is from SigFI mGetStatusItems
    
    % default values
    if ~exist('beginTime', 'var')
            beginTime = 4000;
    end
    if ~exist('lengthTime', 'var')
            lengthTime = 60000;
    end

    % separate into arrays of sample onset and stage values
    arr_sample = StatusItems(:,2);
    arr_stage = StatusItems(:,4); 
    % get indices of when stage value is not 0 (i.e. sleeping)
    arr_sleep = find(arr_stage);
    arr_sleep_sample = lengthTime*(arr_sleep-1)+beginTime;
    % get array of wake on sample #
    arr_wake = setdiff(arr_sample, arr_sleep_sample);
    
    % pretty inefficient implementation, brute force but it works
    for i = 1:length(arr_arousal)
        selected_arousal = arr_arousal(i,1);
        for j = 1:length(arr_wake)
            % the interval of wake
            interval = [arr_wake(j,1), arr_wake(j,1)+lengthTime-1];
            % check if arousal index is in interval, then 0 the row
            if (selected_arousal >= interval(:,1) && selected_arousal <= interval(:,2))
                arr_arousal(i,:) = [0,0];
            end
        end
    end
    
    % delete rows with 0s.
    arr_arousal( ~any(arr_arousal, 2), : ) = [];
    cleaned_arr_arousal = arr_arousal;
    
end

