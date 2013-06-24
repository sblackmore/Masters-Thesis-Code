
function testFileProbabilities = process_test_files_PCA_3rd_plot
% load the training data
load('pcaScore12');
load('correctMat12');

% this get the correct deconvolutions from the stored PCA for the training
% amps.  This is used for best fit and for plotting
% correctMat = zeros(10800,3);
% correctMat(1:3600,1) = pcaScore12(1:3600,1);
% correctMat(1:3600,2) = pcaScore12(1:3600,2);
% correctMat(1:3600,3) = pcaScore12(1:3600,3);
% 
% correctMat(3601:7200,1) = pcaScore12(14401:18000,1);
% correctMat(3601:7200,2) = pcaScore12(14401:18000,2);
% correctMat(3601:7200,3) = pcaScore12(14401:18000,3);
% 
% correctMat(7201:10800,1) = pcaScore12(28801:32400,1);
% correctMat(7201:10800,2) = pcaScore12(28801:32400,2);
% correctMat(7201:10800,3) = pcaScore12(28801:32400,3);
 
%% LINE 20 - 70 IS TRAINING DATA ONLY
% call to function to find the parametrically expressed points for least
% squares line
[m,p,s] = best_fit_line(correctMat12(:,1),correctMat12(:,2),correctMat12(:,3));

% get get the mins
minX = min(correctMat12(:,1));
minY = minX*p(2)/p(1) - m(1)*p(2)/p(1) + m(2);
%minZ = ((2*p(3))/p(2).*minY) - ((p(3)/p(1)).*minX) + (m(3) + ((m(1)*p(3))/p(1)) - ((2*p(3)*m(2))/p(2)));
minZ = minX*p(3)/p(1) - m(1)*p(3)/p(1) + m(3);

% get the maxes
maxX = max(correctMat12(:,1));
maxY = maxX*p(2)/p(1) - m(1)*p(2)/p(1) + m(2);
%maxZ = ((2*p(3))/p(2).*maxY) - ((p(3)/p(1)).*maxX) + (m(3) + ((m(1)*p(3))/p(1)) - ((2*p(3)*m(2))/p(2)));
maxZ = maxX*p(3)/p(1) - m(1)*p(3)/p(1) + m(3);

% use the min/max to create a set of points for 3D line
Xln = [minX maxX];
Yln = [minY maxY];
Zln = [minZ maxZ];

bestFitMax = [maxX maxY maxZ];

%% plot the pca of the training data correct amps
 figure(1)
% plot the correct amp (the razer) with red x's
 scatter3(pcaScore12(1:3600,1),pcaScore12(1:3600,2),pcaScore12(1:3600,3),11,'k+');%'r+');
 hold on
% % plot the rest of the Razer data
% %scatter3(pcaScore(3601:10800,1),pcaScore(3601:10800,2),pcaScore(3601:10800,3),'r+');
% 
% % plot the first third of Deluxe as regular blue o's
% scatter3(pcaScore(10801:14400,1),pcaScore(10801:14400,2),pcaScore(10801:14400,3),'g^');
% % plot the middle third, the correct deconvolutions, as red x's
 scatter3(pcaScore12(14401:18000,1),pcaScore12(14401:18000,2),pcaScore12(14401:18000,3),11,'k+');%'g^');
% % plot the rest of the Deluxe as blue o's
% scatter3(pcaScore(18001:21600,1),pcaScore(18001:21600,2),pcaScore(18001:21600,3),'g^');
% 
% % plot the first two thirds of the Vox data as blue o's
% scatter3(pcaScore(21601:28800,1),pcaScore(21601:28800,2),pcaScore(21601:28800,3),'co');
% % plot the last third of the vox amp, the correct deconvolution, as red x's
 scatter3(pcaScore12(28801:32400,1),pcaScore12(28801:32400,2),pcaScore12(28801:32400,3),11,'k+');%'co');
 plot3(Xln,Yln,Zln,'m','LineWidth',5);
 
 
 
 
 
 
%% load the pcaScores array for the 20 test files
load('testFilePCAScores12th');

% loop through the tewnty test files.  Get a cell, and set pcaScore to that
% cell.  Perform all steps to calculate the probabilities, and store the
% results in testFileProbabilities.mat.  That will be cell(3,20).  Rows are
% %r,%d,%v, respectively
testFileProbabilities = cell(4,20);

