

% ir ~ time domain audio
%
%
% fs ~ sampling rate
%
%
% centerFrequency ~ desired centerfrequency,
%
%
% nOctaveBand ~ desired band width 
%
%           1/3  for a 1/3 octave band
%           1/24  for a 1/25 octave band
%
%
%
% fftLength ~ desired fftLength
%


function [magnitude] = nOctaveBandResponse(ir, fs, centerFrequency, nOctaveBand, fftLength)


    if nargin<5
        fftLength = max([2^15, length(ir)]);
    end
    
    if nargin<4
        nOctaveBand = 1/3;
    end
    
    if nargin<3
        centerFrequency = 1000;
    end
       
    % Frequency Domain
    IR = fft(ir, fftLength);
    
    % Normalized Magnitudes
    IR_magnitude = abs(IR) / (fftLength/2);
    
    % Determine the upper frequency of the nOctaveBand
    upperBound = sqrt( (2^(nOctaveBand)) * (centerFrequency^2) );

    % Determine the lower frequency of the nOctaveBand
    lowerBound = (centerFrequency^2) / upperBound;

    % Frequencies available
    findFreqVect = linspace(0, fs/2, fftLength);

    % Find the bin index closest to the lower, upper, center frequency
    [junk, foundLowerBoundIndex] = min(abs(findFreqVect - lowerBound));
    [junk, foundUpperBoundIndex] = min(abs(findFreqVect - upperBound));
    [junk, foundCenterFreqIndex] = min(abs(findFreqVect - centerFrequency));
    
    % Design an asymmetric triangular window
    upWin = linspace(0, 1, length(foundLowerBoundIndex:foundCenterFreqIndex));
    downWin = linspace(1, 0, length(foundCenterFreqIndex:foundUpperBoundIndex));
    win = [upWin(1:end-1), downWin]';
        
    % Retrieve and window the magnitudes producing the nOctaveBand
    % magnitude
    magnitude = sum(win.*IR_magnitude(foundLowerBoundIndex:foundUpperBoundIndex)) ./ sum(win);
    %convert to dB -- ADDED BY STEPHEN
    magnitude = 10*log10(abs(magnitude));
    
end



