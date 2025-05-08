function filtered_signal = bandpass_filter(signal)
% BANDPASS_FILTER Applies a bandpass FIR filter to the input signal
%
% Usage:
%   filtered_signal = bandpass_filter(signal)
%
% Input:
%   signal - Input signal to be filtered (column vector)
%
% Output:
%   filtered_signal - Filtered signal
%
% Filter specifications:
%   - Sampling frequency: 200 Hz
%   - Low cutoff frequency: 0.25 Hz
%   - High cutoff frequency: 12 Hz
%   - FIR linear filter

% Define filter parameters
fs = 200;          % Sampling frequency (Hz)
low_cutoff = 0.25; % Lower cutoff frequency (Hz)
high_cutoff = 12;  % Higher cutoff frequency (Hz)

% Normalize cutoff frequencies to Nyquist frequency
nyquist = fs/2;
norm_low = low_cutoff/nyquist;
norm_high = high_cutoff/nyquist;

% Design the filter
% Use a more conservative filter order
order = 200;

% Use fir1 for a more reliable design
filter_coeff = fir1(order, [norm_low norm_high], 'bandpass');

% Check if filter coefficients are valid
if ~all(isfinite(filter_coeff))
    % If not valid, try a simpler approach with a lower order
    order = 100;
    filter_coeff = fir1(order, [norm_low norm_high], 'bandpass');
end

% Apply the filter using filtfilt for zero-phase filtering
filtered_signal = filtfilt(filter_coeff, 1, signal);

end