function convolvedSig = guitarConvolverBlind
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

amplifiers = cell(1,3);

amplifiers{1,1} = RazerCenter;
amplifiers{1,2} = DeluxCenter;
amplifiers{1,3} = VoxCenter;


convolvedSig = cell(7,7);

% select a random amplifier to convolve the guitar with
amp = amplifiers{1,randi(3)};

% select a random guitar sample to convolve
input = guitarSamps{1,randi(9)};

for i = 1:7
    for j = 1:7
        convolvedSig{i,j} = fconv(input,amp{i,j});
    end
end

end