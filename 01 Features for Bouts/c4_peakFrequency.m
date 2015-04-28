function peakFrequency = c4_peakFrequency(logFileId, inputFileName, bout)

try
    peakFrequency = 0;
    
    Fs = 1; % Sampling rate is 1Hz
    l = size(bout, 1);
    t = linspace(0, l/Fs, l);
    
    % Analyzing frequency components
    %X = 2 * abs(fft(bout)) / l;
    Xcn = abs(fft(bout)/l);
    if(mod(l, 2) == 0)
        X = [Xcn(1); 2 * Xcn(2:l/2); Xcn(l/2+1)];
        freq = (Fs / l) * linspace(0, l/2, l/2 + 1);
    else
        X = [Xcn(1); 2 * Xcn(2:(l+1)/2)];
        freq = (Fs/l) * linspace(0, (l - 1) / 2, (l + 1) / 2);
    end
    
    % Calculate the maximum frequency that can be perceived
    %f_nyquist = Fs / 2;
    
    % Generate the frequency vector that corresponds with bout
    %freq = linspace(0, f_nyquist, size(bout, 1));
    
    % Find strongest magnitude
    % Make sure to exclude DC
    [X_max, maxIdx] = max(X(2:end));
    
    % Look up the frequency that corresponds with the strongest magnitude
    peakFrequency = freq(maxIdx + 1);
catch exception
    fprintf(logFileId, 'c4_peakFrequency (%s): %s\n', inputFileName, exception.message);
end

end

