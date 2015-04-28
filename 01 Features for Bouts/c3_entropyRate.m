function entropyRate = c3_entropyRate(logFileId, inputFileName, bout)

try
    entropyRate = entropy(bout);
catch exception
    fprintf(logFileId, 'c3_entropyRate (%s): %s\n', inputFileName, exception.message);
end

end

