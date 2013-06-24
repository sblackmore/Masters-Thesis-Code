function [convolvedRazer,convolvedDelux,convolvedVox] = guitarConvolver
% this function will read in a guitar file and process it through the
% various guitar amps using convolution



% [input, fs] = wavread('test1');
%[input, fs] = wavread('guitar_6e_open_48k');

% [~, numChannels] = size(input);
%         if (numChannels == 2)
%             input = mean(input, 2);  
%         end
 

load('RazerCenter.mat');
load('DeluxCenter.mat');
load('VoxCenter.mat');
load('guitarSamps.mat');

% preallocate the cell arrays for each amp
convolvedRazer = cell(7,7);
convolvedDelux = cell(7,7);
convolvedVox = cell(7,7);




% select a random guitar sample to convolve
input = guitarSamps{1,randi(9)};

% do a convolution for each amp
    for i = 1:7
        for j = 1:7
            convolvedRazer{i,j} = fconv(input,RazerCenter{i,j});
            convolvedDelux{i,j} = fconv(input,DeluxCenter{i,j});
            convolvedVox{i,j} = fconv(input,VoxCenter{i,j});
        end
    end
end