load('testFilePCAScores12th');
temp = testFilePCAScores12th{3,1};

% plot a best fit line for each of the three amps from the test file pca
% data


[mR,pR,sR] = best_fit_line(temp(1:72,1),temp(1:72,2),temp(1:72,3));
[mD,pD,sD] = best_fit_line(temp(73:144,1),temp(73:144,2),temp(73:144,3));
[mV,pV,sV] = best_fit_line(temp(145:216,1),temp(145:216,2),temp(145:216,3));



% get get the mins

% %%Razer
minXR = min(temp(1:72,1));
minYR = minXR*pR(2)/pR(1) - mR(1)*pR(2)/pR(1) + mR(2);
minZR = minXR*pR(3)/pR(1) - mR(1)*pR(3)/pR(1) + mR(3);

% get the maxes
maxXR = max(temp(1:72,1));
maxYR = maxXR*pR(2)/pR(1) - mR(1)*pR(2)/pR(1) + mR(2);
maxZR = maxXR*pR(3)/pR(1) - mR(1)*pR(3)/pR(1) + mR(3);

% use the min/max to create a set of points for 3D line
XlnR = [minXR maxXR];
YlnR = [minYR maxYR];
ZlnR = [minZR maxZR];


%%Deluxe
minXD = min(temp(73:144,1));
minYD = minXD*pD(2)/pD(1) - mD(1)*pD(2)/pD(1) + mD(2);
minZD = minXD*pD(3)/pD(1) - mD(1)*pD(3)/pD(1) + mD(3);

% get the maxes
maxXD = max(temp(73:144,1));
maxYD = maxXD*pD(2)/pD(1) - mD(1)*pD(2)/pD(1) + mD(2);
maxZD = maxXD*pD(3)/pD(1) - mD(1)*pD(3)/pD(1) + mD(3);

% use the min/max to create a set of points for 3D line
XlnD = [minXD maxXD];
YlnD = [minYD maxYD];
ZlnD = [minZD maxZD];



%%Vox
minXV = min(temp(145:216,1));
minYV = minXV*pV(2)/pV(1) - mV(1)*pV(2)/pV(1) + mV(2);
minZV = minXV*pV(3)/pV(1) - mV(1)*pV(3)/pV(1) + mV(3);

% get the maxes
maxXV = max(temp(145:216,1));
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
 razerDistances = zeros(1,72);   

% need to loop through all Razer values from the test data PCA
razer = temp(1:72,:);
for i = 1:72
    
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
 deluxeDistances = zeros(1,72);   

% need to loop through all Razer values from the test data PCA
deluxe = temp(73:144,:);
for i = 1:72
    
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
 voxDistances = zeros(1,72);   

% need to loop through all Razer values from the test data PCA
vox = temp(145:216,:);
for i = 1:72
    
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
    
    
    







