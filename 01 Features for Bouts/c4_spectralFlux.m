function spectralFlux = c4_spectralFlux(logFileId, inputFileName, bout)

try
    spectralFlux = 0;
    addpath('spectral functions\');
    spectralFlux = SpectralFlux(bout, size(bout, 1), 1, 1);
    rmpath('spectral functions\');
catch exception
    fprintf(logFileId, 'c4_spectralFlux (%s): %s\n', inputFileName, exception.message);
end

end

