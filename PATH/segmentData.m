function trials = segmentData(angle, daq, peaks)
    % Find indices where peaks occur
    peaks_indices = find(peaks);
    
    % Initialize variables
    frame = daq.frame;
    time = daq.time;
    knee_angle = angle;
    lig_a = daq.lig_a;
    lig_p = daq.lig_p; 
    lig_aFilt = daq.lig_aFilt;
    lig_pFilt = daq.lig_pFilt;
    
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
        segment_lig_aFilt = lig_aFilt(startIdx:endIdx);
        segment_lig_p = lig_p(startIdx:endIdx);
        segment_lig_pFilt = lig_pFilt(startIdx:endIdx);

        
        % Create table for this segment
        segments{i} = table(segment_frame, segment_time, segment_knee_angle, ...
                           segment_lig_a, segment_lig_p, segment_lig_aFilt, segment_lig_pFilt, ...
                           'VariableNames', {'frame', 'time', 'knee_angle', 'lig_a', 'lig_p', 'lig_aFilt', 'lig_pFilt'});
    end
    
    % Set output to segments
    trials = segments;
end