function [spectralMean, spectralStd] = c4_spectralMeanAndStd(logFileId, inputFileName, bout)

try
    magnitudes = abs(fft(bout));
    spectralMean = mean(magnitudes(2:end)); % Removing DC
    spectralStd = std(magnitudes(2:end)); % Removing DC
catch exception
    fprintf(logFileId, 'c4_spectralMeanAndStd (%s): %s\n', inputFileName, exception.message);
end

end

