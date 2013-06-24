function thirdOctDecons = thirdOctDecon(convSig)


if strcmp(convSig,'test') == 1
    load('deconTestFileResult');
    razer = deconTestFileResult{1,1};
    delux = deconTestFileResult{2,1};
    vox = deconTestFileResult{3,1};
elseif strcmp(convSig,'razer') == 1
    load('deconvolvedRazer');
elseif strcmp(convSig,'delux') == 1
    load('deconvolvedDelux');
elseif strcmp(convSig,'vox') == 1
    load('deconvolvedVox');
end
    

    
    % create matrix of center frequencies to be used for filtering and
    % analysis (10 center freques per pitch, 12 pitches
    centerFreqs = zeros(6,4);
    
    % create vector of base frequency for each pitch
    baseFreqs = [110 138.59 174.61 207.65];
    i = 1;
    centerFreqs(1,:) = baseFreqs;
    for h = 2:6
        for g = 1:4
            centerFreqs(h,g) = centerFreqs(1,g)*2^i;
            
        end
        i = i+1;
    end
    
% turn the centerFreqs matrix into a vector 2 methods depending on how
% the values should be access (i.e., notes grouped or sequential)
    
% centerFreqs = (centerFreqs(:))'; %this method keeps all octaves of a note together (e.g., 110 220. . .,then 116. . .)
   
centerFreqs = reshape(centerFreqs',1,24); % this method does each note chromatically


% this is if the filtered training data needs to be recreated for each amp
if strcmp(convSig,'test') == 0
    
    % this will store the result of 1/12 octave band filtered decons.  Each
    % cell in this array will contain a 1x72 cell array.  Each cell of that
    % will be 7x7 and contain the dB magnitude values
    thirdOctDecons = cell(3,50);
    

       for k = 1:50 
           for j = 1:3
            %decon = deconvolvedRazer{j,k};
            % decon = deconvolvedDelux{j,k};
             decon = deconvolvedVox{j,k};
            thirdOctDecons{j,k} = thirdFilterDecons(decon,centerFreqs);
           end
       end
end 

if strcmp(convSig,'test') == 1

    thirdOctDecons = cell(3,1);
    
    % pass each deconvolution of the test result to the 1/12 octave band
    % filters
    thirdOctDecons{1,1} = thirdFilterDecons(razer,centerFreqs);
    thirdOctDecons{2,1} = thirdFilterDecons(delux,centerFreqs);
    thirdOctDecons{3,1} = thirdFilterDecons(vox,centerFreqs);
    
end

end

function filterResult = thirdFilterDecons(decon,centFreqs)
   
    % all amplifiers were sampled at 48k
    fs = 48000;
    rows = 7;
    columns = 7;
    

% need to use 1/12th octave bands
% create a cell array to hold the filtered amplifiers magnitudes.  Each
% column of the array is a pitch (starting at A and going through G#, 1-12)
% the rows will each be a different octave

filterResult = cell(length(centFreqs),1);
%filteredAmpMatsD = cell(length(centerFreqs),1);
%filteredAmpMatsV = cell(length(centerFreqs),1);



%% this section should be a separate function that gets called from a loop 
%  that goes through each deconvolution array
% code to test a couple of the deconvolutions
    outMatrixR = zeros(rows,columns);
%    outMatrixD = zeros(rows,columns);
%    outMatrixV = zeros(rows,columns);

  for j = 1:length(centFreqs)
    for i = 1:columns
        for k = 1:rows
            % extract the deconvolution
            temp = decon{k,i};
         %   deluxDecon = delux{k,i};
         %   voxDecon = vox{k,i};
            
            % call to the nOctaveBandResponse and put the 
            % magnitudes into the output matrices
            outMatrixR(k,i) = nOctaveBandResponse(temp,fs,centFreqs(1,j));
        %    outMatrixD(k,i) = nOctaveBandResponse(deluxDecon,fs,centFreqs(1,j),1/12);
        %    outMatrixV(k,i) = nOctaveBandResponse(voxDecon,fs,centFreqs(1,j),1/12);
            
            % put each filter amp signal into the cell array
            filterResult{j,1} = outMatrixR;
        %    filteredAmpMatsD{j,1} = outMatrixD;
        %    filteredAmpMatsV{j,1} = outMatrixV;
        end
     end
  end
  
  % create a large test cell array to hold all amps
%  testFilteredDecons = [filteredAmpMatsR filteredAmpMatsR filteredAmpMatsV];
  %test the plotting
%  plotDecons(testFilteredDecons,12,centerFreqs);
  
end