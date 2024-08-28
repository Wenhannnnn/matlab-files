% Read simulation output data
data = out.pp_data;  % Get simulation data structure with time
time = data.time;    % Extract time data
values = data.signals.values;  % Extract coordinate values

% Confirm that coordinates are three-dimensional
x = values(:, 1);  % Extract x coordinates
y = values(:, 2);  % Extract y coordinates
z = values(:, 3);  % Extract z coordinates

% Create a new figure window
figure;
hold on;
grid on;
axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Trajectory of the Object');

% Ensure 3D display
view(3);

% Plot the hanging point (origin)
originHandle = plot3(0, 0, 0, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');  % Origin

% Plot the trajectory of the object
trajectoryHandle = plot3(x(1), y(1), z(1), 'b-', 'LineWidth', 1.5);  % Initial trajectory

% Plot the current position of the object
currentPosHandle = plot3(x(1), y(1), z(1), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g'); % Current position of the object

% Plot the hanging line connecting the origin to the object's position
lineHandle = plot3([0, x(1)], [0, y(1)], [0, z(1)], 'k-', 'LineWidth', 2);  % Connecting line

% Set axis limits
xlim([min(x)-0.1, max(x)+0.1]);
ylim([min(y)-0.1, max(y)+0.1]);
zlim([-10, 1]);

% Animation effect, strictly following coordinate values
updateInterval = 10; % Update every 1000 time steps
for i = 1:updateInterval:length(time)
    % Update the object's trajectory line
    set(trajectoryHandle, 'XData', x(1:i), 'YData', y(1:i), 'ZData', z(1:i));
    
    % Update the current position of the object
    set(currentPosHandle, 'XData', x(i), 'YData', y(i), 'ZData', z(i));
    
    % Update the hanging line
    set(lineHandle, 'XData', [0, x(i)], 'YData', [0, y(i)], 'ZData', [0, z(i)]);
    
    % Update the title
    title(sprintf('Object Movement Time: %.2f seconds', time(i)));
    
    % Force the figure to update
    drawnow;
end

