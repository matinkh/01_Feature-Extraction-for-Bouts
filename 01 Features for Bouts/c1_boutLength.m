function boutLength = c1_boutLength(logFileId, inputFileName, start_inMin, end_inMin)

try
    boutLength = end_inMin - start_inMin;
catch exception
    fprintf(logFileId, 'c1_boutLength (%s): %s\n', inputFileName, exception.message);
end


end

