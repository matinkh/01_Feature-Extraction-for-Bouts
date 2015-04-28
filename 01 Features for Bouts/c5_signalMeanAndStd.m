function [signalMean, signalStd] = c5_signalMeanAndStd(logFileId, inputFileName, bout)

try
    signalMean = 0;
    signalStd = 0;
    signalMean = mean(bout);
    signalStd = std(bout);
catch exception
    fprintf(logFileId, 'c5_signalMeanAndStd (%s): %s\n', inputFileName, exception.message);
end


end

