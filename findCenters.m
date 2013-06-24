%% FIND CENTER OF EACH AMP
function [coordinates,centMat] = findCenters(refAmp,targetAmp,filtered)
% refAmp = the amp to be compared to from the filteredAmpMats 
% targetAmp = the amp to be compared (i.e., the amp whose center is needed
% overlayPlots = optional argument.  If 1, then a plot will show the found
% centers overlaid with the amp and microphone capsules.  
% filtered = optional argument.  Determines which body of code to excute
% below.  

if nargin < 3
    filtered = 1;
end

if filtered == 1
    % slice out a window (kind of like a "magnifying glass") of the amps
    % based on the Deluxe Amp.  Since Deluxe is reference, we know its
    % center is at {6:12,12:18}
    refAmp = refAmp(6:12,12:18);

    % need to first create a vector to store the sum of difference for each
    % window comparison
    errorSums= zeros(154,1);

    % need to loop through the whole target amp matrix at 1280 Hz to find
    % where the window sum of error is the least so we are lining up the
    % centers
    a = 1;
    
    for j = 1:7
        for i = 1:22 
            % temp will hold the window from the target amp
            temp = targetAmp((j:j+6),(i:i+6));
            % the idea is to do an absolute value of a matrix subtraction.  
            % This should go into a new temp matrix.  I will then sum all 
            % values within that matrix and store them in the errorSums 
            % vector .  Then move on to the next one.
            diff = abs(temp - refAmp);
            errorSums(a,1) = sum(diff(:));
            a = a+1;
        end
    end
    
    % need to now figure out where the minimum error is because that
    % indicates the best overlap
    [~,minIdx] = min(errorSums);
    
    % from the minIdx, can calculate the (j,i) values and extract that
    % window from the targetAmp
    colIdx = mod(minIdx,22);
    rowIdx = ((minIdx-colIdx)/22)+1;
    
    centMat = targetAmp((rowIdx:rowIdx+6),(colIdx:colIdx+6));  
    
    coordinates = [rowIdx,colIdx];


else
    % slice out a window (kind of like a "magnifying glass") of the amps
    % based on the Deluxe Amp.  Since Deluxe is reference, we know its
    % center is at {6:12,12:18}
    refAmp = refAmp(6:12,12:18);
    
    % need to first create a vector to store the sum of difference for each
    % window comparison
    errorSums= zeros(154,1);
    
    % need to loop through the whole target amp matrix at 1280 Hz to find
    % where the window sum of error is the least so we are lining up the
    % centers
    a = 1;
    
    for j = 1:7
        for i = 1:22 
            % temp will hold the window from the target amp
            temp = targetAmp((j:j+6),(i:i+6));
            % the idea is to do an absolute value of a matrix subtraction.  
            % This should go into a new temp matrix.  I will then sum all 
            % values within that matrix and store them in the errorSums 
            % vector .  Then move on to the next one.
            tempSTD = zeros(7,7);
            for y = 1:7
                for z = 1:7
                    diff = abs(temp{y,z} - refAmp{y,z});
                    stdDiff = std(diff);
                    tempSTD(y,z) = stdDiff;
                end
            end
            
            % sum the std and add to errorSums.  The lowest std sum will
            % give us our window alignment between amps
            errorSums(a,1) = sum(tempSTD(:));
            a = a+1;
        end
    end
    
    % need to now figure out where the minimum error is because that
    % indicates the best overlap
    [~,minIdx] = min(errorSums);
    
    % from the minIdx, can calculate the (j,i) values and extract that
    % window from the targetAmp
    colIdx = mod(minIdx,22);
    rowIdx = ((minIdx-colIdx)/22)+1;
    
    % this returns the overlapping window
    centMat = targetAmp((rowIdx:rowIdx+6),(colIdx:colIdx+6));  
    % this gives the beginning row/column coordinates for the window
    % overlap between amps
    coordinates = [rowIdx,colIdx];
    
end



end
