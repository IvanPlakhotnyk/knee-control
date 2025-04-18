function filtered_data = butterworthFilter(data, sampling_freq)
    % Define filter parameters
    cutoff_freq = 6;  % Hz - typical for gait analysis
    filter_order = 4; % Common choice for biomechanics
    
    % Normalize cutoff frequency
    nyquist_freq = sampling_freq/2;
    normalized_cutoff = cutoff_freq/nyquist_freq;
    
    [b, a] = butter(filter_order, normalized_cutoff, 'low');
    % Apply filter (using filtfilt for zero-phase filtering)
    filtered_data = filtfilt(b, a, data);

end