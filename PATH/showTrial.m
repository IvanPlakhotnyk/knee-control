function showTrial(trials,N)
    currentTrialN = N;
    figure
    tiledlayout(2,1);
    nexttile;
    angle_p = plot(trials.angle_deg{currentTrialN});
    grid on;
    nexttile;
    ligA_p = plot(trials.lig_a{currentTrialN});
    hold on
    grid on
    aHSPeaks_p = plot(trials.aHSPeaks{currentTrialN});
    aHSPredictorPeaks_p = plot(trials.aHSPredictorPeaks{currentTrialN});
    ligP_p = plot(trials.lig_p{currentTrialN});
    t  = title('Trial ',N);
    while true 
        %// Get a button from the user
        [~,~,b] = ginput(1);
        %// Left click
        %// Use this for left arrow
        %// if b == 28
        if b == 28
            %// Check to make sure we don't go out of bounds
            if currentTrialN+1 > numel(trials.angle_deg)
                currentTrialN = 1; %// Move to the start
            else
                currentTrialN = currentTrialN+1;
            end

        %// Right click
        %// Use this for right arrow
        %// elseif b == 29
        elseif b == 29
            if currentTrialN-1 < 1
                currentTrialN = 1; %// Move to the start
            else
                currentTrialN = currentTrialN-1;
            end
        %// Check for escape
        elseif b == 27
           break;
        end
        % Update the plot data
        set(angle_p, 'YData', trials.angle_deg{currentTrialN});
        set(ligA_p, 'YData', trials.lig_a{currentTrialN});
        set(aHSPeaks_p, 'YData', trials.aHSPeaks{currentTrialN});
        set(ligP_p, 'YData', trials.lig_p{currentTrialN});
        set(aHSPredictorPeaks_p, 'YData', trials.aHSPredictorPeaks{currentTrialN})
        title('Trial ', currentTrialN)
        drawnow;
    end

end