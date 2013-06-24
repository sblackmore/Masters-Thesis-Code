function [razerResult,deluxResult,voxResult] = deconvolver(convolvedGuitar)
% this function will take the input, "blindly convolved" guitar signal and
% deconvolve that signal from all of the amplifiers.  It will then out the
% deconvolved signal as a vector for each amplifier.  These deconvolved
% signals will be used to "learn" what the clean guitar sounds like.  We
% can then use that to determine the amplifier through which the guitar was
% convolved

% TEST LOAD -- GENERALLY THIS PARAMETER WOULD BE PASSED TO US
% load('testConvCells.mat');


    % load the IRs to be deconvolved
    load('RazerCenter.mat');
    load('DeluxCenter.mat');
    load('VoxCenter.mat');

    % create output matrices to store the results
    razerResult = cell(7,7);
    deluxResult = cell(7,7);
    voxResult = cell(7,7);
    
    % loop through the cells of the convolved guitar and deconvle the same
    % amplifier cells from it.  This happens for all three amplifiers
%     for i = 1:7
%         for k = 1:7
%             razerResult{i,k} = fdeconv(testConvCells{i,k},RazerCenter{i,k});   
%             deluxResult{i,k} = fdeconv(testConvCells{i,k},DeluxCenter{i,k});
%             voxResult{i,k} = fdeconv(testConvCells{i,k},VoxCenter{i,k});
%         end
%     end

    for i = 1:7
        for k = 1:7
            razerResult{i,k} = fdeconv(convolvedGuitar{i,k},RazerCenter{i,k});   
            deluxResult{i,k} = fdeconv(convolvedGuitar{i,k},DeluxCenter{i,k});
            voxResult{i,k} = fdeconv(convolvedGuitar{i,k},VoxCenter{i,k});
        end
    end

end