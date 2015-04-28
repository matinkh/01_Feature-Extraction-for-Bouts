function output = c2_skewness(logFileId, inputFileName, bout)

try
    output = skewness(bout, 0);
catch exception
    fprintf(logFileId, 'c2_skewness (%s): %s\n', inputFileName, exception.message);
end

end

