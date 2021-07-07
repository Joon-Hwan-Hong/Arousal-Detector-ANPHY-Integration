function basic_plot(prediction)
    figure('name', 'Prediction Results');

    subplot(2, 2, 1);
    plot(prediction.arousal);
    xlim([0 length(prediction.arousal)]);
    title('Arousal Prediction');
    xlabel('Time');
    ylabel('Boolean');

    subplot(2, 2, 2);
    plot(prediction.arousal_BEE);
    xlim([0 length(prediction.arousal_BEE)]);
    title('Arousal Prediction w/ batch edge error');
    xlabel('Time');
    ylabel('Magnitude');

    subplot(2, 2, 3);
    plot(prediction.wake);
    xlim([0 length(prediction.wake)]);
    title('Wake Prediction');
    xlabel('Time');
    ylabel('Boolean');

    subplot(2, 2, 4);
    plot(prediction.wake_BEE);
    xlim([0 length(prediction.wake_BEE)]);
    title('Wake Prediction w/ batch edge error');
    xlabel('Time');
    ylabel('Magnitude');
end