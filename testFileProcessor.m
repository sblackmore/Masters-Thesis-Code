function [convResult,twelfthTestDecons,sixthTestDecons,thirdTestDecons,input] = testFileProcessor


%load('guitarSamps');
load('testSignals.mat');
load('RazerCenter.mat');
load('DeluxCenter.mat');
load('VoxCenter.mat');

% create an array to grab a random amp from
allAmps = cell(3,1);

allAmps{1,1} = RazerCenter;
allAmps{2,1} = DeluxCenter;
allAmps{3,1} = VoxCenter;

% return the input so that we can track which sample was used and compare
% later
input = testSignals{1,randi(9)};
%save('testInput1','input');

% select a random amp to convolve the signal with
amp = allAmps{randi(3),1};

% cell array to store the result of the convolution
convResult = cell(7,7);

% perform the convolutions
    for i = 1:7
        for j = 1:7
            convResult{i,j} = fconv(input,amp{i,j});
        end
    end
    
% run the result of hte convolutions through the decons to deconvolve from
% each amp
[razeDecon,deluxDecon,voxDecon] = deconvolver(convResult);

% store all three deconvolution results in a single output
deconTestFileResult = cell(3,1);

deconTestFileResult{1,1} = razeDecon;
deconTestFileResult{2,1} = deluxDecon;
deconTestFileResult{3,1} = voxDecon;

save('deconTestFileResult','deconTestFileResult');
% run the results through the deconvolutionAnalysis.m toi filter the
% results of the deconvoutions of the test signal at 1/12 octave bands
twelfthTestDecons = deconvolutionAnalysis('test');
sixthTestDecons = sixthOctDecon('test');
thirdTestDecons = thirdOctDecon('test');



end