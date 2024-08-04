% Run the simulation
sim('simulation01.slx', 'StopTime', '6'); 

if isstruct(pp_data)
    % Extract time and data
    time = pp_data.time;
    pp = pp_data.signals.values;  % Assume pp is a three-column matrix [xp; yp; zp]
else
    % If the data format is an array, use it directly
    pp = pp_data;
    time = 1:size(pp, 1);  % Time vector can be replaced with index
end

% Plot the 3D trajectory
figure;
plot3(pp(:,1), pp(:,2), pp(:,3), 'b-o');
xlabel('X (meters)');
ylabel('Y (meters)');
zlabel('Z (meters)');
title('3D Position Trajectory');
grid on;
axis equal;
