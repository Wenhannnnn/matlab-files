% MATLAB 脚本: plot_rmse_histogram.m

% 加载保存的误差数据
load('error_data_on.mat', 'error_x_on');
load('error_data_off.mat', 'error_x_off');

% 计算均方根误差（RMSE）
rmse_off = sqrt(mean(error_x_off.^2));  % 计算控制关闭状态下的RMSE
rmse_on = sqrt(mean(error_x_on.^2));    % 计算控制开启状态下的RMSE

% 创建直方图数据
rmse_data = [rmse_off, rmse_on];  % 将两个RMSE值放入数组
labels = {'Control OFF', 'Control ON'};  % X轴标签

% 绘制直方图
figure;
bar(rmse_data, 'FaceColor', [0.2, 0.6, 0.8]);  % 绘制直方图，设置颜色
set(gca, 'XTickLabel', labels, 'FontSize', 12, 'FontWeight', 'bold');  % 设置X轴标签
ylabel('RMS Error', 'FontSize', 12, 'FontWeight', 'bold');  % Y轴标签
title('RMS Error Comparison: Control OFF vs ON', 'FontSize', 14, 'FontWeight', 'bold');  % 图表标题
grid on;  % 添加网格线

% 设置图表尺寸以优化PDF输出
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 6 4]);  % 设置图表的尺寸为6x4英寸
set(gcf, 'PaperSize', [6 4]);  % 设置PDF文件的页面大小与图表相同

% 保存为高质量矢量图PDF格式
print(gcf, 'RMSErrorComparison_hat.pdf', '-dpdf', '-r300');

% 关闭图形窗口（如果不再需要进一步编辑）
close(gcf);
