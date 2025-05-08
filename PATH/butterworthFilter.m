function filtered_data = butterworthFilter(data, sampling_freq, type)
    % Define filter parameters
    low_cutoff_freq = 0.25; % Hz - lower bound of bandpass
    high_cutoff_freq = 12;  % Hz - upper bound of bandpass
    filter_order = 4;       % Lower order for bandpass is typically sufficient
    
    % Check for non-finite values
    nan_indices = find(isnan(data));
    inf_indices = find(isinf(data));
    if ~isempty(nan_indices) || ~isempty(inf_indices)
        disp('Warning: Input data contains non-finite values');
        disp(['Found ' num2str(length(nan_indices)) ' NaN values']);
        disp(['Found ' num2str(length(inf_indices)) ' Inf values']);
        
        % Option 1: Remove non-finite values (replace with interpolated values)
        valid_indices = find(isfinite(data));
        if length(valid_indices) > 1
            x_valid = valid_indices;
            y_valid = data(valid_indices);
            x_all = 1:length(data);
            data = interp1(x_valid, y_valid, x_all, 'linear', 'extrap');
            disp('Replaced non-finite values with interpolated values.');
        else
            error('Too many non-finite values to interpolate reliably.');
        end
    end
    
    % Normalize cutoff frequencies
    nyquist_freq = sampling_freq/2;
    normalized_low_cutoff = low_cutoff_freq/nyquist_freq;
    normalized_high_cutoff = high_cutoff_freq/nyquist_freq;
    
    if(isequal(type, 'bandpass'))
        [b, a] = butter(filter_order, [normalized_low_cutoff, normalized_high_cutoff], 'bandpass');
    elseif(isequal(type, 'low'))
        [b, a] = butter(filter_order, normalized_high_cutoff, 'low');
    else
        throw('Filter must be low or bandpass')
    end
    
    % Apply filter (using filtfilt for zero-phase filtering)
    filtered_data = filtfilt(b, a, data);
end