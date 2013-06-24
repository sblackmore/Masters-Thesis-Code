%% Fender IRs Measure Position
%% Fender Face Plane


figure(3)
clf(3)
grid on

% Fender Vertical View

% Build the Amp
line([-9, 9], [0 0], [0 0], 'LineWidth', 3, 'color', 'k')
line([-9, 9], [17.5 17.5], [0 0], 'LineWidth', 3, 'color', 'k')
line([-9, 9], [17.5 17.5], [16 16], 'LineWidth', 3, 'color', 'k')
line([-9, 9], [0 0], [16 16], 'LineWidth', 3, 'color', 'k')

line([-9, -9], [0 17.5], [0 0], 'LineWidth', 3, 'color', 'k')
line([9 9], [0 17.5], [0 0], 'LineWidth', 3, 'color', 'k')
line([-9, -9], [0 17.5], [16 16], 'LineWidth', 3, 'color', 'k')
line([9, 9], [0 17.5], [16 16], 'LineWidth', 3, 'color', 'k')


% Contruct the primary points measured
i = 1;
for z_ind = 0:2:36;
for x_ind = -29:2:29;
for y_ind = 0:2:24;

    
    % Define the amp's size
%     if max(x_ind == 0) 
%         % If within the amp... do not add a point
%     else
        %Otherwise add an x y z point
        x(i) = x_ind;
        y(i) = y_ind;
        z(i) = z_ind;
        i = i+1; 
%     end
    
end
end
end


figure(3)
hold on
scatter3(gca, x, y, z, '*');


set(get(gca,'YLabel'),'String','Height (Inches)',...
                    'FontSize',13)

set(get(gca,'XLabel'),'String','Distance (Inches)',...
                    'FontSize',13)
                
set(get(gca,'Title'),'String','Face View of Fender Measurements',...
                    'FontSize',13)
                
set(gca, 'XTick', -28:4:28, 'XTickLabel', {-28:4:28})
set(gca, 'YTick',  0:4:24, 'YTickLabel', {0:4:24})
set(0,'DefaultFigureColor','w')

axis equal
axis tight

drawnow


%% Vox IRs Measure Position

%% Vox Face Plane

figure(6)
clf(6)
grid on

% Vox Face View

% Build the Amp
line([-8, 8], [0 0], [0 0], 'LineWidth', 3, 'color', 'k')
line([-8, 8], [15 15], [0 0], 'LineWidth', 3, 'color', 'k')
line([-8, 8], [15 15], [16 16], 'LineWidth', 3, 'color', 'k')
line([-8, 8], [0 0], [16 16], 'LineWidth', 3, 'color', 'k')

line([-8, -8], [0 15], [0 0], 'LineWidth', 3, 'color', 'k')
line([8 8], [0 15], [0 0], 'LineWidth', 3, 'color', 'k')
line([-8, -8], [0 15], [16 16], 'LineWidth', 3, 'color', 'k')
line([8, 8], [0 15], [16 16], 'LineWidth', 3, 'color', 'k')




% Contruct the primary points measured
i = 1;
for z_ind = 0:2:36;
for x_ind = -29:2:29;
for y_ind = 0:2:24;

    
    % Define the amp's size
%     if max(x_ind == 0) 
%         % If within the amp... do not add a point
%     else
        %Otherwise add an x y z point
        x(i) = x_ind;
        y(i) = y_ind;
        z(i) = z_ind;
        i = i+1; 
%     end
    
end
end
end


figure(6)
hold on
scatter3(gca, x, y, z, '*');


set(get(gca,'YLabel'),'String','Height (Inches)',...
                    'FontSize',13)

set(get(gca,'XLabel'),'String','X (Inches)',...
                    'FontSize',13)
                
set(get(gca,'Title'),'String','Face View of Vox Measurements',...
                    'FontSize',13)
                
set(gca, 'XTick', -28:4:28, 'XTickLabel', {-28:4:28})
set(gca, 'YTick',  0:4:24, 'YTickLabel', {0:4:24})
set(0,'DefaultFigureColor','w')

axis equal
axis tight

drawnow


%% Raezer IRs Measure Position

%% Raezer Face Plane

figure(9)
clf(9)
grid on

% Raezer Face View

% Build the Amp
line([-8.5, 8.5], [0 0], [0 0], 'LineWidth', 3, 'color', 'k')
line([-8.5, 8.5], [18.5 18.5], [0 0], 'LineWidth', 3, 'color', 'k')
line([-8.5, 8.5], [18.5 18.5], [16 16], 'LineWidth', 3, 'color', 'k')
line([-8.5, 8.5], [0 0], [16 16], 'LineWidth', 3, 'color', 'k')

line([-8.5, -8.5], [0 18.5], [0 0], 'LineWidth', 3, 'color', 'k')
line([8.5 8.5], [0 18.5], [0 0], 'LineWidth', 3, 'color', 'k')
line([-8.5, -8.5], [0 18.5], [16 16], 'LineWidth', 3, 'color', 'k')
line([8.5, 8.5], [0 18.5], [16 16], 'LineWidth', 3, 'color', 'k')




% Contruct the primary points measured
i = 1;
for z_ind = 0:2:36;
for x_ind = -29:2:29;
for y_ind = 0:2:24;

    
    % Define the amp's size
%     if max(x_ind == 0) 
%         % If within the amp... do not add a point
%     else
        %Otherwise add an x y z point
        x(i) = x_ind;
        y(i) = y_ind;
        z(i) = z_ind;
        i = i+1; 
%     end
    
end
end
end


figure(9)
hold on
scatter3(gca, x, y, z, '*');


set(get(gca,'YLabel'),'String','Height (Inches)',...
                    'FontSize',13)

set(get(gca,'XLabel'),'String','X (Inches)',...
                    'FontSize',13)
                
set(get(gca,'Title'),'String','Face View of Raezer Measurements',...
                    'FontSize',13)
                
set(gca, 'XTick', -28:4:28, 'XTickLabel', {-28:4:28})
set(gca, 'YTick',  0:4:24, 'YTickLabel', {0:4:24})
set(0,'DefaultFigureColor','w')

axis equal
axis tight

drawnow

 

 
