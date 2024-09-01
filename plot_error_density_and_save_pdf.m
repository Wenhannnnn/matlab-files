% MATLAB 脚本: plot_error_density_and_save_pdf.m

% 加载保存的误差数据
load('error_data_off.mat', 'error_x_off');          % 加载 error_x_off 数据
load('error_data_on_5hat.mat', 'error_x_on_5hat');  % 加载 error_x_on_5hat 数据
load('error_data_on_20hat.mat', 'error_x_on_20hat'); % 加载 error_x_on_20hat 数据
load('error_data_on_200hat.mat', 'error_x_on_200hat'); % 加载 error_x_on_200hat 数据
load('error_data_on_nohat.mat', 'error_x_on_nohat');  % 加载 error_x_on_nohat 数据

% 设置带宽
bandwidth_off = 0.2;     % 控制 error_x_off 的带宽，增大以更平滑
bandwidth_on_5hat = 0.1; % 控制 error_x_on_5hat 的带宽
bandwidth_on_20hat = 0.1;% 控制 error_x_on_20hat 的带宽
bandwidth_on_200hat = 0.1;% 控制 error_x_on_200hat 的带宽
bandwidth_on_nohat = 0.1;% 控制 error_x_on_nohat 的带宽

% 计算和绘制误差的核密度估计（KDE）
figure;

% 使用 error_data_off 数据集的密度估计
[f_off, xi_off] = ksdensity(error_x_off, 'Bandwidth', bandwidth_off);
plot(xi_off, f_off, 'LineWidth', 2, 'LineStyle', '-');  % 实线
hold on;  % 保持当前图以便叠加其他曲线

% 使用 error_data_on_5hat 数据集的密度估计
[f_on_5hat, xi_on_5hat] = ksdensity(error_x_on_5hat, 'Bandwidth', bandwidth_on_5hat);
plot(xi_on_5hat, f_on_5hat, 'LineWidth', 2, 'LineStyle', '--');  % 虚线

% 使用 error_data_on_20hat 数据集的密度估计
[f_on_20hat, xi_on_20hat] = ksdensity(error_x_on_20hat, 'Bandwidth', bandwidth_on_20hat);
plot(xi_on_20hat, f_on_20hat, 'LineWidth', 2, 'LineStyle', ':');  % 点线

% 使用 error_data_on_200hat 数据集的密度估计
[f_on_200hat, xi_on_200hat] = ksdensity(error_x_on_200hat, 'Bandwidth', bandwidth_on_200hat);
plot(xi_on_200hat, f_on_200hat, 'LineWidth', 2, 'LineStyle', '-.');  % 点划线

% 使用 error_data_on_nohat 数据集的密度估计
[f_on_nohat, xi_on_nohat] = ksdensity(error_x_on_nohat, 'Bandwidth', bandwidth_on_nohat);
plot(xi_on_nohat, f_on_nohat, 'LineWidth', 2, 'LineStyle', '-');  % 实线

% 优化图表外观
xlabel('Error Value', 'FontSize', 12, 'FontWeight', 'bold');  % x轴标签
ylabel('Density', 'FontSize', 12, 'FontWeight', 'bold');      % y轴标签
title('Error Density Estimation: Various Control Conditions', 'FontSize', 14, 'FontWeight', 'bold');  % 图表标题
legend('Control OFF', 'Limit x5', 'Limit x20', 'Limit x200', 'No Limit', 'FontSize', 12, 'Location', 'northeastoutside');  % 调整图例位置至图形外部
set(gca, 'LineWidth', 1.5, 'FontSize', 12);  % 设置坐标轴线宽和字体大小
grid on;  % 添加网格线

% 确保图表填充页面
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 8 4]);  % 设置图表的尺寸为8x4英寸
set(gcf, 'PaperSize', [8 4]);  % 设置PNG文件的页面大小与图表相同

% 保存为高质量矢量图PNG格式
print(gcf, 'ErrorDensityEstimation_selected.png', '-dpng', '-r300');  % 修改为PNG格式

% 关闭图形窗口（如果不再需要进一步编辑）
close(gcf);

% 计算方差
var_off = var(error_x_off);
var_on_5hat = var(error_x_on_5hat);
var_on_20hat = var(error_x_on_20hat);
var_on_200hat = var(error_x_on_200hat);
var_on_nohat = var(error_x_on_nohat);

% 打印方差
fprintf('Variance (Control OFF): %.4f\n', var_off);
fprintf('Variance (Control ON 5hat): %.4f\n', var_on_5hat);
fprintf('Variance (Control ON 20hat): %.4f\n', var_on_20hat);
fprintf('Variance (Control ON 200hat): %.4f\n', var_on_200hat);
fprintf('Variance (Control ON Nohat): %.4f\n', var_on_nohat);
