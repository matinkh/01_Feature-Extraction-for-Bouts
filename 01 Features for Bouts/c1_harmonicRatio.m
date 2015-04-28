function harmonicRatio = c1_harmonicRatio(logFileId, inputFileName, bout)

try
    Fs = 1; % Frequency sampling is 1 Hz.
    harmonicRatio = 1;
    NFFT = 2^nextpow2(size(bout, 1));
    X = fft(bout, NFFT) / size(bout, 1); % Signal in frequency space
    f = Fs / 2 * linspace(0, 1, NFFT/2 + 1);
    magnitude = abs(X(1:NFFT/2+1));
    
    % We only care about the top-20 frequencies (magnitude)
    [magSorted, magSortedIdx] = sort(magnitude, 'descend');
    
    % We have to remove DC, thus we start from 2 (instead of 1)
    top20_magnitude = magSorted(2:21);
    top20_freq = f(magSortedIdx(2:21));
    
    % Then again we sort it according to frequencies
    [~, freqIdx] = sort(top20_freq, 'ascend');
    coefficients = top20_magnitude(freqIdx);
    
    % And now we can compute Harmonic Ratio
    harmonicRatio = sum(coefficients(2:2:20)) / sum(coefficients(1:2:19));
     
catch exception
    fprintf(logFileId, 'c1_harmonicRatio (%s): %s\n',inputFileName, exception.message);
end

end

