% MATLAB 脚本: plot_rmse_histogram.m

% 加载保存的误差数据
load('error_data_off_strongwind.mat', 'error_x_off_strongwind');  % 加载控制关闭（强风条件）状态数据
load('error_data_on_5hat_strongwind.mat', 'error_x_on_5hat_strongwind');  % 加载控制开启（5倍面积限制，强风条件）状态数据
load('error_data_on_500hat_strongwind.mat', 'error_x_on_500hat_strongwind');    % 加载控制开启（500倍面积限制，强风条件）状态数据

% 计算均方根误差（RMSE）
rmse_off_strongwind = sqrt(mean(error_x_off_strongwind.^2));   % 计算控制关闭（强风条件）状态下的RMSE
rmse_on_5hat_strongwind = sqrt(mean(error_x_on_5hat_strongwind.^2)); % 计算控制开启（5倍面积限制，强风条件）状态下的RMSE
rmse_on_500hat_strongwind = sqrt(mean(error_x_on_500hat_strongwind.^2));     % 计算控制开启（500倍面积限制，强风条件）状态下的RMSE

% 创建直方图数据，调整顺序以确保5hat在中间
rmse_data = [rmse_off_strongwind, rmse_on_5hat_strongwind, rmse_on_500hat_strongwind];  % 将RMSE值放入数组
labels = {'Off', 'Limit x5', 'No Limit'};  % 更新后的X轴标签

% 绘制直方图
figure;
bar(rmse_data, 'FaceColor', [0.2, 0.6, 0.8]);  % 绘制直方图，设置颜色
set(gca, 'XTickLabel', labels, 'FontSize', 12, 'FontWeight', 'bold');  % 设置X轴标签
xtickangle(45);  % 设置X轴标签旋转角度为45度
ylabel('RMS Error', 'FontSize', 12, 'FontWeight', 'bold');  % Y轴标签
title('RMS Error Comparison: Strong Wind Conditions', 'FontSize', 14, 'FontWeight', 'bold');  % 图表标题
grid on;  % 添加网格线

% 设置图表尺寸以优化PNG输出
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 8 4]);  % 设置图表的尺寸为8x4英寸
set(gcf, 'PaperSize', [8 4]);  % 设置PNG文件的页面大小与图表相同

% 保存为高质量PNG格式
print(gcf, 'RMSErrorComparison_strongwind_limit_x5_x500.png', '-dpng', '-r300');  % 修改为PNG格式

% 关闭图形窗口（如果不再需要进一步编辑）


% 计算on_500hat_strongwind状态的RMSE是off_strongwind状态RMSE的百分比
percentage_rmse_on_500hat_strongwind = (rmse_on_500hat_strongwind / rmse_off_strongwind) * 100;

% 打印RMSE和百分比
fprintf('RMSE (Off Strong Wind): %.4f\n', rmse_off_strongwind);
fprintf('RMSE (Limit x5): %.4f\n', rmse_on_5hat_strongwind);
fprintf('RMSE (Limit x500): %.4f\n', rmse_on_500hat_strongwind);
fprintf('RMSE (Limit x500) is %.2f%% of RMSE (Off Strong Wind)\n', percentage_rmse_on_500hat_strongwind);
