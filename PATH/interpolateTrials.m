function interpTrials = interpolateTrials(trials)
    assert(iscell(trials),"The trials must be passed as a cell(1xN) array");
    max_samples = max(cellfun(@(x) size(x, 1), trials));

    interpTrials = cell(size(trials));

    for i = 1:length(trials)
        current_trial = trials{i};
        n_samples = size(current_trial, 1);
        if n_samples == max_samples
            interpTrials{i} = current_trial.';
        else
            x_orig = linspace(0, max_samples, n_samples);
            x_new = 0:(max_samples-1);
            interpData = interp1(x_orig, current_trial, x_new, 'spline');
            interpTrials{i} = interpData;
        end
    end


