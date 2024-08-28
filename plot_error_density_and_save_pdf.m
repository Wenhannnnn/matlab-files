% MATLAB 脚本: plot_error_density_and_save_pdf.m

% 加载保存的误差数据
load('error_data_on.mat', 'error_x_on');
load('error_data_off.mat', 'error_x_off');

% 设置带宽
bandwidth_on = 0.1;   % 控制开启状态（on）的带宽
bandwidth_off = 0.2;  % 控制关闭状态（off）的带宽，设置更大以使曲线更平滑

% 计算和绘制误差的核密度估计（KDE）
figure;

% 控制关闭状态（off）时的密度估计
[f_off, xi_off] = ksdensity(error_x_off, 'Bandwidth', bandwidth_off);
plot(xi_off, f_off, 'LineWidth', 2, 'LineStyle', '-');  % 实线
hold on;  % 保持当前图

% 控制开启状态（on）时的密度估计
[f_on, xi_on] = ksdensity(error_x_on, 'Bandwidth', bandwidth_on);
plot(xi_on, f_on, 'LineWidth', 2, 'LineStyle', '--');  % 虚线

% 优化图表外观
xlabel('Error Value', 'FontSize', 12, 'FontWeight', 'bold');  % x轴标签
ylabel('Density', 'FontSize', 12, 'FontWeight', 'bold');      % y轴标签
title('Error Density Estimation: Control OFF vs ON', 'FontSize', 14, 'FontWeight', 'bold');  % 图表标题
legend('Control OFF', 'Control ON', 'FontSize', 12, 'Location', 'Best');  % 图例
set(gca, 'LineWidth', 1.5, 'FontSize', 12);  % 设置坐标轴线宽和字体大小
grid on;  % 添加网格线

% 确保图表填充页面
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 6 4]);  % 设置图表的尺寸为6x4英寸
set(gcf, 'PaperSize', [6 4]);  % 设置PDF文件的页面大小与图表相同

% 保存为高质量矢量图PDF格式
print(gcf, 'ErrorDensityEstimation_hat.pdf', '-dpdf', '-r300');

% 关闭图形窗口（如果不再需要进一步编辑）
close(gcf);
