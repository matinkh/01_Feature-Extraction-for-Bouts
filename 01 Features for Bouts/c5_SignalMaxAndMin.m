function [signalMax, signalMin] = c5_SignalMaxAndMin(logFileId, inputFileName, bout)

try
    signalMax = 0;
    signalMin = 0;
    signalMax = max(bout);
    signalMin = min(bout(bout > 0));
catch exception
    fprintf(logFileId, 'c5_maxAndMin (%s): %s\n', inputFileName, exception.message);
end

end

