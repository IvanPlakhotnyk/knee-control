function plotFFT(signal, Fs, varargin)
% PLOTFFT Creates a fully labeled FFT plot with proper frequency scaling
%
% USAGE:
%   plotFFT(signal, Fs)
%   plotFFT(signal, Fs, 'PlotType', 'magnitude')
%   plotFFT(signal, Fs, 'PlotType', 'magnitude', 'xScale', 'linear')
%
% INPUTS:
%   signal - Input time domain signal (vector)
%   Fs     - Sampling frequency in Hz
%
% OPTIONAL NAME-VALUE PAIRS:
%   'PlotType' - String specifying the plot type: 'magnitude' (default), 
%                'power', 'db', or 'phase'
%   'xScale'   - String specifying x-axis scale: 'linear' (default) or 'log'
%   'yScale'   - String specifying y-axis scale: 'linear' (default) or 'log'
%   'xLim'     - Two-element vector specifying x-axis limits [min max]
%   'Title'    - String for plot title (default: 'FFT Analysis')
%
% OUTPUTS:
%   Figure with properly labeled FFT plot
%
% EXAMPLE:
%   t = 0:0.001:1;
%   x = sin(2*pi*50*t) + 0.5*sin(2*pi*120*t);
%   plotFFT(x, 1000, 'PlotType', 'db', 'xLim', [0 200]);

% Parse input arguments
p = inputParser;
validPlotTypes = {'magnitude', 'power', 'db', 'phase'};
validScales = {'linear', 'log'};

addRequired(p, 'signal', @isvector);
addRequired(p, 'Fs', @isscalar);
addParameter(p, 'PlotType', 'magnitude', @(x) any(validatestring(x, validPlotTypes)));
addParameter(p, 'xScale', 'linear', @(x) any(validatestring(x, validScales)));
addParameter(p, 'yScale', 'linear', @(x) any(validatestring(x, validScales)));
addParameter(p, 'xLim', [], @(x) isempty(x) || (isvector(x) && length(x) == 2));
addParameter(p, 'Title', 'FFT Analysis', @isstring);

parse(p, signal, Fs, varargin{:});

% Get parameters
plotType = p.Results.PlotType;
xScale = p.Results.xScale;
yScale = p.Results.yScale;
xLim = p.Results.xLim;
plotTitle = p.Results.Title;

% Make sure signal is a column vector
signal = signal(:);

% Calculate FFT
L = length(signal);
NFFT = 2^nextpow2(L);  % Next power of 2 for efficient FFT
Y = fft(signal, NFFT);
P2 = abs(Y/L);  % Two-sided spectrum
P1 = P2(1:NFFT/2+1);   % Single-sided spectrum
P1(2:end-1) = 2*P1(2:end-1);  % Account for energy in negative frequencies

% Create frequency vector (x-axis)
f = Fs * (0:(NFFT/2))/NFFT;

% Calculate phase if needed
if strcmp(plotType, 'phase')
    Y_phase = angle(Y(1:NFFT/2+1));
end

% Create figure
figure;

% Plot based on selected type
switch plotType
    case 'magnitude'
        plot(f, P1);
        ylabel('Magnitude');
    case 'power'
        plot(f, P1.^2);
        ylabel('Power');
    case 'db'
        % Add small offset to avoid log(0)
        dbMag = 20*log10(P1 + eps);
        plot(f, dbMag);
        ylabel('Magnitude (dB)');
    case 'phase'
        plot(f, Y_phase);
        ylabel('Phase (radians)');
end

% Set axes properties
xlabel('Frequency (Hz)');
title(plotTitle);
grid on;

% Set x-axis scale
if strcmp(xScale, 'log')
    set(gca, 'XScale', 'log');
end

% Set y-axis scale
if strcmp(yScale, 'log')
    set(gca, 'YScale', 'log');
end

% Set x-axis limits if specified
if ~isempty(xLim)
    xlim(xLim);
else
    xlim([0 12]);  % Default to Nyquist frequency
end

end