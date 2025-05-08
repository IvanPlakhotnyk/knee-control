function showTrial(trials,N)
    currentTrialN = N;
    currentTrial = trials{N};
    figure
    tiledlayout(2,1);
    nexttile;
    angle_p = plot(currentTrial.knee_angle);
    grid on;
    nexttile;
    ligA_p = plot(currentTrial.lig_a);
    hold on
    grid on
    ligP_p = plot(currentTrial.lig_p);
    t  = title('Trial ',N);

    while true 
        %// Get a button from the user
        [~,~,b] = ginput(1);
        %// Left click
        %// Use this for left arrow
        %// if b == 28
        if b == 28
            %// Check to make sure we don't go out of bounds
            if currentTrialN+1 > numel(trials)
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
        currentTrial = trials{currentTrialN};
        set(angle_p, 'YData', currentTrial.knee_angle);
        set(ligA_p, 'YData', currentTrial.lig_a);
        set(ligP_p, 'YData', currentTrial.lig_p);
        title('Trial ', currentTrialN)
        drawnow;
    end

end