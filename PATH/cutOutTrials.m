function [angle_out, daq_out, emg_out] = cutOutTrials(angle, daq, emg, trial_nums)
%CUTOUTTRIALS Remove specific trials between heel strikes by setting them to NaN
%   [angle_out, daq_out, emg_out] = cutOutTrials(angle, daq, emg, trial_nums)
%
%   Inputs:
%   - angle: Motion capture angle data
%   - daq: DAQ data structure with .fsr field
%   - emg: EMG data structure, sampled at 10x the rate of angle and daq
%   - trial_nums: Array specifying which trials to remove
%
%   Outputs:
%   - angle_out: Data with specified trials set to NaN
%   - daq_out: Data with specified trials set to NaN
%   - emg_out: Data with specified trials set to NaN

% Find heel strikes
[~, heel_strikes_ind] = findpeaks(findPeaks(daq.fsr)); % Assuming findpeaks is a built-in function

% Check that heel_strikes_ind is a column vector to ensure consistent concatenation
if size(heel_strikes_ind, 2) > size(heel_strikes_ind, 1)
    heel_strikes_ind = heel_strikes_ind';
end

% Add the first index and last index to create complete segments
heel_strikes_ind = [1; heel_strikes_ind; size(daq, 1)];

% Initialize output variables (make copies of input data)
angle_out = angle;
daq_out = daq;
emg_out = emg;

% Check if requested trials are valid
if max(trial_nums) > length(heel_strikes_ind)-1
    error('Trial number exceeds available trials. Only %d trials available.', length(heel_strikes_ind)-1);
end

% EMG sample rate is 10x higher than other signals
emg_sample_rate_factor = 10;

% Set the specified trials to NaN
for i = 1:length(trial_nums)
    trial_idx = trial_nums(i);
    
    % Get start and end indices for this trial (for angle and daq)
    startIdx = heel_strikes_ind(trial_idx);
    endIdx = heel_strikes_ind(trial_idx+1) - 1;
    
    % Calculate corresponding indices for EMG (10x sample rate)
    emg_startIdx = ((startIdx-1) * emg_sample_rate_factor) + 1;
    emg_endIdx = endIdx * emg_sample_rate_factor;
    
    % Make sure EMG indices don't exceed array bounds
    emg_endIdx = min(emg_endIdx, size(emg, 1));
    
    % Set data to NaN for this trial range
    if ~isempty(angle)
        angle_out(startIdx:endIdx, :) = NaN;
    end
    
    % Handle daq data (handling it as a table)
    if istable(daq)
        % For tables, we need to set each numeric column to NaN
        for col = 1:width(daq)
            if isnumeric(daq{1, col})
                daq_out{startIdx:endIdx, col} = NaN;
            end
        end
    else
        % For numeric arrays
        daq_out(startIdx:endIdx, :) = NaN;
    end
    
    % Handle emg data similarly, but with adjusted indices
    if istable(emg)
        for col = 1:width(emg)
            if isnumeric(emg{1, col})
                emg_out{emg_startIdx:emg_endIdx, col} = NaN;
            end
        end
    else
        emg_out(emg_startIdx:emg_endIdx, :) = NaN;
    end
end

end