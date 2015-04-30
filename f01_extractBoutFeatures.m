function f01_extractBoutFeatures(rawDataFolder, outputFileName)
%Reads each participant's raw data file (existing in rawDataFolder), and
%for each bout found in that file, some features are extracted and written
%in the output (outputFileName);.
%Here is the list of attributes for each bout:
%   pid: participant's ID
%   length: bout length in minute
%   lle: Largest Lyapunov Exponent
%   hr: Harmonic Ratio
%   skewness: Skewness of the signal
%   kurtosis: Kurtosis coefficient of the signal
%   xy_xcorr: Cross correlation between axis1 and axis2
%   xz_xcorr: Cross correlation between axis1 and axis3
%   yz_xcorr: Cross correlation between axis2 and axis3
%   entropy_rate: Regularity of signal
%   signal_avg: Average amplitude of signal
%   signal_std: Standard deviation of signal
%   zero_cross_rate: Zero crossing rate (or mean crossing rate)
%   signal_max: Max signal amplitude
%   signal_min: Min signal amplitude (and > 0)
%   xy_autocorr: Autocorrelation between axis1 and axis2
%   xz_autocorr: Autocorrelation between axis1 and axis3
%   yz_autocorr: Autocorrelation between axis2 and axis3
%   peak_frequency: Frequency where max amplitude happens
%   wavelet_energy: Energy contribution
%   wavelet_entropy: Signal disorder
%   spectral_flux: How fast power spectrum changes
%   xy_specCorr: Cross correlation between axis1 and axis2 in frequency
%   domain
%   xz_specCorr: Cross correlation between axis1 and axis3 in frequency domain
%   yz_specCorr: Cross correlation between axis2 and axis3 in frequency domain
%   spectral_mean: Average of signal in frequency domain
%   spectral_std: Standard deviation of signal in frequency domain

logFileId = fopen(['log_', date, '.txt'], 'w');
outputFileId = fopen(outputFileName, 'w');

fprintf(outputFileId, 'pid,length,lle,hr,skewness,kurtosis,xy_xcorr,xz_xcorr,yz_xcorr,entropy_rate,signal_avg,signal_std,zero_cross_rate,signal_max,signal_min,xy_autocorr,xz_autocorr,yz_autocorr,peak_frequency,wavelet_energy,wavelet_entropy,spectral_flux,xy_specCorr,xz_specCorr,yz_specCorr,spectral_mean,spectral_std\n');
ls = dir([rawDataFolder, '\*.csv']);
totalSteps = size(ls, 1);
c = clock;
fprintf('(%d:%d:%d) Extracting bout features has started...\nTotal number of files to be processed is: %d\n', c(4), c(5), floor(c(6)), totalSteps);
fprintf(logFileId, 'Bout Feature Extraction started for (%s) %d/%d/%d -- %d:%d:%d\n', rawDataFolder, c(2), c(3), c(1), c(4), c(5), floor(c(6)));
try
    for i = 1:size(ls, 1)
        fileName = [rawDataFolder, '\', ls(i).name];
        c = clock;
        fprintf('(%d:%d:%d) %s... ', c(4), c(5), floor(c(6)), fileName);
        extractBoutsOfAPerson(logFileId, outputFileId, fileName);
        fprintf('Done\n');
    end
    
catch exception
    fprintf('Not Done: %s\nCheck the log file.\n', exception.message);
end

fclose(outputFileId);
fclose(logFileId);
end

