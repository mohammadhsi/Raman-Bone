function [peakIndices, peakHeights] = ImprovedRelativePeakLocations(xaxis, spectrum, peaknum, windowSize, minPeakProminence, minPeakHeight, minPeakDistance, threshold)

    % ImprovedRelativePeakLocations: Function to find local maxima based on relative heights
    % xaxis: The x-axis values of the spectrum
    % spectrum: The spectral data
    % peaknum: The number of peaks to find
    % windowSize: The size of the window to compare peak heights
    % minPeakProminence: The minimum prominence of peaks

    % Validate inputs
    if nargin < 8
        error('Insufficient input arguments.');
    end
    
    % Handle empty xaxis
    if isempty(xaxis)
        xaxis = (1:length(spectrum)).';  % Use row index if xaxis is not provided
    elseif length(xaxis) ~= length(spectrum)
        warning('xaxis is not the same size as the spectrum. Setting xaxis equal to point indices...');
        xaxis = (1:length(spectrum)).';
    end

    % Smooth the spectrum to reduce noise
    smoothedSpectrum = smoothdata(spectrum, 'sgolay');

    % Find peaks with specified criteria
    [peaks, locs, widths, proms] = findpeaks(smoothedSpectrum, xaxis, ...
                                             'MinPeakProminence', minPeakProminence, ...
                                             'MinPeakHeight', minPeakHeight, ...
                                             'MinPeakDistance', minPeakDistance, ...
                                             'Threshold', threshold);
                                                                        

    % Filter out peaks based on window size and other criteria (if needed)
    validPeaks = arrayfun(@(loc, width) isPeakValid(smoothedSpectrum, xaxis, loc, width, windowSize), locs, widths);
    filteredPeaks = peaks(validPeaks);
    filteredLocs = locs(validPeaks);

    % Limit the number of peaks to the specified number
    if length(filteredPeaks) > peaknum
        [~, topPeakIndices] = maxk(filteredPeaks, peaknum);
        peakIndices = filteredLocs(topPeakIndices);
        peakHeights = filteredPeaks(topPeakIndices);
    else
        peakIndices = filteredLocs;
        peakHeights = filteredPeaks;
    end

    % Sort peaks by their position
    [peakIndices, sortedIndices] = sort(peakIndices);
    peakHeights = peakHeights(sortedIndices);
end

function isValid = isPeakValid(spectrum, xaxis, peakLoc, peakWidth, windowSize)
    % Check if the peak is valid based on its relative height within a window
    peakIndex = find(xaxis == peakLoc, 1);
    windowStart = max(1, peakIndex - floor(windowSize / 2));
    windowEnd = min(length(spectrum), peakIndex + floor(windowSize / 2));

    localMin = min(spectrum(windowStart:windowEnd));
    peakHeight = spectrum(peakIndex) - localMin;
    
    isValid = peakHeight >= peakWidth; % Adjust this condition based on your criteria
end
