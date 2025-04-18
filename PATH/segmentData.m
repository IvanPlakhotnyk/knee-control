function trials = segmentData(angle, daq, emg, peaks)
    % Find indices where peaks occur
    peaks_indices = find(peaks);
    
    % Initialize variables
    frame = daq.frame;
    time = daq.time;
    knee_angle = angle;
    lig_a = daq.lig_a;
    lig_p = daq.lig_p;  % Was missing in your original function
    muscA = emg.mucsA;  % Fixed variable name (mucsA -> muscA)
    muscB = emg.mucsB;  % Fixed variable name (mucsB -> muscB)
    
    % Initialize cell array to store segment tables
    segments = cell(length(peaks_indices)-1, 1);
    
    % Extract segments between peaks
    for i = 1:length(peaks_indices)-1
        startIdx = peaks_indices(i);      % Start at a peak
        endIdx = peaks_indices(i+1) - 1;  % End right before the next peak
        
        % Extract the segment data
        segment_frame = frame(startIdx:endIdx);
        segment_time = time(startIdx:endIdx);
        segment_knee_angle = knee_angle(startIdx:endIdx);
        segment_lig_a = lig_a(startIdx:endIdx);
        segment_lig_p = lig_p(startIdx:endIdx);
        segment_muscA = muscA(startIdx:endIdx);
        segment_muscB = muscB(startIdx:endIdx);
        
        % Create table for this segment
        segments{i} = table(segment_frame, segment_time, segment_knee_angle, ...
                           segment_lig_a, segment_lig_p, segment_muscA, segment_muscB, ...
                           'VariableNames', {'frame', 'time', 'knee_angle', 'lig_a', 'lig_p', 'muscA', 'muscB'});
    end
    
    % Set output to segments
    trials = segments;
end