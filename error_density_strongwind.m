% MATLAB 脚本: plot_error_density_and_save_pdf.m

% 加载保存的误差数据
load('error_data_off_strongwind.mat', 'error_x_off_strongwind');  % 加载 error_x_off_strongwind 数据
load('error_data_on_500hat_strongwind.mat', 'error_x_on_500hat_strongwind');    % 加载 error_x_on_500hat_strongwind 数据
load('error_data_on_5hat_strongwind.mat', 'error_x_on_5hat_strongwind');  % 加载 error_x_on_5hat_strongwind 数据

% 设置带宽
bandwidth_off_strongwind = 0.5;             % 控制 error_x_off_strongwind 的带宽
bandwidth_on_500hat_strongwind = 0.3;       % 控制 error_x_on_500hat_strongwind 的带宽
bandwidth_on_5hat_strongwind = 0.3;         % 控制 error_x_on_5hat_strongwind 的带宽

% 计算和绘制误差的核密度估计（KDE）
figure;

% 使用 error_data_off_strongwind 数据集的密度估计
[f_off_strongwind, xi_off_strongwind] = ksdensity(error_x_off_strongwind, 'Bandwidth', bandwidth_off_strongwind);
plot(xi_off_strongwind, f_off_strongwind, 'LineWidth', 2, 'LineStyle', '-');  % 实线
hold on;  % 保持当前图以便叠加其他曲线

% 使用 error_data_on_500hat_strongwind 数据集的密度估计
[f_on_500hat_strongwind, xi_on_500hat_strongwind] = ksdensity(error_x_on_500hat_strongwind, 'Bandwidth', bandwidth_on_500hat_strongwind);
plot(xi_on_500hat_strongwind, f_on_500hat_strongwind, 'LineWidth', 2, 'LineStyle', '--');  % 虚线

% 使用 error_data_on_5hat_strongwind 数据集的密度估计
[f_on_5hat_strongwind, xi_on_5hat_strongwind] = ksdensity(error_x_on_5hat_strongwind, 'Bandwidth', bandwidth_on_5hat_strongwind);
plot(xi_on_5hat_strongwind, f_on_5hat_strongwind, 'LineWidth', 2, 'LineStyle', ':');  % 点线

% 优化图表外观
xlabel('Error Value', 'FontSize', 12, 'FontWeight', 'bold');  % x轴标签
ylabel('Density', 'FontSize', 12, 'FontWeight', 'bold');      % y轴标签
title('Error Density Estimation: Strong Wind Conditions', 'FontSize', 14, 'FontWeight', 'bold');  % 图表标题

% 修改图例标注并确保显示
legend({'Off', 'No Limit', 'Limit x5'}, 'FontSize', 12, 'Location', 'best');  % 使用花括号确保图例显示，位置设置为最佳

set(gca, 'LineWidth', 1.5, 'FontSize', 12);  % 设置坐标轴线宽和字体大小
grid on;  % 添加网格线

% 确保图表填充页面
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 8 4]);  % 设置图表的尺寸为8x4英寸
set(gcf, 'PaperSize', [8 4]);  % 设置PNG文件的页面大小与图表相同

% 保存为高质量PNG格式
print(gcf, 'ErrorDensityEstimation_strongwind_5hat_500hat.png', '-dpng', '-r300');  % 修改为PNG格式

% 计算方差
var_off_strongwind = var(error_x_off_strongwind);
var_on_500hat_strongwind = var(error_x_on_500hat_strongwind);
var_on_5hat_strongwind = var(error_x_on_5hat_strongwind);

% 打印方差
fprintf('Variance (Off Strong Wind): %.4f\n', var_off_strongwind);
fprintf('Variance (Limit x500): %.4f\n', var_on_500hat_strongwind);
fprintf('Variance (Limit x5): %.4f\n', var_on_5hat_strongwind);
