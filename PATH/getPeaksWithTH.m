function data_peaks = getPeaksWithTH(data, threshold, NUM_SAMPLES_SEPARATION)
    % Initialize output vector with zeros
    arguments
        data; 
        threshold; 
        NUM_SAMPLES_SEPARATION = 0;
    end
    data_peaks = zeros(size(data)); 
    % Find peaks using MATLAB's findpeaks function
    [peak_values, peak_indices] = findpeaks(data, 'MinPeakHeight', threshold);
    % Place peak values at their original indices in the output vector
    data_peaks(peak_indices) = peak_values;
    cnt = 0;
    for i = 1:size(data_peaks)
        if data_peaks(i) && cnt > NUM_SAMPLES_SEPARATION
            data_peaks(i) = 1;
            cnt = 0;
        else
            data_peaks(i) = 0;
        end
        cnt = cnt+1;
    end
end