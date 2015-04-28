function extractBoutsOfAPerson(logFileId, outputFileId, inputFileName)
%Reads a participant's data file, finds bouts and for each bout it writes
%the extracted features in the output file.

try
    ds = dataset('File', inputFileName, 'Delimiter', ',');
    
    % Required features are obtained from the raw data file
    pid = ds.pid(1);
    
    xAxis = ds.axis1;
    yAxis = ds.axis2;
    zAxis = ds.axis3;
    VM = sqrt(xAxis .* xAxis + yAxis .* yAxis + zAxis .* zAxis);
    clear ds;
    
    % For each bout in participant's signal data
    wearTimes = findWearTimes(VM, 1, 0);
    addpath('01 Features for Bouts\');
    for boutNo = 1:size(wearTimes, 1)
        fprintf(outputFileId, '%d,', pid);
        
        startTime = (wearTimes(boutNo, 1) * 60) + 1;
        endTime = wearTimes(boutNo, 2) * 60;
        boutVM = VM(startTime:endTime);
        boutX = xAxis(startTime:endTime);
        boutY = yAxis(startTime:endTime);
        boutZ = zAxis(startTime:endTime);
        
        % Calling functions to extract the corresponding feature
        length = c1_boutLength(logFileId, inputFileName, wearTimes(boutNo, 1), wearTimes(boutNo, 2));
        printItToOutputCSVFile(outputFileId, length, 0, 0);
        
        largestLyapunovExponent = c1_largestLyupunovExponent(logFileId, inputFileName, boutVM);
        printItToOutputCSVFile(outputFileId, largestLyapunovExponent, 0, 0);
        
        harmonicRatio = c1_harmonicRatio(logFileId, inputFileName, boutVM);
        printItToOutputCSVFile(outputFileId, harmonicRatio, 0, 0);
        
        boutSkewness = c2_skewness(logFileId, inputFileName, boutVM);
        printItToOutputCSVFile(outputFileId, boutSkewness, 0, 0);
        
        boutKurtosis = c2_kurtosis(logFileId, inputFileName, boutVM);
        printItToOutputCSVFile(outputFileId, boutKurtosis, 0, 0);
        
        [xy_xcorr, xz_xcorr, yz_xcorr] = c2_crossCorrelations(logFileId, inputFileName, boutX, boutY, boutZ);
        printItToOutputCSVFile(outputFileId, xy_xcorr, 0, 0);
        printItToOutputCSVFile(outputFileId, xz_xcorr, 0, 0);
        printItToOutputCSVFile(outputFileId, yz_xcorr, 0, 0);
        
        %{
        I am not sure about its correctness. So, for now I am going to
        comment this part, and do not use LZC.
        
        lzc = c3_lzc(logFileId, boutVM);
        printItToOutputCSVFile(outputFileId, lzc, 0, 0);
        %}
        entropyRate = c3_entropyRate(logFileId, inputFileName, boutVM);
        printItToOutputCSVFile(outputFileId, entropyRate, 0, 0);
        
        [boutAvg, boutStd] = c5_signalMeanAndStd(logFileId, inputFileName, boutVM);
        printItToOutputCSVFile(outputFileId, boutAvg, 0, 0);
        printItToOutputCSVFile(outputFileId, boutStd, 0, 0);
        
        zeroCrossRate = c5_zeroCrossingRate(logFileId, inputFileName, boutVM);
        printItToOutputCSVFile(outputFileId, zeroCrossRate, 0, 0);
        
        [boutMax, boutMin] = c5_SignalMaxAndMin(logFileId, inputFileName, boutVM);
        printItToOutputCSVFile(outputFileId, boutMax, 1, 0);
        printItToOutputCSVFile(outputFileId, boutMin, 1, 0);
        
        [xy_autocorr, xz_autocorr, yz_autocorr] = c5_autoCorrelation(logFileId, inputFileName, boutX, boutY, boutZ);
        printItToOutputCSVFile(outputFileId, xy_autocorr, 0, 0);
        printItToOutputCSVFile(outputFileId, xz_autocorr, 0, 0);
        printItToOutputCSVFile(outputFileId, yz_autocorr, 0, 0);
        
        peakFrequncy = c4_peakFrequency(logFileId, inputFileName, boutVM);
        printItToOutputCSVFile(outputFileId, peakFrequncy, 0, 0);
        
        [energyContribution, entropy] = c4_waveletEnergyContribution_waveletEntropy(logFileId, inputFileName, boutVM);
        printItToOutputCSVFile(outputFileId, energyContribution, 0, 0);
        printItToOutputCSVFile(outputFileId, entropy, 0, 0);
        
        spectralFlux = c4_spectralFlux(logFileId, inputFileName, boutVM);
        printItToOutputCSVFile(outputFileId, spectralFlux, 0, 0);
        
        %{
        This part is removed, and should be used if debugged! For now, it
        is only giving me 0 for every bout!
        
        spectralCentroid = c4_spectralCentroid(logFileId, boutVM);
        printItToOutputCSVFile(outputFileId, spectralCentroid, 0, 0);
        %}
        [spectralAvg, spectralStd] = c4_spectralMeanAndStd(logFileId, inputFileName, boutVM);
        printItToOutputCSVFile(outputFileId, spectralAvg, 0, 0);
        printItToOutputCSVFile(outputFileId, spectralStd, 0, 0);
        
        [xy_specXCorr, xz_specXCorr, yz_specXCorr] = c4_spectralCrossCorrelation(logFileId, inputFileName, boutX, boutY, boutZ);
        printItToOutputCSVFile(outputFileId, xy_specXCorr, 0, 0);
        printItToOutputCSVFile(outputFileId, xz_specXCorr, 0, 0);
        printItToOutputCSVFile(outputFileId, yz_specXCorr, 0, 1);
        
    end
    
    rmpath('01 Features for Bouts\');
catch exception
    fprintf(logFileId, 'extractBoutsOfAPerson (%s): %s\n', inputFileName, exception.message);
end

end

function printItToOutputCSVFile(outputFileId, numericValue, isInteger, isLast)
if(isnumeric(numericValue))
    if(isInteger)
        fprintf(outputFileId, '%d', numericValue);
    else
        fprintf(outputFileId, '%f', numericValue);
    end
else
    fprintf(outputFileId, 'NaN');
end
if(isLast)
    fprintf(outputFileId, '\n');
else
    fprintf(outputFileId, ',');
end
end