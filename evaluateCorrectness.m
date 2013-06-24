function [evaluation3,evaluation6,evaluation12] = evaluateCorrectness
% load('testFileProbabilities12th');
% load('testFileProbabilities6th');
% load('testFileProbabilities3rd');
load('ampProbabilities12th');
load('ampProbabilities6th');
load('ampProbabilities3rd');

thirds = zeros(3,20);
sixths = zeros(3,20);
twelfths = zeros(3,20);

for i = 1:20
    for j = 1:3
        thirds(j,i) = ampProbabilities3rd{j,i};
        sixths(j,i) = ampProbabilities6th{j,i};
        twelfths(j,i) = ampProbabilities12th{j,i};
    end
end    


% find the max values in each column corresponding to each test file
[max12Val,max12Idx] = max(twelfths);
[max6Val,max6Idx] = max(sixths);
[max3Val,max3Idx] = max(thirds);


% loop through the max indexes, compare to the correct amp, and store as 1
% (correct) or 0 (incorrect)
evaluation3 = zeros(1,20);

for i = 1:20
    if max3Idx(1,i) == 1 && strcmp(ampProbabilities3rd{4,i},'Raezer''s Edge')
        evaluation3(1,i) = 1;
    elseif max3Idx(1,i) == 2 && strcmp(ampProbabilities3rd{4,i},'Fender Deluxe')   
        evaluation3(1,i) = 1;
    elseif max3Idx(1,i) == 3 && strcmp(ampProbabilities3rd{4,i},'Vox Valvetronix')
        evaluation3(1,i) = 1;
    end

end

evaluation6 = zeros(1,20);

for i = 1:20
    if max6Idx(1,i) == 1 && strcmp(ampProbabilities6th{4,i},'Raezer''s Edge')
        evaluation6(1,i) = 1;
    elseif max6Idx(1,i) == 2 && strcmp(ampProbabilities6th{4,i},'Fender Deluxe')   
        evaluation6(1,i) = 1;
    elseif max6Idx(1,i) == 3 && strcmp(ampProbabilities6th{4,i},'Vox Valvetronix')
        evaluation6(1,i) = 1;
    end

end

evaluation12 = zeros(1,20);

for i = 1:20
    if max12Idx(1,i) == 1 && strcmp(ampProbabilities12th{4,i},'Raezer''s Edge')
        evaluation12(1,i) = 1;
    elseif max12Idx(1,i) == 2 && strcmp(ampProbabilities12th{4,i},'Fender Deluxe')   
        evaluation12(1,i) = 1;
    elseif max12Idx(1,i) == 3 && strcmp(ampProbabilities12th{4,i},'Vox Valvetronix')
        evaluation12(1,i) = 1;
    end

end

end