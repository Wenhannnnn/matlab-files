% MATLAB 脚本: plot_rmse_histogram.m

% 加载保存的误差数据
load('error_data_off.mat', 'error_x_off');         % 加载控制关闭状态数据
load('error_data_on_nohat.mat', 'error_x_on_nohat'); % 加载控制开启（无帽）状态数据
load('error_data_on_5hat.mat', 'error_x_on_5hat');   % 加载控制开启（5倍面积限制）状态数据
load('error_data_on_20hat.mat', 'error_x_on_20hat'); % 加载控制开启（20倍面积限制）状态数据
load('error_data_on_200hat.mat', 'error_x_on_200hat'); % 加载控制开启（200倍面积限制）状态数据

% 计算均方根误差（RMSE）
rmse_off = sqrt(mean(error_x_off.^2));            % 计算控制关闭状态下的RMSE
rmse_on_nohat = sqrt(mean(error_x_on_nohat.^2));  % 计算控制开启（无帽）状态下的RMSE
rmse_on_5hat = sqrt(mean(error_x_on_5hat.^2));    % 计算控制开启（5倍面积限制）状态下的RMSE
rmse_on_20hat = sqrt(mean(error_x_on_20hat.^2));  % 计算控制开启（20倍面积限制）状态下的RMSE
rmse_on_200hat = sqrt(mean(error_x_on_200hat.^2));% 计算控制开启（200倍面积限制）状态下的RMSE

% 创建直方图数据，按照新的顺序排列
rmse_data = [rmse_off, rmse_on_5hat, rmse_on_20hat, rmse_on_200hat, rmse_on_nohat];  % 将RMSE值放入数组
labels = {'OFF', 'Limit x5', 'Limit x20', 'Limit x200', 'No Limit'};  % 简化后的X轴标签

% 绘制直方图
figure;
bar(rmse_data, 'FaceColor', [0.2, 0.6, 0.8]);  % 绘制直方图，设置颜色
set(gca, 'XTickLabel', labels, 'FontSize', 12, 'FontWeight', 'bold');  % 设置X轴标签
xtickangle(45);  % 设置X轴标签旋转角度为45度
ylabel('RMS Error', 'FontSize', 12, 'FontWeight', 'bold');  % Y轴标签
title('RMS Error Comparison', 'FontSize', 14, 'FontWeight', 'bold');  % 图表标题
grid on;  % 添加网格线

% 设置图表尺寸以优化PNG输出
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 8 4]);  % 设置图表的尺寸为8x4英寸
set(gcf, 'PaperSize', [8 4]);  % 设置PNG文件的页面大小与图表相同

% 保存为高质量PNG格式
print(gcf, 'RMSErrorComparison_selected.png', '-dpng', '-r300');  % 修改为PNG格式

% 关闭图形窗口（如果不再需要进一步编辑）
close(gcf);

% 计算on_nohat状态的RMSE是off状态RMSE的百分比（示例）
percentage_rmse_on_nohat = (rmse_on_nohat / rmse_off) * 100;

% 打印RMSE和百分比
fprintf('RMSE (Control OFF): %.4f\n', rmse_off);
fprintf('RMSE (Control ON 5hat): %.4f\n', rmse_on_5hat);
fprintf('RMSE (Control ON 20hat): %.4f\n', rmse_on_20hat);
fprintf('RMSE (Control ON 200hat): %.4f\n', rmse_on_200hat);
fprintf('RMSE (Control ON Nohat): %.4f\n', rmse_on_nohat);
fprintf('RMSE (Control ON Nohat) is %.2f%% of RMSE (Control OFF)\n', percentage_rmse_on_nohat);
