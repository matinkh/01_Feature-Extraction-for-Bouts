function extractBoutFeaturesForBaselines_parallel4(baseline1Folder, baseline2Folder, output1, output2)
%Just like extractBoutFeaturesForBaselines, but instead it leverages 4
%cpus to make calculations faster, and produces 4 different outputs which
%needs to be merged in the end.
% First two CPUs will work on baseline 1, while the other two are working
% on baseline 2.

% Reading files existing in selected folders
ls1 = dir([baseline1Folder, '\*.csv']);
ls2 = dir([baseline2Folder, '\*.csv']);
totalSteps = size(ls1, 1) + size(ls2, 1);
c = clock;
fprintf('(%d:%d:%d) Extracting bout features has started...\nTotal number of files to be processed is: %d\n', c(4), c(5), floor(c(6)), totalSteps);

baseline1_splitPoint = floor(size(ls1, 1) / 2);
baseline2_splitPoint = floor(size(ls2, 1) / 2);

% Headers of the output file
%{
This was the original headers.
However, I would like to remove
- Spectral Centroid: since it seems problematic, and always 0 for every bout!
- LZC: takes a lot of time! (And I'm not sure about its correctness!)
headers = sprintf('pid,length,lle,hr,skewness,kurtosis,xy_xcorr,xz_xcorr,yz_xcorr,lzc,entropy_rate,signal_avg,signal_std,zero_cross_rate,signal_max,signal_min,xy_autocorr,xz_autocorr,yz_autocorr,peak_frequency,wavelet_energy,wavelet_entropy,spectral_flux,spectral_centroid,xy_specCorr,xz_specCorr,yz_specCorr,spectral_mean\n');
%}
headers = sprintf('pid,length,lle,hr,skewness,kurtosis,xy_xcorr,xz_xcorr,yz_xcorr,entropy_rate,signal_avg,signal_std,zero_cross_rate,signal_max,signal_min,xy_autocorr,xz_autocorr,yz_autocorr,peak_frequency,wavelet_energy,wavelet_entropy,spectral_flux,xy_specCorr,xz_specCorr,yz_specCorr,spectral_mean');


matlabpool 4
spmd
    if(labindex == 1) % First half of Baseline 1
        log1FileId = fopen(['log1_1stHalf_', date, '.txt'], 'w');
        output1_fileId = fopen([output1, '_1stHalf.csv'], 'w');
        fprintf(output1_fileId, '%s\n', headers);
        for i = 1:baseline1_splitPoint
            fileName = [baseline1Folder, '\', ls1(i).name];
            c = clock;
            fprintf(log1FileId, '(%d:%d:%d) %s:\n', c(4), c(5), floor(c(6)), ls1(i).name);
            fprintf('%d of %d\t(%d:%d:%d) %s... ', i, baseline1_splitPoint, c(4), c(5), floor(c(6)), fileName);
            extractBoutsOfAPerson(log1FileId, output1_fileId, fileName);
            fprintf('Done...\n');
            c = clock;
            fprintf(log1FileId, '(%d:%d:%d) Done...\n\n', c(4), c(5), floor(c(6)));
        end
        fclose(log1FileId);
        fclose(output1_fileId);
    else if(labindex == 2) % Second half of Baseline 1
            log2FileId = fopen(['log1_2ndHalf_', date, '.txt'], 'w');
            output2_fileId = fopen([output1, '_2ndHalf.csv'], 'w');
            fprintf(output2_fileId, '%s\n', headers);
            for i = (baseline1_splitPoint + 1):size(ls1, 1)
                fileName = [baseline1Folder, '\', ls1(i).name];
                c = clock;
                fprintf(log2FileId, '(%d:%d:%d) %s:\n', c(4), c(5), floor(c(6)), ls1(i).name);
                fprintf('%d of %d\t(%d:%d:%d) %s... ', (i - baseline1_splitPoint), (size(ls1, 1) - baseline1_splitPoint - 1), c(4), c(5), floor(c(6)), fileName);
                extractBoutsOfAPerson(log2FileId, output2_fileId, fileName);
                fprintf('Done...\n');
                c = clock;
                fprintf(log2FileId, '(%d:%d:%d) Done...\n\n', c(4), c(5), floor(c(6)));
            end
            fclose(log2FileId);
            fclose(output2_fileId);
        else if(labindex == 3) % First half of Baseline 2
                log3FileId = fopen(['log2_1stHalf_', date, '.txt'], 'w');
                output3_fileId = fopen([output2, '_1stHalf.csv'], 'w');
                fprintf(output3_fileId, '%s\n', headers);
                for i = 1:baseline2_splitPoint
                    fileName = [baseline2Folder, '\', ls2(i).name];
                    c = clock;
                    fprintf(log3FileId, '(%d:%d:%d) %s:\n', c(4), c(5), floor(c(6)), ls2(i).name);
                    fprintf('%d of %d\t(%d:%d:%d) %s... ', i, baseline2_splitPoint, c(4), c(5), floor(c(6)), fileName);
                    extractBoutsOfAPerson(log3FileId, output3_fileId, fileName);
                    fprintf('Done...\n');
                    c = clock;
                    fprintf(log3FileId, '(%d:%d:%d) Done...\n\n', c(4), c(5), floor(c(6)));
                end
                fclose(log3FileId);
                fclose(output3_fileId);
            else if(labindex == 4) % Second half of Baseline 2
                    log4FileId = fopen(['log2_2ndHalf_', date, '.txt'], 'w');
                    output4_fileId = fopen([output2, '_2ndHalf.csv'], 'w');
                    fprintf(output4_fileId, '%s\n', headers);
                    for i = (baseline2_splitPoint + 1):size(ls2, 1)
                        fileName = [baseline2Folder, '\', ls2(i).name];
                        c = clock;
                        fprintf(log4FileId, '(%d:%d:%d) %s:\n', c(4), c(5), floor(c(6)), ls2(i).name);
                        fprintf('%d of %d\t(%d:%d:%d) %s... ', (i - baseline2_splitPoint), (size(ls2, 1) - baseline2_splitPoint - 1), c(4), c(5), floor(c(6)), fileName);
                        extractBoutsOfAPerson(log4FileId, output4_fileId, fileName);
                        fprintf('Done...\n');
                        c = clock;
                        fprintf(log4FileId, '(%d:%d:%d) Done...\n\n', c(4), c(5), floor(c(6)));
                    end
                    fclose(output4_fileId);
                    fclose(log4FileId);
                end
            end
        end
    end
end
matlabpool close


end

