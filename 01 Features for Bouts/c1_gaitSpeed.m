function gaitSpeed = c1_gaitSpeed(logFileId)

try
    gaitSpeed = 1;
    fprintf(logFileId, 'c1_gaitSpeed: this function is not implemented. Return 1.\n');
catch exception
    fprintf(logFileId, 'c1_gaitSpeed: %s\n', exception.message);
end

end

