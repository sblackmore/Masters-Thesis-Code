function plotDecons(filteredAmp,pitch)

% filteredAmp can be 'razer', 'delux', or 'vox'
if strcmp(filteredAmp,'razer')
    temp = load('filteredRazeDecons');
    ampDecons = temp.filteredRazeDecons;
elseif strcmp(filteredAmp,'delux')
    temp = load('filteredDeluxDecons');
    ampDecons = temp.filteredDeluxDecons;
elseif strcmp(filteredAmp,'vox')
    temp = load('filteredVoxDecons');
    ampDecons = temp.filteredVoxDecons;    
end

% get the full centerFreqs vector to use to fill out the frequencies
% based on the intput pitch
centerFreqs = load('centerFreqs_chromatic');
centFreqs = centerFreqs.centerFreqs;

% frequencies should is a vector of specific frequencies to use as a sample
% it is based on the pitch.  It will then extract that pitch at each octave
% from centFrqs

% allocate frequencies
frequencies = zeros(1,6);

if strcmp(pitch,'a')
    frequencies(1,1) = centFreqs(1,1);
    start = 1;
elseif strcmp(pitch,'a#')     
    frequencies(1,1) = centFreqs(1,2);
    start = 2;
elseif strcmp(pitch,'b')     
    frequencies(1,1) = centFreqs(1,3);
    start = 3;
elseif strcmp(pitch,'c')     
    frequencies(1,1) = centFreqs(1,4);
    start = 4;
elseif strcmp(pitch,'c#')     
    frequencies(1,1) = centFreqs(1,5);
    start = 5;
elseif strcmp(pitch,'d')     
    frequencies(1,1) = centFreqs(1,6);
    start = 6;
elseif strcmp(pitch,'d#')     
    frequencies(1,1) = centFreqs(1,7);
    start = 7;
elseif strcmp(pitch,'e')     
    frequencies(1,1) = centFreqs(1,8);
    start = 8;
elseif strcmp(pitch,'f')     
    frequencies(1,1) = centFreqs(1,9);
    start = 9;
elseif strcmp(pitch,'f#')     
    frequencies(1,1) = centFreqs(1,10);
    start = 10;
elseif strcmp(pitch,'g')     
    frequencies(1,1) = centFreqs(1,11);
    start = 11;
else strcmp(pitch,'g#') 
    frequencies = centFreqs(1,12);
    start = 12;
end


% fill out the rest of the frequencies vector with octave frequency values
% of the desired root note
idx = start + 12;
for i = 2:6
    frequencies(1,i) = centFreqs(1,idx);
    idx = idx + 12;
end

% allocate a cell array to hold the spedific desired frequencies from the
% filtered amp deconvolutions
ampFreqs = cell(6,3);

% grab a random sample from one of the 50 tests in ampDecons
%ampSample = ampDecons(:,randi(50));
ampSample = ampDecons(:,5);
% set these variables to be able to extract the 6 octaves of the speicifed
% note
razer = ampSample{1,1};
delux = ampSample{2,1};
vox = ampSample{3,1};


% grab the octaves of the desired pitch from the full amp decons
idx = start;
for i = 1:6
        
        ampFreqs{i,1} = razer{idx,1};
        ampFreqs{i,2} = delux{idx,1};
        ampFreqs{i,3} = vox{idx,1};

    idx = idx + 12;
end


%  create 6 figures (one for each octave band.  Each figure will contain
%  three plots (one for each amp). 
close all;

if strcmp(filteredAmp,'razer')
  for i = 1:6
      figure(i)
      hold on
      for j = 1:3  
        subplot(3,1,j);
        pcolor(ampFreqs{i,j});shading interp;
        switch i
            case 1
                caxis([-31 -23]);
            case 2
                caxis([-31 -25]);
            case 3
                caxis([-39 -30]);
            case 4
                caxis([-46 -33]);
            case 5
                caxis([-64 -49]);
            case 6
                caxis([-81 -60]);
       end
        colorbar;
        % determine the correct amp for the subplot title based on j
        switch j
            case 1
                title('Razer''s Edge');
            case 2
                title('Fender Deluxe');
            otherwise
                title('Vox Valtronix');
        end
%        % shading interp;
       end
        % this calls to function to add a "super" title covering all three
        % subplots per figure.  It returns a handle which is then used for
        % formatting of the title
        
        [~,h]= suplabel(sprintf(['Face Plane With Center',... 
                                 ' Frequency of %d HZ'],round(frequencies(i))),'t');
        set(h,'FontSize',11);
        hold off;
  end
end

if strcmp(filteredAmp,'delux')
  for i = 1:6
      figure(i)
      hold on
      for j = 1:3  
        subplot(3,1,j);
        pcolor(ampFreqs{i,j});shading interp;
        switch i
            case 1
                caxis([-32 -23]);
            case 2
                caxis([-35 -28]);
            case 3
                caxis([-40 -32]);
            case 4
                caxis([-46 -34]);
            case 5
                caxis([-63 -49]);
            case 6
                caxis([-75 -45]);
        end
        colorbar;
        % determine the correct amp for the subplot title based on j
        switch j
            case 1
                title('Razer''s Edge');
            case 2
                title('Fender Deluxe');
            otherwise
                title('Vox Valtronix');
        end
%        % shading interp;
       end
        % this calls to function to add a "super" title covering all three
        % subplots per figure.  It returns a handle which is then used for
        % formatting of the title
        
        [~,h]= suplabel(sprintf(['Face Plane With Center',... 
                                 ' Frequency of %d HZ'],round(frequencies(i))),'t');
        set(h,'FontSize',11);
        hold off;
  end
end

if strcmp(filteredAmp,'vox')
  for i = 1:6
      figure(i)
      hold on
      for j = 1:3  
        subplot(3,1,j);
        pcolor(ampFreqs{i,j});shading interp;
        switch i
            case 1
                caxis([-27 -21]);
            case 2
                caxis([-35 -28]);
            case 3
                caxis([-42 -33]);
            case 4
                caxis([-51 -34]);
            case 5
                caxis([-62 -45]);
            case 6
                caxis([-63 -38]);
        end
        colorbar;
        % determine the correct amp for the subplot title based on j
        switch j
            case 1
                title('Razer''s Edge');
            case 2
                title('Fender Deluxe');
            otherwise
                title('Vox Valtronix');
        end
%        % shading interp;
       end
        % this calls to function to add a "super" title covering all three
        % subplots per figure.  It returns a handle which is then used for
        % formatting of the title
        
        [~,h]= suplabel(sprintf(['Face Plane With Center',... 
                                 ' Frequency of %d HZ'],round(frequencies(i))),'t');
        set(h,'FontSize',11);
        hold off;
  end
end

end