for i = 1:20
    
    pcaScore = testFilePCAScores12th{12,1};
    % gets averages to plot so we can start testing distances.  The "pcaScore"
    % variable comes from pcaTestFiles.m.  It is the pca of a given test
    rX = pcaScore(1:24,1);
    aveRX = mean(rX);
    rY = pcaScore(1:24,2);
    aveRY = mean(rY);
    rZ = pcaScore(1:24,3);
    aveRZ = mean(rZ);

    dX = pcaScore(25:48,1);
    aveDX = mean(dX);
    dY = pcaScore(25:48,2);
    aveDY = mean(dY);
    dZ = pcaScore(25:48,3);
    aveDZ = mean(dZ);

    vX = pcaScore(49:72,1);
    aveVX = mean(vX);
    vY = pcaScore(49:72,2);
    aveVY = mean(vY);
    vZ = pcaScore(49:72,3);
    aveVZ = mean(vZ);

    %% different options for plotting test file pca
    scatter3(pcaScore(1:72,1),pcaScore(1:72,2),pcaScore(1:72,3),13,'co');
    scatter3(pcaScore(73:144,1),pcaScore(73:144,2),pcaScore(73:144,3),13,'go');
    scatter3(pcaScore(145:216,1),pcaScore(145:216,2),pcaScore(145:216,3),13,'bo');
    scatter3(aveRX,aveRY,aveRZ,25,'mo');
    scatter3(aveDX,aveDY,aveDZ,25,'ro');
    scatter3(aveVX,aveVY,aveVZ,25,'bo');



    %% figure out distance from line of best fit to the average points
    % see Thesis notebook page dated 3/25 for linear algebra explanation from
    % Aron on how to find the orthogonal distance from point to line in 3D

    % U is the endpoint-endpoint XYZ of best fit line
    uX = maxX - minY;
    uY = maxY - minY;
    uZ = maxZ - minZ;

    uHatX = uX/sqrt(uX^2 + uY^2 + uZ^2); 
    uHatY = uY/sqrt(uX^2 + uY^2 + uZ^2);
    uHatZ = uZ/sqrt(uX^2 + uY^2 + uZ^2);

    uHat = [uHatX uHatY uHatZ];


    % distance for Razer
    rHHatX = aveRX - maxX;   
    rHHatY = aveRY - maxY;
    rHHatZ = aveRZ - maxZ;
    rHhatMag = abs(sqrt(rHHatX^2 + rHHatY^2 + rHHatZ^2));
 
% rUHatX = uX/sqrt(uX^2 + uY^2 + uZ^2); 
% rUHatY = uY/sqrt(uX^2 + uY^2 + uZ^2);
% rUHatZ = uZ/sqrt(uX^2 + uY^2 + uZ^2);
%  
% uHat = [rUHatX rUHatY rUHatZ];
    rHHat = [rHHatX rHHatY rHHatZ];
    rLDot = abs(dot(uHat,rHHat));

    rDist2 = sqrt((rHhatMag^2) - (rLDot^2));

    % distance for Deluxe
    dHHatX = aveDX - maxX;   
    dHHatY = aveDY - maxY;
    dHHatZ = aveDZ - maxZ;
    dHhatMag = abs(sqrt(dHHatX^2 + dHHatY^2 + dHHatZ^2));

    dHHat = [dHHatX dHHatY dHHatZ];
    dLDot = abs(dot(uHat,dHHat));

    dDist2 = sqrt((dHhatMag^2) - (dLDot^2));
 
    % distance for vox
    vHHatX = aveVX - maxX;   
    vHHatY = aveVY - maxY;
    vHHatZ = aveVZ - maxZ;
    vHhatMag = abs(sqrt(vHHatX^2 + vHHatY^2 + vHHatZ^2));

    vHHat = [vHHatX vHHatY vHHatZ];
    vLDot = abs(dot(uHat,vHHat));

    vDist2 = sqrt((vHhatMag^2) - (vLDot^2));


    % store all distances
    allDistances = [rDist2 dDist2 vDist2];

    % figure out the percentage of each distance, then subtract result from 100
    % to get the % probability that it's certain amplifier
%     razerProb = (1 - (allDistances(1,1)/sum(allDistances))) * 100;
%     deluxeProb = (1 - (allDistances(1,2)/sum(allDistances))) * 100;
%     voxProb = (1 - (allDistances(1,3)/sum(allDistances))) * 100;

    % store the distance results
    testFileProbabilities{1,i} = (1 - (allDistances(1,1)/sum(allDistances))) * 100;
    testFileProbabilities{2,i} = (1 - (allDistances(1,2)/sum(allDistances))) * 100;
    testFileProbabilities{3,i} = (1 - (allDistances(1,3)/sum(allDistances))) * 100;
    
end
    
load('correct');
% append the correct amps into the testFileProbabilities
for j = 1:20
    testFileProbabilities{4,j} = correct{j,1};
     
end


end

 