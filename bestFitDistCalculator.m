function ampProbabilities = bestFitDistCalculator
% This function loads test file results.  It loops through them and
% calculates lines of best fit for each amplifier.  The distance from each
% point within a test is measured from it's corresponding amplifier's line
% of best fit.  The results are stored, and the standard deviation is
% calculated.  The amplifier with the lowest standard deviation is the most
% likely candidate.
% NEED TO MANUALLY CHANGE WHICH CODE IS COMMENTED BASED ON 3rd, 6th, OR
% 12th OCTAVE DATA (DEPENDING ON WHAT"S NEEDED).  NEED TO ADD IF_ELSE LOGIC
% TO LET USER PUT THIS IN AS PARAMETER


ampProbabilities = cell(4,20);


for j = 1:20
% load('testFilePCAScores12th');
% temp = testFilePCAScores12th{j,1};

  load('testFilePCAScores6th');
  temp = testFilePCAScores6th{j,1};

%  load('testFilePCAScores3rd');
%  temp = testFilePCAScores3rd{j,1};


% calculate a best fit line for each of the three amps from the test file pca
% data
% 12th
% [mR,pR,sR] = best_fit_line(temp(1:72,1),temp(1:72,2),temp(1:72,3));
% [mD,pD,sD] = best_fit_line(temp(73:144,1),temp(73:144,2),temp(73:144,3));
% [mV,pV,sV] = best_fit_line(temp(145:216,1),temp(145:216,2),temp(145:216,3));

% 6th
[mR,pR,sR] = best_fit_line(temp(1:36,1),temp(1:36,2),temp(1:36,3));
[mD,pD,sD] = best_fit_line(temp(37:72,1),temp(37:72,2),temp(37:72,3));
[mV,pV,sV] = best_fit_line(temp(73:108,1),temp(73:108,2),temp(73:108,3));

% 3rd
%  [mR,pR,sR] = best_fit_line(temp(1:24,1),temp(1:24,2),temp(1:24,3));
%  [mD,pD,sD] = best_fit_line(temp(25:48,1),temp(25:48,2),temp(25:48,3));
%  [mV,pV,sV] = best_fit_line(temp(49:72,1),temp(49:72,2),temp(49:72,3));



% get get the mins

%% Razer
%12th
%minXR = min(temp(1:72,1));

% 6th
  minXR = min(temp(1:36,1));

% 3rd
% minXR = min(temp(1:24));

minYR = minXR*pR(2)/pR(1) - mR(1)*pR(2)/pR(1) + mR(2);
minZR = minXR*pR(3)/pR(1) - mR(1)*pR(3)/pR(1) + mR(3);

% get the maxes
%maxXR = max(temp(1:72,1));
maxXR = max(temp(1:36,1));
%maxXR = max(temp(1:24,1));
maxYR = maxXR*pR(2)/pR(1) - mR(1)*pR(2)/pR(1) + mR(2);
maxZR = maxXR*pR(3)/pR(1) - mR(1)*pR(3)/pR(1) + mR(3);

% use the min/max to create a set of points for 3D line
XlnR = [minXR maxXR];
YlnR = [minYR maxYR];
ZlnR = [minZR maxZR];


%% Deluxe
%minXD = min(temp(73:144,1));
minXD = min(temp(37:72,1));
%minXD = min(temp(25:48,1));
minYD = minXD*pD(2)/pD(1) - mD(1)*pD(2)/pD(1) + mD(2);
minZD = minXD*pD(3)/pD(1) - mD(1)*pD(3)/pD(1) + mD(3);

% get the maxes
%maxXD = max(temp(73:144,1));
maxXD = max(temp(37:72,1));
%maxXD = max(temp(25:48,1));
maxYD = maxXD*pD(2)/pD(1) - mD(1)*pD(2)/pD(1) + mD(2);
maxZD = maxXD*pD(3)/pD(1) - mD(1)*pD(3)/pD(1) + mD(3);

% use the min/max to create a set of points for 3D line
XlnD = [minXD maxXD];
YlnD = [minYD maxYD];
ZlnD = [minZD maxZD];



%% Vox
%minXV = min(temp(145:216,1));
minXV = min(temp(73:108,1));
%minXV = min(temp(49:72,1));
minYV = minXV*pV(2)/pV(1) - mV(1)*pV(2)/pV(1) + mV(2);
minZV = minXV*pV(3)/pV(1) - mV(1)*pV(3)/pV(1) + mV(3);

% get the maxes
%maxXV = max(temp(145:216,1));
maxXV = max(temp(73:108,1));
%maxXV = max(temp(49:72,1));
maxYV = maxXV*pV(2)/pV(1) - mV(1)*pV(2)/pV(1) + mV(2);
maxZV = maxXV*pV(3)/pV(1) - mV(1)*pV(3)/pV(1) + mV(3);

% use the min/max to create a set of points for 3D line
XlnV = [minXV maxXV];
YlnV = [minYV maxYV];
ZlnV = [minZV maxZV];


%% plot the lines of best overlaid with each of the filtered deconvolution
% PCAs
%      scatter3(temp(1:72,1),temp(1:72,2),temp(1:72,3),13,'mo');
%      hold on
%      scatter3(temp(73:144,1),temp(73:144,2),temp(73:144,3),13,'go');
%      scatter3(temp(145:216,1),temp(145:216,2),temp(145:216,3),13,'bo');
%      plot3(XlnR,YlnR,ZlnR,'m','LineWidth',5);
%      plot3(XlnD,YlnD,ZlnD,'g','LineWidth',5);
%      plot3(XlnV,YlnV,ZlnV,'b','LineWidth',5);
%      hold off



% RAZER
    %% figure out distance from line of best fit to the average points
    % see Thesis notebook page dated 3/25 for linear algebra explanation from
    % Aron on how to find the orthogonal distance from point to line in 3D

    % U is the endpoint-endpoint XYZ of best fit line
    uXR = maxXR - minYR;
    uYR = maxYR - minYR;
    uZR = maxZR - minZR;

    uHatXR = uXR/sqrt(uXR^2 + uYR^2 + uZR^2); 
    uHatYR = uYR/sqrt(uXR^2 + uYR^2 + uZR^2);
    uHatZR = uZR/sqrt(uXR^2 + uYR^2 + uZR^2);

    uHatR = [uHatXR uHatYR uHatZR];
    
% allocate vector to hold distance for each data point to line of best fit 
% for Razer    
% razerDistances = zeros(1,72);   
 razerDistances = zeros(1,36); 
%razerDistances = zeros(1,24); 
% need to loop through all Razer values from the test data PCA
% razer = temp(1:72,:);
razer = temp(1:36,:);
%razer = temp(1:24,:);
%for i = 1:72
for i = 1:36
%for i = 1:24
    
    % distance for Razer
    rHHatX = razer(i,1) - maxXR;   
    rHHatY = razer(i,2) - maxYR;
    rHHatZ = razer(i,3) - maxZR;
    rHhatMag = abs(sqrt(rHHatX^2 + rHHatY^2 + rHHatZ^2));
 
    rHHat = [rHHatX rHHatY rHHatZ];
    rLDot = abs(dot(uHatR,rHHat));

    %rDist = sqrt((rHhatMag^2) - (rLDot^2));

    razerDistances(1,i) = sqrt((rHhatMag^2) - (rLDot^2));
end
    
    
% Deluxe
    %% figure out distance from line of best fit to the average points
    % see Thesis notebook page dated 3/25 for linear algebra explanation from
    % Aron on how to find the orthogonal distance from point to line in 3D

    % U is the endpoint-endpoint XYZ of best fit line
    uXD = maxXD - minYD;
    uYD = maxYD - minYD;
    uZD = maxZD - minZD;

    uHatXD = uXD/sqrt(uXD^2 + uYD^2 + uZD^2); 
    uHatYD = uYD/sqrt(uXD^2 + uYD^2 + uZD^2);
    uHatZD = uZD/sqrt(uXD^2 + uYD^2 + uZD^2);

    uHatD = [uHatXD uHatYD uHatZD];
    
% allocate vector to hold distance for each data point to line of best fit 
% for Razer    
 %deluxeDistances = zeros(1,72);   
 deluxeDistances = zeros(1,36); 
% deluxeDistances = zeros(1,24); 


% need to loop through all Razer values from the test data PCA
%  deluxe = temp(73:144,:);
%  for i = 1:72
deluxe = temp(37:72,:);
for i = 1:36    
% deluxe = temp(25:48,:);
% for i = 1:24  
    % distance for Razer
    dHHatX = deluxe(i,1) - maxXD;   
    dHHatY = deluxe(i,2) - maxYD;
    dHHatZ = deluxe(i,3) - maxZD;
    dHhatMag = abs(sqrt(dHHatX^2 + dHHatY^2 + dHHatZ^2));
 
    dHHat = [dHHatX dHHatY dHHatZ];
    dLDot = abs(dot(uHatD,dHHat));

    %rDist = sqrt((rHhatMag^2) - (rLDot^2));

    deluxeDistances(1,i) = sqrt((dHhatMag^2) - (dLDot^2));
end    
    
%% Vox
    %% figure out distance from line of best fit to the average points
    % see Thesis notebook page dated 3/25 for linear algebra explanation from
    % Aron on how to find the orthogonal distance from point to line in 3D

    % U is the endpoint-endpoint XYZ of best fit line
    uXV = maxXV - minYV;
    uYV = maxYV - minYV;
    uZV = maxZV - minZV;

    uHatXV = uXV/sqrt(uXV^2 + uYV^2 + uZV^2); 
    uHatYV = uYV/sqrt(uXV^2 + uYV^2 + uZV^2);
    uHatZV = uZV/sqrt(uXV^2 + uYV^2 + uZV^2);

    uHatV = [uHatXV uHatYV uHatZV];
    
% allocate vector to hold distance for each data point to line of best fit 
% for Razer    
% voxDistances = zeros(1,72);   
 voxDistances = zeros(1,36);
% voxDistances = zeros(1,24);

% need to loop through all Razer values from the test data PCA
%  vox = temp(145:216,:);
%  for i = 1:72

vox = temp(73:108,:);
for i = 1:36

% vox = temp(49:72,:);
% for i = 1:24
    
    % distance for Razer
    vHHatX = vox(i,1) - maxXV;   
    vHHatY = vox(i,2) - maxYV;
    vHHatZ = vox(i,3) - maxZV;
    vHhatMag = abs(sqrt(vHHatX^2 + vHHatY^2 + vHHatZ^2));
 
    vHHat = [vHHatX vHHatY vHHatZ];
    vLDot = abs(dot(uHatV,vHHat));

    %rDist = sqrt((rHhatMag^2) - (rLDot^2));

    voxDistances(1,i) = sqrt((vHhatMag^2) - (vLDot^2));
end 
    
rSTD = std(razerDistances);
dSTD = std(deluxeDistances);
vSTD = std(voxDistances);
    
rPercent = (1 - (rSTD/(rSTD + dSTD + vSTD))) * 100;
dPercent = (1 - (dSTD/(rSTD + dSTD + vSTD))) * 100;
vPercent = (1 - (vSTD/(rSTD + dSTD + vSTD))) * 100;


ampProbabilities{1,j} = rPercent;
ampProbabilities{2,j} = dPercent;
ampProbabilities{3,j} = vPercent;
end


%% plot the lines of best overlaid with each of the filtered deconvolution
%PCAs
%      scatter3(temp(1:72,1),temp(1:72,2),temp(1:72,3),13,'mo');
%      hold on
%      scatter3(temp(73:144,1),temp(73:144,2),temp(73:144,3),13,'go');
%      scatter3(temp(145:216,1),temp(145:216,2),temp(145:216,3),13,'bo');
%      plot3(XlnR,YlnR,ZlnR,'m','LineWidth',5);
%      plot3(XlnD,YlnD,ZlnD,'g','LineWidth',5);
%      plot3(XlnV,YlnV,ZlnV,'b','LineWidth',5);
%      hold off


% % Create figure
% figure1 = figure('XVisual','');
% 
% % Create axes
% axes1 = axes('Parent',figure1);
% view(axes1,[-37.5 30]);
% grid(axes1,'on');
% hold(axes1,'all');
% 
% % Create scatter3
%  scatter3(temp(1:72,1),temp(1:72,2),temp(1:72,3),'Parent',axes1,...
%      'DisplayName','Raezer''s Edge Data Points');
% %scatter3(temp(1:36,1),temp(1:36,2),temp(1:36,3),'Parent',axes1,...
% %    'DisplayName','Raezer''s Edge Data Points');
% % scatter3(temp(1:24,1),temp(1:24,2),temp(1:24,3),'Parent',axes1,...
% %     'DisplayName','Raezer''s Edge Data Points');
% 
% % Create scatter3
% scatter3(temp(73:144,1),temp(73:144,2),temp(73:144,3),'Parent',axes1,...
%     'DisplayName','Fender Data Points');
% % scatter3(temp(37:72,1),temp(37:72,2),temp(37:72,3),'Parent',axes1,...
% %     'DisplayName','Fender Data Points');
% % scatter3(temp(25:48,1),temp(25:48,2),temp(25:48,3),'Parent',axes1,...
% %     'DisplayName','Fender Data Points');
% 
% 
% % Create scatter3
% scatter3(temp(145:216,1),temp(145:216,2),temp(145:216,3),'Parent',axes1,...
%     'DisplayName','Vox Data Points');
% % scatter3(temp(73:108,1),temp(73:108,2),temp(73:108,3),'Parent',axes1,...
% %     'DisplayName','Vox Data Points');
% % scatter3(temp(49:72,1),temp(49:72,2),temp(49:72,3),'Parent',axes1,...
% %     'DisplayName','Vox Data Points');
% 
% 
% % Create multiple lines using matrix input to plot3
% plot31 = plot3(XlnR,YlnR,ZlnR,'m','LineWidth',5);
% plot32 = plot3(XlnD,YlnD,ZlnD,'g','LineWidth',5);
% plot33 = plot3(XlnV,YlnV,ZlnV,'b','LineWidth',5);
% set(plot31(1),'Color',[0 0 1],'DisplayName','Best Fit Raezer''s Edge');
% set(plot32(1),'Color',[0 1 0],'DisplayName','Best Fit Fender');
% set(plot33(1),'Color',[1 0 1],'DisplayName','Best Fit Vox');
% 
% % Create title
% %title({'One Twelfth Octave Band Filtered Test Sample with Lines of Best Fit Overlaid'},...
% %    'FontSize',14);
% 
% % Create legend
% legend1 = legend(axes1,'show');
% set(legend1,...
%     'Position',[0.696015625 0.714884382955361 0.157421875 0.154717682020802]);




load('correct');
% append the correct amps into the testFileProbabilities
for j = 1:20
    ampProbabilities{4,j} = correct{j,1};
     
end


end


