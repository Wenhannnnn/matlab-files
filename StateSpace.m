% Set parameters
m = 5; % Mass (kg)
T = 60; % Simulation time (s)

rho = 1.225; % Air density (kg/m^3)

Ax = 0.48; % Frontal area in x direction (m^2)
Ay = 0.8; % Frontal area in y direction (m^2)
Az = 0.6; % Frontal area in z direction (m^2)

Cd = 0.4; % Drag coefficient
g = 9.81; % Gravitational acceleration (m/s^2)

a = 1;
b = 0.6;
c = 0.8;

Ix = (1/12) * m * (b^2 + c^2);
Iy = (1/12) * m * (a^2 + c^2);
Iz = (1/12) * m * (a^2 + b^2);

L = 5;

K = 1.2;

r = 1;
% Load Simulink model
model = 'simulation01';
load_system(model);

% Get all Constant blocks in the model
constant_blocks = find_system(model, 'BlockType', 'Constant');

% Parameter value pairs
params = struct('m', m, 'T', T, 'rho', rho, 'Ax', Ax, 'Ay', Ay, 'Az', Az, ...
                'Cd', Cd, 'g', g, 'Ix', Ix, 'Iy', Iy, 'Iz', Iz, 'L', L);

% Set model parameters
param_names = fieldnames(params);
for i = 1:length(param_names)
    param_name = param_names{i};
    param_value = params.(param_name);
    % Find the Constant block with the matching name
    block_path = find_system(model, 'BlockType', 'Constant', 'Name', param_name);
    if ~isempty(block_path)
        set_param(block_path{1}, 'Value', num2str(param_value));
    else
        error(['Block ', param_name, ' not found in the model.']);
    end
end

% Run simulation
simOut = sim(model, 'StopTime', num2str(T));

% Extract simulation results
t = simOut.tout;
position_x = simOut.logsout.getElement('position_x').Values.Data;
position_y = simOut.logsout.getElement('position_y').Values.Data;
position_z = simOut.logsout.getElement('position_z').Values.Data;

% Plot motion status
figure;
subplot(3,1,1);
plot(t, position_x);
title('Position in X-axis');
xlabel('Time (s)');
ylabel('Position (m)');

subplot(3,1,2);
plot(t, position_y);
title('Position in Y-axis');
xlabel('Time (s)');
ylabel('Position (m)');

subplot(3,1,3);
plot(t, position_z);
title('Position in Z-axis');
xlabel('Time (s)');
ylabel('Position (m)');

% Save the plot as an image
saveas(gcf, 'payload_motion.png');
