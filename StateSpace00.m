% 参数设置
m = 5; % 质量 (kg)
T = 60; % 时间 (s)
theta1 = 0.5; % 初始角度1 (rad)
theta2 = 0.6; % 初始角度2 (rad)
rho = 1.225; % 空气密度 (kg/m^3)
Ax = 0.3; % 迎风面积x (m^2)
Ay = 0.2; % 迎风面积y (m^2)
Az = 0.1; % 迎风面积z (m^2)
Cd = 0.4; % 阻力系数
g = 9.8; % 重力加速度 (m/s^2)
Ix = 10; % 转动惯量x
Iy = 20; % 转动惯量y
Iz = 30; % 转动惯量z

% 初始条件
Xp = 0; Yp = 0; Zp = -1; % 初始位置 (m)
u0 = 0; v0 = 0; w0 = 0; % 初始速度 (m/s)
p0 = 0; q0 = 0; r0 = 0; % 初始角速度 (rad/s)

% 时间跨度
tspan = [0 10];

% 运动方程
pendulum_ode = @(t, y) dynamics(t, y, m, g, rho, Ax, Ay, Az, Cd, Ix, Iy, Iz);

% 初始状态
initial_conditions = [Xp; Yp; Zp; u0; v0; w0; p0; q0; r0];

% 求解微分方程
[t, y] = ode45(pendulum_ode, tspan, initial_conditions);

% 可视化
figure;
for k = 1:length(t)
    clf;
    hold on;
    % 绘制固定点 (无人机)
    plot3(0, 0, 0, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
    % 绘制长方体刚体 (简化为点)
    plot3(y(k,1), y(k,2), y(k,3), 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
    % 绘制绳索
    plot3([0 y(k,1)], [0 y(k,2)], [0 y(k,3)], 'r-', 'LineWidth', 2);
    % 设置坐标轴范围和标签
    axis equal;
    xlim([-1, 1]);
    ylim([-1, 1]);
    zlim([-2, 0]);
    xlabel('X (米)');
    ylabel('Y (米)');
    zlabel('Z (米)');
    title(sprintf('悬挂刚体仿真: t = %.2f 秒', t(k)));
    drawnow;
    pause(0.01);
end

function dydt = dynamics(t, y, m, g, rho, Ax, Ay, Az, Cd, Ix, Iy, Iz)
    % 提取状态变量
    Xp = y(1);
    Yp = y(2);
    Zp = y(3);
    u = y(4);
    v = y(5);
    w = y(6);
    p = y(7);
    q = y(8);
    r = y(9);
    
    % 计算张力T
    T = sqrt((Xp - 0)^2 + (Yp - 0)^2 + (Zp + 1)^2) * m * g; % 简化张力计算
    
    % 重力在body frame中的分量
    Fg = m * g * [0; 0; -1];
    
    % 阻力在body frame中的分量
    V_body = [u; v; w];
    A_body = [Ax; Ay; Az];
    Drag = 0.5 * rho * Cd * (V_body.^2) .* A_body;
    
    % 合力和力矩计算
    F_body = Fg - Drag;
    T_body = [T; 0; 0]; % 简化张力力矩计算
    
    % 计算加速度和角加速度
    accel_body = F_body / m;
    ang_accel_body = T_body ./ [Ix; Iy; Iz];
    
    % 转换到地球坐标系
    R = eul2rotm([p q r]); % 欧拉角到旋转矩阵
    accel_earth = R * accel_body;
    ang_accel_earth = R * ang_accel_body;
    
    % 状态微分
    dydt = [u; v; w; accel_earth; p; q; r; ang_accel_earth];
end
