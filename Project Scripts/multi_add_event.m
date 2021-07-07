function multi_add_event(FileName, GroupName, ar_matrix, Channel, LabelName)
    % this script needs to be ran in the MATLAB R2021b version.
    
    % default values
    if ~exist('Channel', 'var')
        Channel = 'F4-C4'; % arbitrary
    end
    if ~exist('LabelName', 'var')
        LabelName = 'Predicted Arousal'; % title
    end
    
    % iterate through prediction matrix and add events
    for i = 1:size(ar_matrix, 1)
        TimeStep = ar_matrix(i,1); % Time in sample
        Duation = ar_matrix(i,2); % Duration in sample
        mAddEvent(FileName, GroupName, Channel, LabelName, TimeStep, Duation, strcat('test','$'));
    end
    
    % close file
    mFileClose;
end