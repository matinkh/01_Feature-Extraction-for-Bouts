function spectralCentroid = c4_spectralCentroid(logFileId, bout)
% Weighted mean of frequencies

try
    spectralCentroid = 0;
    addpath('spectral functions\');
    spectralCentroid = SpectralCentroid(bout, size(bout, 1), 1, 1);
    rmpath('spectral functions\');
catch exception
    fprintf(logFileId, 'c4_spectralCentroid: %s\n', exception.message);
end

end

