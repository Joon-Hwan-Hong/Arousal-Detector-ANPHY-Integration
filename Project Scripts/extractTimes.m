function [dt_when, dt_when_samp] = extractTimes(RecStartTime, EvtTimes, SampFreq)
% From the results obtained from SigFI mGetStatusItemTime, covert the date
% strings to a actual time format (datetime) to process and determine when
% in seconds and in # of sample to compare numerically with predicted
% arousals.
%
% Justin Hong
%

    if ~exist('SampFreq', 'var')
            SampFreq = 2000;
    end

    % change cell strings to datetime class values
    dt_EvtTimes = datetime(EvtTimes, 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
    dt_RecStart = datetime(RecStartTime, 'InputFormat', 'yyyy-MM-dd HH:mm:ss');

    % obtain when in seconds
    dt_when = seconds(dt_EvtTimes - dt_RecStart);

    % convert this based on sampling frequency (default 2000)
    dt_when_samp = dt_when * SampFreq;

end

