function [energyContribution, entropy] = c4_waveletEnergyContribution_waveletEntropy(logFileId, inputFileName, bout)

try
    energyContribution = 0;
    allEnergyContribution = zeros(10, 1);
    
    % Computing energy of each decomposition
    energyOfDecomposition = zeros(10, 1);
    for i = 1:10
        [C, L] = wavedec(bout, i, 'sym4');
        coeff = appcoef(C, L, 'sym4');
        energyOfDecomposition(i) = norm(coeff, 2);
    end
    
    % Calculating energy contribution for each decomposition
    for i = 1:10
        allEnergyContribution(i) = energyOfDecomposition(i) / (energyOfDecomposition(10) + sum(energyOfDecomposition));
    end
    energyContribution = allEnergyContribution(10);
    
    % Calculating entropy
    temp = 0;
    for i = 1:10
        temp = temp + (allEnergyContribution(i) * log2(allEnergyContribution(i)));
    end
    entropy = -(energyContribution * log2(energyContribution)) - temp;
catch exception
    fprintf(logFileId, 'c4_waveletEnergyContribution (%s): %s\n', inputFileName, exception.message);
end

end

