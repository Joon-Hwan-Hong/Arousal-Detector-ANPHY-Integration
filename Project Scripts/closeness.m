function [counter] = closeness(arr_arousal,arr_pred, boundary)
%
%

    counter = 0;
    % really inefficient but whatever, academic programming practices.
    for i = 1:length(arr_arousal)

        selcted_arousal = arr_arousal(i,1);
        interval = [selcted_arousal - boundary, selcted_arousal + boundary];

        for j = 1:length(arr_pred)

            selected_pred = arr_pred(j,1);

            % see if within the closeness boundary
            if (selected_pred > interval(:,1) && selected_pred < interval(:,2))
                % also get time format
%                 t_sel_arousal = seconds(selcted_arousal/2000);
%                 t_sel_arousal.Format = 'hh:mm:ss';
%                 t_sel_pred = seconds(selected_pred/2000);
%                 t_sel_pred.Format = 'hh:mm:ss';
                counter = counter + 1;

                % printing
%                 fprintf('Arousal at %d is close to predicted at %d, given boundary of +-%d samples\n', selcted_arousal, selected_pred, boundary);
%                 disp([t_sel_arousal, t_sel_pred]);
            end

        end

    end

end

