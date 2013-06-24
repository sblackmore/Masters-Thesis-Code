function loadUnfilteredAmpIRs
    % this should probably be renamed to loadUnfilteredAmpFRMags because it
    % actually loads the IR, converts to frequency domain and gets the
    % magnitude in dB so we can compare and find centers later



    load('FaceRazer.mat');
    load('FaceDeluxe.mat');
    load('FaceVox');
    
    % get the sampling frequency.  It is the same for all measured amps
    fs = Razer(1,1).fs;
    
%     % test section
%     rfs = Razer(1,1).fs;
%     dfs = facePlane(1,1).fs;
%     vfs = Vox(1,1).fs;
    
    [razerRows,razerCols] = size(Razer);

    % create an output matrix that is the size of the number of
    % rows/columns desired for each amp
    RazerFR = cell(razerRows,razerCols);
    DeluxFR = cell(razerRows,razerCols);
    VoxFR = cell(razerRows,razerCols);
    
    for i = 1:razerCols
        for k = 1:razerRows
            % extract the IR at the index specified from each amp struct
            razerIR = Razer(k,i).IRs;
            deluxIR = facePlane(k,i+2).IRs;
            voxIR = Vox(k,i).IRs;
            
            % get dB magnitudes for each IR    
            fftLength = max([2^15, length(razerIR)]);
          
            % ******** RAZER **********
            % Frequency Domain
            rIR = fft(razerIR, fftLength);
            rIR = rIR(1:(fftLength/2));
            % Normalized Magnitudes
            r_magnitude = abs(rIR) / (fftLength/2);
            r_magnitude = 10*log10(abs(r_magnitude));
            
            % put into output matrix
             RazerFR{k,i} = r_magnitude;
            
            
            % ******** Deluxe **********
            % Frequency Domain
            dIR = fft(deluxIR, fftLength);
            dIR = dIR(1:(fftLength/2));
            % Normalized Magnitudes
            d_magnitude = abs(dIR) / (fftLength/2);
            d_magnitude = 10*log10(abs(d_magnitude));
            
            % put into output matrix
            if i == 18
                DeluxFR{k,i} = d_magnitude - 5;
            else
                DeluxFR{k,i} = d_magnitude;
            end
            
            % ******** Vox **********
            % Frequency Domain
            vIR = fft(voxIR, fftLength);
            vIR = vIR(1:(fftLength/2));
            % Normalized Magnitudes
            v_magnitude = abs(vIR) / (fftLength/2);
            v_magnitude = 10*log10(abs(v_magnitude));
            
            % put into output matrix
             VoxFR{k,i} = v_magnitude;
            
        end
    end
    
    % need to flip it so it is oriented correctly
    RazerFR = flipud(RazerFR);
    DeluxFR = flipud(DeluxFR);
    VoxFR = flipud(VoxFR);
    
end




