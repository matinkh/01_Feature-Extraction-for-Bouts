function [xy_corr, xz_corr, yz_corr] = c2_crossCorrelations(logFileId, inputFileName, xAxis, yAxis, zAxis)

try
    xy_corr = 0;
    xz_corr = 0;
    yz_corr = 0;
    
    xy_corr = corr(xAxis, yAxis);
    xz_corr = corr(xAxis, zAxis);
    yz_corr = corr(yAxis, zAxis);
catch exception
    fprintf(logFileId, 'c2_crossCorrelations (%s): %s\n', inputFileName, exception.message);
end

end

