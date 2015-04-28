function output = c2_kurtosis(logFileId, inputFileName, bout)

try
    output = kurtosis(bout, 0);
catch exception
    fprintf(logFileId, 'c2_kurtosis (%s): %s\n', inputFileName, exception.message);
end

end

