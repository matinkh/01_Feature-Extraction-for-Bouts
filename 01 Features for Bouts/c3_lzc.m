function lzc = c3_lzc(logFileId, bout)

try
    
    % Warning: the packages used for LZC do not seem very stable and
    % useful to me. If you are going to use this function for feature
    % extraction, please make sure to confirm the results manually.
    fprintf(logFileId, 'c3_lzc: LZC is being calculated. However, I am not quite sure the packages being used to be accurate.\n');
    
    lzc = 1;
    % Setting up boundaries
    minVal = min(bout);
    maxVal = max(bout);
    step = (maxVal - minVal) / 26;
    boundaries = zeros(27, 1);
    boundaries(1) = minVal - 0.01;
    for i = 2:27
        boundaries(i) = (i - 1) * step;
    end
    
    % Convert signal to a string
    str = char(zeros(size(bout, 1),1));
    for i = 1:size(bout, 1)
        str(i) = findCharacter(bout(i), boundaries);
    end
    
    % Now we can apply LZC
    addpath('LZC\');
    alphabet = 'a';
    for i = 1:25
        alphabet = [alphabet, char('a' + i)];
    end
    [~, code_bin, ~] = lempel_ziv(alphabet, str);
    
    % Here is the part I am most uncomfortable with! I need to have a
    % vector, so I am converting a matrix (vector of binary strings) into a
    % vector by reshaping! This might cause the procedure inaccurate!
    code_bin = reshape(code_bin, size(code_bin, 1) * size(code_bin, 2), 1);
    code_bin = (code_bin == '1');
    [C, ~, ~] = calc_lz_complexity(code_bin, 'exhaustive', 0);
    lzc = C;
    rmpath('LZC\');
catch exception
    fprintf(logFileId, 'c3_lzc: %s\n', exception.message);
end

end

function c = findCharacter(value, boundaries)
biggerIndices = find(boundaries >= value);
upperBound = min(biggerIndices);
% Since [1 2] => a; therefore, if upperbound is 2, it should return 'a'.
c = char('a' + upperBound - 2);
end