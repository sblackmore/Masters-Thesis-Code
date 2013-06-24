function amp =  getAmpCenterIRs(ampName,rowIdx,colIdx)
% this function grabs the centered, unfiltered IRs from the amplifiers
% this function only works after the actual center windows have been found
% using either the findCenters.m file (can handle filtered or unfiltered
% amps)
% choose the correct amp based on the input
if strcmp(ampName,'Razer')
    load('FaceRazer.mat');
    tempAmp = Razer;
elseif strcmp(ampName,'Vox')
    load('FaceVox');
    tempAmp = Vox;
elseif strcmp(ampName,'Deluxe')
    load('FaceDeluxe.mat');
    tempAmp = facePlane;
end

chunk = tempAmp((rowIdx:rowIdx+6),(colIdx:colIdx+6));

amp = cell(7,7);

 for j = 1:7
     for k = 1:7
        amp{j,k} = chunk(j,k).IRs; 
     end    
 end
 
end