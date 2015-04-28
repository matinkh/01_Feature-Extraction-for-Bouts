function extractBoutFeaturesForBaselines(baseline1Folder, baseline2Folder, outputFileName)
%Opens two directories for baselines (baseline1 and baseline2), and for
%each csv file in these folders (participant data) and produces a new
%feature set for their bouts.

logFileId = fopen(['log_', date, '.txt'], 'w');
outputFileId = fopen(outputFileName, 'w');
%{
% For full list of features, we can use this.
% However, I am going to emit Lempel-Ziv Complexity for now! (LZC X: just before entropy_rate)
% As well as Spectral Centroid. It is all 0s for every bout!
fprintf(outputFileId, 'pid,length,lle,hr,skewness,kurtosis,xy_xcorr,xz_xcorr,yz_xcorr,lzc,entropy_rate,signal_avg,signal_std,zero_cross_rate,signal_max,signal_min,xy_autocorr,xz_autocorr,yz_autocorr,peak_frequency,wavelet_energy,wavelet_entropy,spectral_flux,spectral_centroid,xy_specCorr,xz_specCorr,yz_specCorr,spectral_mean\n');
%}
fprintf(outputFileId, 'pid,length,lle,hr,skewness,kurtosis,xy_xcorr,xz_xcorr,yz_xcorr,entropy_rate,signal_avg,signal_std,zero_cross_rate,signal_max,signal_min,xy_autocorr,xz_autocorr,yz_autocorr,peak_frequency,wavelet_energy,wavelet_entropy,spectral_flux,xy_specCorr,xz_specCorr,yz_specCorr,spectral_mean\n');


ls1 = dir([baseline1Folder, '\*.csv']);
ls2 = dir([baseline2Folder, '\*.csv']);
totalSteps = size(ls1, 1) + size(ls2, 1);
c = clock;
fprintf('(%d:%d:%d) Extracting bout features has started...\nTotal number of files to be processed is: %d\n', c(4), c(5), floor(c(6)), totalSteps);
% baseline 1
fprintf(logFileId, '=========== Baseline 1 ===========\n');
try
    for i = 1:size(ls1, 1)
        fileName = [baseline1Folder, '\', ls1(i).name];
        c = clock;
        fprintf(logFileId, '(%d:%d:%d) %s:\n', c(4), c(5), floor(c(6)), ls1(i).name);
        fprintf('(%d:%d:%d) %s... ', c(4), c(5), floor(c(6)), fileName);
        extractBoutsOfAPerson(logFileId, outputFileId, fileName);
        fprintf('Done\n');
        fprintf(logFileId, 'Done\n\n');
    end
    
catch exception
    fprintf('Exception in baseline1: %s\n', exception.message);
end

% baseline 2
fprintf(logFileId, '\n=========== Baseline 2 ===========\n');
try
    for i = 1:size(ls2, 1)
        fileName = [baseline2Folder, '\', ls2(i).name];
        c = clock;
        fprintf(logFileId, '(%d:%d:%d) %s:\n', c(4), c(5), floor(c(6)), ls2(i).name);
        extractBoutsOfAPerson(logFileId, outputFileId, fileName);
        c = clock;
        fprintf(logFileId, '(%d:%d:%d) Done\n\n', c(4), c(5), floor(c(6)));
    end
    
catch exception
    fprintf('Exception in baseline2: %s\n', exception.message);
end
fclose(outputFileId);
fclose(logFileId);

end

