function events = eventDetector(signal, threshold, minSeparation)
% EVENTDETECTOR Detects events in a signal based on specified criteria
%
% Inputs:
%   signal          - Input signal vector
%   threshold       - Threshold value that signal must exceed for an event
%   minSeparation   - Minimum number of samples between events (N)
%
% Output:
%   events - Binary vector same size as signal, with 1s marking HS locations


    % Validate inputs
    validateattributes(signal, {'numeric'}, {'vector'});
    validateattributes(threshold, {'numeric'}, {'scalar'});
    validateattributes(minSeparation, {'numeric'}, {'positive', 'integer', 'scalar'});
    
    % Initialize output vector
    events = zeros(size(signal));
    
    % Get signal length
    signalLength = length(signal);
    
    % Initialize variables for tracking
    lastEventPos = 0;
    
    % Starting with 2 , because of signal(i-1).
    for i = 2:signalLength
        % Check if we're past the minimum separation from the last event
        if i - lastEventPos <= minSeparation && lastEventPos > 0
            continue;
        end
        
        % Check for threshold crossing
        if signal(i) - signal(i-1) > threshold
            events(i) = 1;
            lastEventPos = i;
        end
    end
    
    % Handle the case of no events found
    if sum(events) == 0
        warning('No events detected with the given parameters');
    end
end