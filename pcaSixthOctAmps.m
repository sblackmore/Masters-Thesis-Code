function [pcaCoeff,pcaScore,correctMat,bestFit] = pcaSixthOctAmps


load('sixthOctRazeDecons');
load('sixthOctDeluxDecons');
load('sixthOctVoxDecons');

% create matrix to hold the reshaped 7x7 vectors.  This will be passed to
% PCA


% create matrix to hold out that is 3*50*36 * 3 mats for third octaves
ampsPCA = zeros(16200,49);

% create counter to fill out the pcaInput
z = 1;

% Razer
for a = 1:3
    for b = 1:50 
        for c = 1:36
            temp = sixthOctRazeDecons{a,b}{c,1};
            temp = reshape(temp,1,49);
            ampsPCA(z,:) = temp;
            z = z+1;
            
        end
    end
end

% delux
for a = 1:3
    for b = 1:50 
        for c = 1:36
            temp = sixthOctDeluxDecons{a,b}{c,1};
            temp = reshape(temp,1,49);
            ampsPCA(z,:) = temp;
            z = z+1;
            
        end
    end
end

% Vox 
for a = 1:3
    for b = 1:50 
        for c = 1:36
            temp = sixthOctVoxDecons{a,b}{c,1};
            temp = reshape(temp,1,49);
            ampsPCA(z,:) = temp;
            z = z+1;
            
        end
    end
end


% perform the pca and plot
[pcaCoeff,pcaScore,~] = princomp(ampsPCA);

% % % plot the different amps
% % figure(1)
% % % plot the correct amp (the razer) with red x's
% scatter3(pcaScore(1:5400,1),pcaScore(1:5400,2),pcaScore(1:5400,3),'r+');
% hold on
%  
% % Deluxe as regular blue o's
%  scatter3(pcaScore(5401:10800,1),pcaScore(5401:10800,2),pcaScore(5401:10800,3),'g^');
% 
% % % plot the first two thirds of the Vox data as blue o's
% scatter3(pcaScore(10801:16200,1),pcaScore(10801:16200,2),pcaScore(10801:16200,3),'co');
% 
% hold off


%% get the best fit line from the PCA data

% create matrix of only the "correct" data points
correctMat = zeros(5400,3);
correctMat(1:1800,1) = pcaScore(1:1800,1);
correctMat(1:1800,2) = pcaScore(1:1800,2);
correctMat(1:1800,3) = pcaScore(1:1800,3);

correctMat(1801:3600,1) = pcaScore(7201:9000,1);
correctMat(1801:3600,2) = pcaScore(7201:9000,2);
correctMat(1801:3600,3) = pcaScore(7201:9000,3);

correctMat(3601:5400,1) = pcaScore(14401:16200,1);
correctMat(3601:5400,2) = pcaScore(14401:16200,2);
correctMat(3601:5400,3) = pcaScore(14401:16200,3);


% call to function to find the parametrically expressed points for least
% squares line
[m,p,s] = best_fit_line(correctMat(:,1),correctMat(:,2),correctMat(:,3));

% get get the mins
minX = min(correctMat(:,1));
minY = minX*p(2)/p(1) - m(1)*p(2)/p(1) + m(2);
%minZ = ((2*p(3))/p(2).*minY) - ((p(3)/p(1)).*minX) + (m(3) + ((m(1)*p(3))/p(1)) - ((2*p(3)*m(2))/p(2)));
minZ = minX*p(3)/p(1) - m(1)*p(3)/p(1) + m(3);

% get the maxes
maxX = max(correctMat(:,1));
maxY = maxX*p(2)/p(1) - m(1)*p(2)/p(1) + m(2);
%maxZ = ((2*p(3))/p(2).*maxY) - ((p(3)/p(1)).*maxX) + (m(3) + ((m(1)*p(3))/p(1)) - ((2*p(3)*m(2))/p(2)));
maxZ = maxX*p(3)/p(1) - m(1)*p(3)/p(1) + m(3);

% use the min/max to create a set of points for 3D line
Xln = [minX maxX];
Yln = [minY maxY];
Zln = [minZ maxZ];

% this holds hte best fit line coodinates
bestFit = [Xln;Yln;Zln];

 figure(1)
% plot the correct amp (the razer) with red x's
 scatter3(pcaScore(1:1800,1),pcaScore(1:1800,2),pcaScore(1:1800,3),11,'r+');
 hold on
% % plot the rest of the Razer data
% %scatter3(pcaScore(3601:10800,1),pcaScore(3601:10800,2),pcaScore(3601:10800,3),'r+');
% 
% % plot the first third of Deluxe as regular blue o's
% scatter3(pcaScore(10801:14400,1),pcaScore(10801:14400,2),pcaScore(10801:14400,3),'g^');
% % plot the middle third, the correct deconvolutions, as red x's
 scatter3(pcaScore(7201:9000,1),pcaScore(7201:9000,2),pcaScore(7201:9000,3),11,'g^');
% % plot the rest of the Deluxe as blue o's
% scatter3(pcaScore(18001:21600,1),pcaScore(18001:21600,2),pcaScore(18001:21600,3),'g^');
% 
% % plot the first two thirds of the Vox data as blue o's
% scatter3(pcaScore(21601:28800,1),pcaScore(21601:28800,2),pcaScore(21601:28800,3),'co');
% % plot the last third of the vox amp, the correct deconvolution, as red x's
 scatter3(pcaScore(14401:16200,1),pcaScore(14401:16200,2),pcaScore(14401:16200,3),10,'co');
 plot3(Xln,Yln,Zln,'m','LineWidth',5);
hold off

end