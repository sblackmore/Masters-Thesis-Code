function thesisMain(computeAmpCents)
% computeAmpCents is optional and boolean.  If 2, then it will not have to
% do the section to compute the unfilteredAmpCenters (instead, it can just 
% load this as it has ben created already). The default will be set it to 2 
% if it is not entered as an input

if nargin <1
    computeAmpCents = 1;
end    
%     %load the 1/3 octave band  filtered amplifiers stored in matrix created
%     %by loadAndFilterAmps.m
%     
%     % *** NOTE *********
%     % In filteredAmpMats, col 1 = Razer, col 2 = Delux, col 3 = Vox
%     load('filteredAmpMats.mat');
%     
%     % load the unfiltered centers of the amps
%     load('DeluxCenter');
%     load('RazerCenter');
%     load('VoxCenter');
%     
% 
%     % create centFreqs vector to be used for plotting 
%     centFreqs = [110 220 440 880 1760 3520 7040 14080];
% 
%     % the Fender Deluxe is being used as the reference amp.
%     % Center of speaker cone = 12" from side, 10" from top
%     % capsule 1 starts at 1" from the floor
%     % the speaker cone center location in the Deluxe should be at {9,15}
%     % so, we will use a window of {6:12,12:18}   
% 
%     % the following top left coordinates for each amp were precomputed in a
%     % previous run of this function.  If new amps are added, then the
%     % variables with center will have to be added.
%     razerXY = [3 11];
%     deluxXY = [6 12];
%     voxXY = [3 12];
    
    
    % overlay the plots on the plotPositions graphs
    
    
    
    % only perform this section if new amps are added or the centers need
    % to be recomputed
    if computeAmpCents == 2
        % load the unfiltered amp frequency responses
        load('RazerFR');
        load('DeluxFR');
        load('VoxFR');
        
        [razerXY,~] = findCenters(DeluxFR,RazerFR,0);
        [deluxXY,~] = findCenters(DeluxFR,DeluxFR,0);
        [voxXY,~] = findCenters(DeluxFR,VoxFR,0);
          
        RazerCenter = getAmpCenterIRs('Razer',razerXY(1,1),razerXY(1,2));
        DeluxCenter = getAmpCenterIRs('Deluxe',deluxXY(1,1),deluxXY(1,2));
        VoxCenter = getAmpCenterIRs('Vox',voxXY(1,1),voxXY(1,2));
        
        save('RazerCenter','RazerCenter');
        save('DeluxCenter','DeluxCenter');
        save('VoxCenter','VoxCenter');
        % ********** Put a breakpoint at the clear, then can save the
        % unfiltered amps as .mat files.  I did have it save them
        % automatically, but it saved them as 1x1 structs with teh only
        % field being named afyer the variable.  This meant more coding
        % later.  This way is easier for now since these steps should not
        % have to be run many times.
        clear razerXY deluxXY voxXY RazerCenter DeluxCenter VoxCenter;
    end
  % do a point-by-point subtraction and get absolute value to see the
  % magnitude difference in dB

%   % create char cell arrays of the base names and centFreqs
%   %freqs = {'20','40','80','160','320','640','1280','2560','5120','10240'};
%   freqs = {'110','220','440','880','760','3520','7040','14080'};
%   baseVarNames = {'diffMatRD' 'diffMatRV' 'diffMatDV'};
%   varNames = cell((length(freqs) * length(baseVarNames)),1);
%   i = 1;
%   for a = 1:length(freqs)
%       for b = 1:length(baseVarNames)
%           varNames{i,1} = strcat(baseVarNames{1,b},freqs{1,a});
%           i = i+1;
%       end
%   end
%   
%   % loop through the varNames and point them to the diff values
%   z = 1;
%   for k = 1:length(centFreqs)
%       
%     % t,u, and v are temp vars to hold the dB magnitude difference.   
%     t = abs(ampCenters{k,1} - ampCenters{k,2}); 
%     u = abs(ampCenters{k,1} - ampCenters{k,3});
%     v = abs(ampCenters{k,2} - ampCenters{k,3});
%     
%     % genvarname creates actual variables in the workspace (i.e., in memory)
%     % based on the varNames array
%     a = genvarname(varNames{z,1});
%     z=z+1;
%     b = genvarname(varNames{z,1});
%     z=z+1;
%     c = genvarname(varNames{z,1});
%     
%     % eval forces it to set the varnames equal to the differences because
%     % it forces matlab to evaulate strings as commands
%     eval([a ' = t;']);
%     eval([b ' = u;']);
%     eval([c ' = v;']);
%     z = z+1;
%   end
%   
%   clear t;
%   clear u;
%   clear v;
%   
  % use pcolor(diffMatDV320);shading interp; -- this plots the matrix like
  % imagesc, but it uses interpolation
  
  
%% THIS SECTION WAS TAKEN FROM THE loadAndFilterAmps.m FILE **************  
  
