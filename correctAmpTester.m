
% create a vector to hold the correct amps from the 20 test files
correct = cell(20,1);


for i = 1:20
    eval(['load(''input' num2str(i) ''');']); 
    eval(['load(''convResult' num2str(i) ''');']); 
    
    eval(['[rCorrect' num2str(i) ',dCorrect' num2str(i) ',vCorrect'...
        num2str(i) '] = deconvolver(convResult' num2str(i) ');']);
    
    eval(['rTemp = rCorrect' num2str(i) '{4,4};']);
    eval(['dTemp = dCorrect' num2str(i) '{4,4};']);
	eval(['vTemp = vCorrect' num2str(i) '{4,4};']);
    
    eval(['r = sum(abs(rTemp - input' num2str(i) '));']);
    eval(['d = sum(abs(dTemp - input' num2str(i) '));']);
    eval(['v = sum(abs(vTemp - input' num2str(i) '));']);
    
    resultsSumming = [r;d;v];
    [~,correctAmp] = min(resultsSumming);
    
    
    if correctAmp == 1
        correct{i,1} = 'Raezer''s Edge';
    elseif correctAmp == 2 
        correct{i,1} = 'Fender Deluxe';
    else
        correct{i,1} = 'Vox Valvetronix';
    end
end



%load('input1');





%load('convResult1');

%[rCorrect1,dCorrect1,vCorrect1] = deconvolver(convResult1);

% just select the middle capsule since for the correct amp, the input
% should be basically back to the original at all capsules
% rTemp = rCorrect1{4,4};
% dTemp = dCorrect1{4,4};
% vTemp = vCorrect1{4,4};

% the correct amplifier should be very close to zero.  Sum this result and
% find the minimum
% r = sum(abs(rTemp - input1));
% d = sum(abs(dTemp - input1));
% v = sum(abs(vTemp - input1));

%resultsSumming = [r;d;v];

%[~,correctAmp] = min(resultsSumming);

% if correctAmp == 1
%     correct = 'Raezer''s Edge';
% elseif correctAmp == 2 
%     correct = 'Fender Deluxe';
% else
%     correct = 'Vox Valvetronix';
% end