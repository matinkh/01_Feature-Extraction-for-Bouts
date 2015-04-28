function zcr = c5_zeroCrossingRate(logFileId, inputFileName, bout)

try
    zcr = 0;
    normalizedSignal = zscore(bout);
    zcr = mean(abs(diff(sign(normalizedSignal))));
catch exception
    fprintf(logFileId, 'c5_zeroCrossingRate (%s): %s\n', inputFileName, exception.message);
end

end

