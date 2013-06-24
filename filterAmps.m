function filteredAmpMats = filterAmps
%function [outMatrixR,outMatrixD,outMatrixV] = filterAmps
%% this used to be loadAndFilterAmps.m
% rewrote it so that it will load the precentered amp matrices instead of
% all amp data.  Once we load each of those, they will then need to be
% filtered through eveery pitch of the 12 tone scale over several octaves
% 
% If any rollbacks need to be made, the filteredAmpMats.m file in the
% Old_Code folder is the original.  It was used to create the original
% filteredAmpMats.mat (now called filteredAmpMats_A.mat because this code
% used to only filter using frequencies of A)



    % load the .mat files.  These .mat files were created from the
    % getAmpCenters.m function.  These are the raw impulse responses from
    % teh center of the amp (i.e, these came straight from the struct.IRs
    % field, so they are different than the AmpNameFR.mat files because
    % those were created through the loadUnfilteredAmpIRs because that
    % function returns the frequency response in dB)
    load('RazerCenter.mat');
    load('DeluxCenter.mat');
    load('VoxCenter.mat');

    % all amplifiers were sampled at 48k
    fs = 48000;
    
    % all amp matrices are the same size, so just need the size of one of
    % them to use for looping later
    [razerRows,razerCols] = size(RazerCenter);
        
    % create an output matrix that is the size of the number of
    % rows/columns desired for each amp
    outMatrixR = zeros(razerRows,razerCols);
    outMatrixD = zeros(razerRows,razerCols);
    outMatrixV = zeros(razerRows,razerCols);

    %% Create OFFLINE
    % create matrix of center frequencies to be used for filtering and
    % analysis (10 center freques per pitch, 12 pitches
    centerFreqs = zeros(6,12);
    
    % create vector of base frequency for each pitch
    baseFreqs = [110 116.54 123.47 130.81 138.59 146.83 155.56 164.81 174.61 185 196 207.65];
    i = 1;
    centerFreqs(1,:) = baseFreqs;
    for h = 2:6
        for g = 1:12
            centerFreqs(h,g) = centerFreqs(1,g)*2^i;
            
        end
        i = i+1;
    end
    
    % turn the centerFreqs matrix into a vector
    centerFreqs = (centerFreqs(:))';
    
    
% loop through all indices of the centerFreqs matrix and filter each amp
% the output of each filtering operation will be a scaler.  This is stored
% in a vector for each microphone capsule.  
% The result will be a single vector for
% each capsule where each value corresponds to a center frequency filter
% operation.  These vectors should be stored into a cell array so that we
% have the values at each capsule around the center of the amp

% need to use 1/12th octave bands
% create a cell array to hold the filtered amplifiers magnitudes.  Each
% column of the array is a pitch (starting at A and going through G#, 1-12)
% the rows will each be a different octave
 filteredAmpMats = cell(length(baseFreqs),3);


%% This loop will need major revisions now that I am using all pitches
  for j = 1:length(centerFreqs)
    for i = 1:razerCols
        for k = 1:razerRows
            
            % call to the nOctaveBandResponse and put the 
            % magnitudes into the output matrices
            outMatrixR(k,i) = nOctaveBandResponse(RazerCenter{k,i},fs,centerFreqs(1,j),1/12);
            outMatrixD(k,i) = nOctaveBandResponse(DeluxCenter{k,i},fs,centerFreqs(1,j),1/12);
            outMatrixV(k,i) = nOctaveBandResponse(VoxCenter{k,i},fs,centerFreqs(1,j),1/12);
            
           %  Need to change this so that each amp has a cell array where
           %  each cell contains the filtered values at each location and
           %  frequency
              
             % put each filter amp signal into the cell array
             filteredAmpMats{j,1} = outMatrixR;
             filteredAmpMats{j,2} = outMatrixD;
             filteredAmpMats{j,3} = outMatrixV;
        end
     end
  end
   

  
end  
