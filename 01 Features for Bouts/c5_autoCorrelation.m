function [xy_ac, xz_ac, yz_ac] = c5_autoCorrelation(logFileId, inputFileName, xBout, yBout, zBout)
%linear correlation between two autocorrelation functions

try
    xy_ac = 0;
    xz_ac = 0;
    yz_ac = 0;
    
    xy_ac = corr(autocorr(xBout), autocorr(yBout));
    xz_ac = corr(autocorr(xBout), autocorr(zBout));
    yz_ac = corr(autocorr(yBout), autocorr(zBout));
catch exception
    fprintf(logFileId, 'c5_autoCorrelation (%s): %s\n', inputFileName, exception.message);
end

end

