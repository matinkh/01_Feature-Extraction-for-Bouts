function [xy_specXCorr, xz_specXCorr, yz_specXCorr] = c4_spectralCrossCorrelation(logFileId, inputFileName, xAxis, yAxis, zAxis)


try
    xy_specXCorr = 0;
    xz_specXCorr = 0;
    yz_specXCorr = 0;
    
    freqXAxis = fft(xAxis);
    freqYAxis = fft(yAxis);
    freqZAxis = fft(zAxis);
    
    % (2:end) means we are not including DC.
    xy_specXCorr = corr(freqXAxis(2:end), freqYAxis(2:end)); 
    xz_specXCorr = corr(freqXAxis(2:end), freqZAxis(2:end));
    yz_specXCorr = corr(freqYAxis(2:end), freqZAxis(2:end));
catch exception
    fprintf(logFileId, 'c4_spectralCrossCorrelation (%s): %s\n', inputFileName, exception.message);
end

end

