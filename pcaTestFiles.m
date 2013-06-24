%function [pcaCoeff,pcaScore,correctMat,bestFit] = pcaTestFiles
function testFilePCAScores = pcaTestFiles
% this function will go through each of the test files results and
%  load the file, process, and store the results

% NEED TO CHANGE THE SIZE OF AMPS PCA AND THE COUNTERS FOR DIFFERENT OCTAVE
% BAND FILES

% create a cell array to store the test file pcaScores
testFilePCAScores = cell(20,1);

for i = 1:20


    % load each test file
    eval(['load(''thirdTestDecons' num2str(i) ''')']);

    % create matrix to hold the reshaped 7x7 vectors.  This will be passed
    % to PCA
    ampsPCA = zeros(72,49);

 temp = 0;
    % create counter to fill out the pcaInput
    z = 1; 
    for a = 1:3
        for c = 1:24
            eval(['temp = thirdTestDecons' num2str(i) '{a,1}{c,1};']);
            temp = reshape(temp,1,49);
            ampsPCA(z,:) = temp;
            z = z+1;  
        end
    end


    % perform the pca
    [~,pcaScore,~] = princomp(ampsPCA);
    
    testFilePCAScores{i,1} = pcaScore; 
end
end
% 
% % % plot the different amps
%  figure(1)
% % plot the correct amp (the razer) with red x's
%  scatter3(pcaScore(1:3600,1),pcaScore(1:3600,2),pcaScore(1:3600,3),'r+');
%  hold on
% % % plot the rest of the Razer data
% % %scatter3(pcaScore(3601:10800,1),pcaScore(3601:10800,2),pcaScore(3601:10800,3),'r+');
% % 
% % % plot the first third of Deluxe as regular blue o's
% % scatter3(pcaScore(10801:14400,1),pcaScore(10801:14400,2),pcaScore(10801:14400,3),'g^');
% % % plot the middle third, the correct deconvolutions, as red x's
%  scatter3(pcaScore(14401:18000,1),pcaScore(14401:18000,2),pcaScore(14401:18000,3),'g^');
% % % plot the rest of the Deluxe as blue o's
% % scatter3(pcaScore(18001:21600,1),pcaScore(18001:21600,2),pcaScore(18001:21600,3),'g^');
% % 
% % % plot the first two thirds of the Vox data as blue o's
% % scatter3(pcaScore(21601:28800,1),pcaScore(21601:28800,2),pcaScore(21601:28800,3),'co');
% % % plot the last third of the vox amp, the correct deconvolution, as red x's
%  scatter3(pcaScore(28801:32400,1),pcaScore(28801:32400,2),pcaScore(28801:32400,3),'co');
% hold off


% plot the different amps (this show just each different amp and doesn;t
% differentiate on correct vs incorrect)
% figure(1)
% % plot the correct amp (the razer) with red x's
% scatter3(pcaScore(1:10800,1),pcaScore(1:10800,2),pcaScore(1:10800,3),'r+');
% hold on
% 
% % plot the first third of Deluxe as regular blue o's
% scatter3(pcaScore(10801:21600,1),pcaScore(10801:21600,2),pcaScore(10801:21600,3),'g^');
% 
% % plot the first two thirds of the Vox data as blue o's
% scatter3(pcaScore(21601:32400,1),pcaScore(21601:32400,2),pcaScore(21601:32400,3),'co');
% hold off

%% get the best fit line from the PCA data
% this code is also in the process_test_files_PCA.m, so it can be commented
% out for now unless you want to plot the best fit for the training set as
% well

% create matrix of only the "correct" data points
% correctMat = zeros(10800,3);
% correctMat(1:3600,1) = pcaScore(1:3600,1);
% correctMat(1:3600,2) = pcaScore(1:3600,2);
% correctMat(1:3600,3) = pcaScore(1:3600,3);
% 
% correctMat(3601:7200,1) = pcaScore(14401:18000,1);
% correctMat(3601:7200,2) = pcaScore(14401:18000,2);
% correctMat(3601:7200,3) = pcaScore(14401:18000,3);
% 
% correctMat(7201:10800,1) = pcaScore(28801:32400,1);
% correctMat(7201:10800,2) = pcaScore(28801:32400,2);
% correctMat(7201:10800,3) = pcaScore(28801:32400,3);
%  
% 
% % call to function to find the parametrically expressed points for least
% % squares line
% [m,p,s] = best_fit_line(correctMat(:,1),correctMat(:,2),correctMat(:,3));
% 
% % get get the mins
% minX = min(correctMat(:,1));
% minY = minX*p(2)/p(1) - m(1)*p(2)/p(1) + m(2);
% %minZ = ((2*p(3))/p(2).*minY) - ((p(3)/p(1)).*minX) + (m(3) + ((m(1)*p(3))/p(1)) - ((2*p(3)*m(2))/p(2)));
% minZ = minX*p(3)/p(1) - m(1)*p(3)/p(1) + m(3);
% 
% % get the maxes
% maxX = max(correctMat(:,1));
% maxY = maxX*p(2)/p(1) - m(1)*p(2)/p(1) + m(2);
% %maxZ = ((2*p(3))/p(2).*maxY) - ((p(3)/p(1)).*maxX) + (m(3) + ((m(1)*p(3))/p(1)) - ((2*p(3)*m(2))/p(2)));
% maxZ = maxX*p(3)/p(1) - m(1)*p(3)/p(1) + m(3);
% 
% % use the min/max to create a set of points for 3D line
% Xln = [minX maxX];
% Yln = [minY maxY];
% Zln = [minZ maxZ];
% 
% 
% % this holds hte best fit line coodinates
% bestFit = [Xln;Yln;Zln];
% 
% 
%  figure(1)
% % plot the correct amp (the razer) with red x's
%  scatter3(pcaScore(1:3600,1),pcaScore(1:3600,2),pcaScore(1:3600,3),11,'r+');
%  hold on
% % % plot the rest of the Razer data
% % %scatter3(pcaScore(3601:10800,1),pcaScore(3601:10800,2),pcaScore(3601:10800,3),'r+');
% % 
% % % plot the first third of Deluxe as regular blue o's
% % scatter3(pcaScore(10801:14400,1),pcaScore(10801:14400,2),pcaScore(10801:14400,3),'g^');
% % % plot the middle third, the correct deconvolutions, as red x's
%  scatter3(pcaScore(14401:18000,1),pcaScore(14401:18000,2),pcaScore(14401:18000,3),11,'g^');
% % % plot the rest of the Deluxe as blue o's
% % scatter3(pcaScore(18001:21600,1),pcaScore(18001:21600,2),pcaScore(18001:21600,3),'g^');
% % 
% % % plot the first two thirds of the Vox data as blue o's
% % scatter3(pcaScore(21601:28800,1),pcaScore(21601:28800,2),pcaScore(21601:28800,3),'co');
% % % plot the last third of the vox amp, the correct deconvolution, as red x's
%  scatter3(pcaScore(28801:32400,1),pcaScore(28801:32400,2),pcaScore(28801:32400,3),11,'co');
%  plot3(Xln,Yln,Zln,'m','LineWidth',5);
% hold off
% 
% 
% 
% end