% MATLAB 脚本: plot_error_density_and_save_pdf.m

% 加载保存的误差数据
load('error_data_off_middlewind.mat', 'error_x_off_middlewind');  % 加载 error_x_off_middlewind 数据
load('error_data_on_middlewind.mat', 'error_x_on_middlewind');    % 加载 error_x_on_middlewind 数据
load('error_data_on_5hat_middlewind.mat', 'error_x_on_5hat_middlewind');  % 加载 error_x_on_5hat_middlewind 数据

% 设置带宽
bandwidth_off_middlewind = 0.2;       % 控制 error_x_off_middlewind 的带宽
bandwidth_on_middlewind = 0.1;        % 控制 error_x_on_middlewind 的带宽
bandwidth_on_5hat_middlewind = 0.1;   % 控制 error_x_on_5hat_middlewind 的带宽

% 计算和绘制误差的核密度估计（KDE）
figure;

% 使用 error_data_off_middlewind 数据集的密度估计
[f_off_middlewind, xi_off_middlewind] = ksdensity(error_x_off_middlewind, 'Bandwidth', bandwidth_off_middlewind);
plot(xi_off_middlewind, f_off_middlewind, 'LineWidth', 2, 'LineStyle', '-');  % 实线
hold on;  % 保持当前图以便叠加其他曲线

% 使用 error_data_on_middlewind 数据集的密度估计
[f_on_middlewind, xi_on_middlewind] = ksdensity(error_x_on_middlewind, 'Bandwidth', bandwidth_on_middlewind);
plot(xi_on_middlewind, f_on_middlewind, 'LineWidth', 2, 'LineStyle', '--');  % 虚线

% 使用 error_data_on_5hat_middlewind 数据集的密度估计
[f_on_5hat_middlewind, xi_on_5hat_middlewind] = ksdensity(error_x_on_5hat_middlewind, 'Bandwidth', bandwidth_on_5hat_middlewind);
plot(xi_on_5hat_middlewind, f_on_5hat_middlewind, 'LineWidth', 2, 'LineStyle', ':');  % 点线

% 优化图表外观
xlabel('Error Value', 'FontSize', 12, 'FontWeight', 'bold');  % x轴标签
ylabel('Density', 'FontSize', 12, 'FontWeight', 'bold');      % y轴标签
title('Error Density Estimation: Middle Wind Conditions', 'FontSize', 14, 'FontWeight', 'bold');  % 图表标题
legend('Off Middle Wind', 'On Middle Wind', 'Limit x5', 'FontSize', 12, 'Location', 'northeastoutside');  % 调整图例位置至图形外部
set(gca, 'LineWidth', 1.5, 'FontSize', 12);  % 设置坐标轴线宽和字体大小
grid on;  % 添加网格线

% 确保图表填充页面
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 8 4]);  % 设置图表的尺寸为8x4英寸
set(gcf, 'PaperSize', [8 4]);  % 设置PNG文件的页面大小与图表相同

% 保存为高质量PNG格式
print(gcf, 'ErrorDensityEstimation_middlewind_5hat.png', '-dpng', '-r300');  % 修改为PNG格式

% 关闭图形窗口（如果不再需要进一步编辑）
close(gcf);

% 计算方差
var_off_middlewind = var(error_x_off_middlewind);
var_on_middlewind = var(error_x_on_middlewind);
var_on_5hat_middlewind = var(error_x_on_5hat_middlewind);

% 打印方差
fprintf('Variance (Off Middle Wind): %.4f\n', var_off_middlewind);
fprintf('Variance (On Middle Wind): %.4f\n', var_on_middlewind);
fprintf('Variance (Limit x5): %.4f\n', var_on_5hat_middlewind);
