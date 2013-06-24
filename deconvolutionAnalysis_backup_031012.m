function filteredDecons = deconvolutionAnalysis%(convSig)

%load('deconvolvedGuits.mat');

% pass through the 1/12 octave bands to look at noise in different octaves
% need to filter them and store the results

% filter the convolved signal through the 1/12 octave bands
% need to have center frequencies for each pitch (i.e., 12 sets of center
% frequencies within the range we care about

%load('deconvolvedRazer');
%load('deconvolvedDelux');
%load('deconvolvedVox');


% test of just one cell of the small array
% razer = testRazer{1,1};
% delux = testDelux{1,1};
% vox = testVox{1,1};


    
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
    
    % this will store the result of 1/12 octave band filtered decons.  Each
    % cell in this array will contain a 1x72 cell array.  Each cell of that
    % will be 7x7 and contain the dB magnitude values
    filteredDecons = cell(3,50);
    
    % turn the centerFreqs matrix into a vector 2 methods depending on how
    % the values should be access (i.e., notes grouped or sequential)
    
   % centerFreqs = (centerFreqs(:))'; %this method keeps all octaves of a note together (e.g., 110 220. . .,then 116. . .)
   
   centerFreqs = reshape(centerFreqs',1,72); % this method does each note chromatically
   
   for k = 1:50 
       for j = 1:3
       % decon = deconvolvedRazer{j,k};
        %decon = deconvolvedDelux{j,k};
        decon = deconvolvedVox{j,k};
        filteredDecons{j,k} = filterDecons(decon,centerFreqs);
       end
   end
end     


%% 
function filterResult = filterDecons(decon,centFreqs)
   
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
            outMatrixR(k,i) = nOctaveBandResponse(temp,fs,centFreqs(1,j),1/12);
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
