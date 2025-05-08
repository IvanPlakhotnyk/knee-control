function [meanDiff, stdDiff, eventDiffs, missedEvents, falseEvents] = benchmarkEventDetection(detectedEvents, groundTruth, maxDistance)
% BENCHMARKEVENTDETECTION Evaluates the performance of event detection
%
% Inputs:
%   detectedEvents - Binary vector with detected events
%   groundTruth    - Binary vector with ground truth events
%   maxDistance    - Maximum allowed distance between detected and ground truth events to be considered a match
%
% Outputs:
%   meanDiff     - Mean time difference between matched events
%   stdDiff      - Standard deviation of time differences
%   eventDiffs   - Vector of time differences for all matched events
%   missedEvents - Number of ground truth events that were not detected
%   falseEvents  - Number of detected events that don't match ground truth


    % Validate inputs
    validateattributes(detectedEvents, {'numeric'}, {'vector', 'binary'});
    validateattributes(groundTruth, {'numeric'}, {'vector', 'binary', 'size', size(detectedEvents)});
    validateattributes(maxDistance, {'numeric'}, {'positive', 'scalar'});
    
    % Find indices of events
    detectedIdx = find(detectedEvents);
    groundTruthIdx = find(groundTruth);
    
    % Initialize outputs
    eventDiffs = [];
    missedEvents = 0;
    falseEvents = 0;
    
    % Match detected events with ground truth events
    matchedGroundTruth = false(size(groundTruthIdx));
    matchedDetected = false(size(detectedIdx));
    
    % For each ground truth event, find the closest detected event within maxDistance
    for i = 1:length(groundTruthIdx)
        gtPos = groundTruthIdx(i);
        distances = abs(detectedIdx - gtPos);
        [minDist, minIdx] = min(distances);
        
        % If a matching detected event is found within maxDistance
        if minDist <= maxDistance && ~matchedDetected(minIdx)
            eventDiffs(end+1) = detectedIdx(minIdx) - gtPos;
            matchedGroundTruth(i) = true;
            matchedDetected(minIdx) = true;
        end
    end
    
    % Count missed and false events
    missedEvents = sum(~matchedGroundTruth);
    falseEvents = sum(~matchedDetected);
    
    % Calculate statistics
    if ~isempty(eventDiffs)
        meanDiff = mean(abs(eventDiffs));
        stdDiff = std(eventDiffs);
    else
        meanDiff = NaN;
        stdDiff = NaN;
        warning('No matching events found between detected events and ground truth');
    end
    
    % Display results
    fprintf('Performance Metrics:\n');
    fprintf('- Mean time difference: %.2f samples\n', meanDiff);
    fprintf('- Standard deviation: %.2f samples\n', stdDiff);
    fprintf('- Number of matched events: %d\n', length(eventDiffs));
    fprintf('- Number of missed events: %d\n', missedEvents);
    fprintf('- Number of false detections: %d\n', falseEvents);
    
    % Calculate additional metrics if desired
    precision = length(eventDiffs) / (length(eventDiffs) + falseEvents);
    recall = length(eventDiffs) / (length(eventDiffs) + missedEvents);
    f1Score = 2 * (precision * recall) / (precision + recall);
    
    fprintf('- Precision: %.4f\n', precision);
    fprintf('- Recall: %.4f\n', recall);
    fprintf('- F1 Score: %.4f\n', f1Score);
end