%     % create 10 figures (one for each octave band.  Each figure will contain
%   % three plots (one for each amp).  
%   for i = 1:length(centFreqs)
%       figure(i)
%       hold on
%       for j = 1:3  
%         subplot(3,1,j);
%         imagesc(filteredAmpMats{i,j});
%         set(gca,'YDir','normal');
%         set(gca,'XTick',(1:2:28),'XTickLabel',(28:-2:1));
%         % determine the correct amp for the subplot title based on j
%         switch j
%             case 1
%                 title('Razer''s Edge');
%             case 2
%                 title('Fender Deluxe');
%             otherwise
%                 title('Vox Valtronix');
%         end
%         shading interp;
%       end
%         % this calls to function to add a "super" title covering all three
%         % subplots per figure.  It returns a handle which is then used for
%         % formatting of the title
%         [~,h]= suplabel(sprintf(['Spectrum of Face Plane With Center',... 
%                                  ' Frequency of %d HZ'],centFreqs(i)),'t');
%         set(h,'FontSize',14);
%         hold off;
%   end
%% *************************************************

  %{ 
    NEXT STEPS
  1) Obtain more data
  2) Try to overlap the found face planes with the plots.  Test error or
     correctness of overlap?
  3) Get a guitar signal playing different pitches -- DONE
  4) Create convolver and randomizer functions -- DONE FOR NOW
  5) Decide how to filter this and be able to test it against each amp for
     the nearest neighbor calculation (i.e., chroma filter or something
     like it)
  6) Plot results of nearest neighbor calculation
  %}
  
%% Convolutions section
% run a loop to create a large amount of convolved data that can be stored
% and then run through the deconvolver and analyzed for what "clean guitar"
% should sound like -- start with 50 runs

    % create cell vector to store the result of the convolutions
    convolvedRazer = cell(1,50);
    convolvedDelux = cell(1,50);
    convolvedVox = cell(1,50);
    
    % loop 50 times to build up a nice set of convolved data for each amp.
    % Although a random guitar sample from my bank is chosen each time, the
    % same sample is used for each amp on each iteration
%     for i = 1:50
%         [convolvedRazer{1,i},convolvedDelux{1,i},convolvedVox{1,i}] = guitarConvolver;
%     end
%     
%     save -v7.3 'convolvedRazer''convolvedRazer';
%     save -v7.3 'convolvedDelux' 'convolvedDelux'; 
%     save -v7.3 'convolvedVox' 'convolvedVox';
% %% Deconvolutions section
     % load the convolutions.  This should be done offline because it
     % is going to be huge.  store the results in the
     % "deconvolvedGuits.mat'
    % load('convolvedRazer.mat');
     load('convolvedDelux.mat');
     load('convolvedVox');
 
%     % create a cell vector to store the deconvolutions for each amp
%     % row 1 = razer
%     % row 2 = delux
%     % row 3 = vox
%     Each convolved amplifier will be deconvolved from the others so we
%     can get the noise + what "clean" guitar looks like.  There will be
%     three "deconvolvedAmpName arrays, each 3x150 (450 total
%     deconvolutions per convolved amp)
     deconvolvedRazer = cell(3,50);
     deconvolvedDelux = cell(3,50);
     deconvolvedVox = cell(3,50);
    % variable to loop on rows
    k = 1;
    % loop through all 50 of the convolutions and deconvolve them from each
    % amp and store the result
%     for i = 1:50
%         [deconvolvedRazer{k,i},~,~] = deconvolver(convolvedRazer{1,i});
%         k = k + 1;
%         [~,deconvolvedRazer{k,i},~] = deconvolver(convolvedRazer{1,i});
%         k = k + 1;
%         [~,~,deconvolvedRazer{k,i}] = deconvolver(convolvedRazer{1,i});
%         k = 1;      
%     end
%     save -v7.3 'deconvolvedRazer' 'deconvolvedRazer';

%     % variable to loop on rows
%     k = 1;
%     for i = 1:50
%         [deconvolvedDelux{k,i},~,~] = deconvolver(convolvedDelux{1,i});
%         k = k + 1;
%         [~,deconvolvedDelux{k,i},~] = deconvolver(convolvedDelux{1,i});
%         k = k + 1;
%         [~,~,deconvolvedDelux{k,i}] = deconvolver(convolvedDelux{1,i});
%         k = 1;      
%     end
%     save -v7.3 'deconvolvedDelux' 'deconvolvedDelux';
% end


    % variable to loop on rows
    k = 1;
    for i = 1:50
        [deconvolvedVox{k,i},~,~] = deconvolver(convolvedVox{1,i});
        k = k + 1;
        [~,deconvolvedVox{k,i},~] = deconvolver(convolvedVox{1,i});
        k = k + 1;
        [~,~,deconvolvedVox{k,i}] = deconvolver(convolvedVox{1,i});
        k = 1;      
    end
    save -v7.3 'deconvolvedVox' 'deconvolvedVox';
end



