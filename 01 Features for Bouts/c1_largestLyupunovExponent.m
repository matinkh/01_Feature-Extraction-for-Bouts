function lle = c1_largestLyupunovExponent(logFileId, inputFileName, bout)

try
    addpath('lyapunov\');
    exponents = lyapunov(bout);
    lle = max(exponents);
    rmpath('lyapunov\');
catch exception
    fprintf(logFileId, 'c1_largestLyupunovExponent (%s): %s\n',inputFileName, exception.message);
    lle = 0;
end

end

