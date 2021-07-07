function basic_hist(prediction)

    % can refractor using Image Processing Toolbox for cleaner code 
    % https://www.mathworks.com/matlabcentral/answers/16356-finding-sequences-of-1-s-values
    
    % Arousal prediction
    out = zeros(size(prediction.arousal));
    ii = strfind([0,prediction.arousal(:)'],[0 1]);
    out(ii) = strfind([prediction.arousal(:)',0],[1 0]) - ii + 1;
    ar_durations = out(out~=0);
    
    % Wake prediction
    out = zeros(size(prediction.wake));
    ii = strfind([0,prediction.wake(:)'],[0 1]);
    out(ii) = strfind([prediction.wake(:)',0],[1 0]) - ii + 1;
    w_durations = out(out~=0);    
    
    % plotting
    figure('name', 'Distribution of Durations for Predicted Arousals and Wake');
    
    subplot(1,2,1);
    histogram(ar_durations);
    title('Distribution of Duration for Predicted Arousals');
    xlabel('Time');
    ylabel('Frequency');
    
    subplot(1,2,2);
    histogram(w_durations);
    title('Distribution of Duration for Predicted Wake');
    xlabel('Time');
    ylabel('Frequency');    
    
end