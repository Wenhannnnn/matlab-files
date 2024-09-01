% MATLAB 脚本: plot_rmse_histogram.m

% 加载保存的误差数据
load('error_data_off_middlewind.mat', 'error_x_off_middlewind');  % 加载控制关闭（中风条件）状态数据
load('error_data_on_5hat_middlewind.mat', 'error_x_on_5hat_middlewind');  % 加载控制开启（5倍面积限制，中风条件）状态数据
load('error_data_on_middlewind.mat', 'error_x_on_middlewind');    % 加载控制开启（中风条件）状态数据

% 计算均方根误差（RMSE）
rmse_off_middlewind = sqrt(mean(error_x_off_middlewind.^2));   % 计算控制关闭（中风条件）状态下的RMSE
rmse_on_5hat_middlewind = sqrt(mean(error_x_on_5hat_middlewind.^2)); % 计算控制开启（5倍面积限制，中风条件）状态下的RMSE
rmse_on_middlewind = sqrt(mean(error_x_on_middlewind.^2));     % 计算控制开启（中风条件）状态下的RMSE

% 创建直方图数据，调整顺序以确保5hat在中间
rmse_data = [rmse_off_middlewind, rmse_on_5hat_middlewind, rmse_on_middlewind];  % 将RMSE值放入数组
labels = {'Off Middle Wind', 'Limit x5', 'On Middle Wind'};  % 更新后的X轴标签

% 绘制直方图
figure;
bar(rmse_data, 'FaceColor', [0.2, 0.6, 0.8]);  % 绘制直方图，设置颜色
set(gca, 'XTickLabel', labels, 'FontSize', 12, 'FontWeight', 'bold');  % 设置X轴标签
xtickangle(45);  % 设置X轴标签旋转角度为45度
ylabel('RMS Error', 'FontSize', 12, 'FontWeight', 'bold');  % Y轴标签
title('RMS Error Comparison: Middle Wind Conditions', 'FontSize', 14, 'FontWeight', 'bold');  % 图表标题
grid on;  % 添加网格线

% 设置图表尺寸以优化PNG输出
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 8 4]);  % 设置图表的尺寸为8x4英寸
set(gcf, 'PaperSize', [8 4]);  % 设置PNG文件的页面大小与图表相同

% 保存为高质量PNG格式
print(gcf, 'RMSErrorComparison_middlewind_limit_x5.png', '-dpng', '-r300');  % 修改为PNG格式

% 关闭图形窗口（如果不再需要进一步编辑）
close(gcf);

% 计算on_middlewind状态的RMSE是off_middlewind状态RMSE的百分比
percentage_rmse_on_middlewind = (rmse_on_middlewind / rmse_off_middlewind) * 100;

% 打印RMSE和百分比
fprintf('RMSE (Off Middle Wind): %.4f\n', rmse_off_middlewind);
fprintf('RMSE (Limit x5): %.4f\n', rmse_on_5hat_middlewind);
fprintf('RMSE (On Middle Wind): %.4f\n', rmse_on_middlewind);
fprintf('RMSE (On Middle Wind) is %.2f%% of RMSE (Off Middle Wind)\n', percentage_rmse_on_middlewind);

