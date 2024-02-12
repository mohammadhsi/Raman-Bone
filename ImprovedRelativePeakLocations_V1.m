function [peakIndices, peakHeights] = ImprovedRelativePeakLocations_V1(xaxis, spectrum, peaknum, windowSize, minPeakProminence)
    % ImprovedRelativePeakLocations: Function to find local maxima based on relative heights
    % xaxis: The x-axis values of the spectrum
    % spectrum: The spectral data
    % peaknum: The number of peaks to find
    % windowSize: The size of the window to compare peak heights
    % minPeakProminence: The minimum prominence of peaks

    % Validate inputs
    if nargin < 5
        error('Insufficient input arguments.');
    end
    
    % Pass empty xaxis to simply use pixel number.  peakstripwindow and
    % edgedist are always in PIXELS independent of xaxis.
    if isempty(xaxis) == 1
    xaxis = (1:size(spectrum,1)).';
    elseif size(xaxis,1) ~= size(spectrum,1)
    warning('xaxis is not the same size as the length of spec.  Setting xaxis equal to pixel number...')
    xaxis = 1:size(spec,1);
    end

    % Smooth the spectrum to reduce noise
    %smoothedSpectrum = smoothdata(spectrum, 'sgolay');

    % Find peaks with prominence criteria
    [peaks, locs, widths, proms] = findpeaks(spectrum, xaxis, 'MinPeakProminence', minPeakProminence, 'Annotate', 'extents');

    % Filter out peaks based on window size and relative height
    validPeaks = arrayfun(@(loc, width) isPeakValid(spectrum, xaxis, loc, width, windowSize), locs, widths);
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
    %isValid = peakHeight >= 0; % Adjust this condition based on your criteria
end
