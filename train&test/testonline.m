%% 测试模型程序
%利用训练好的分类模型对未知数据进行预测
%% 数据准备
model=libsvmload('copymodel.model',27);% 加载分类模型
load('rule.mat');%加载归一化规则
% % 导入xls数据，保存为mat文件
% test=xlsread('test1');%new1-5
% save new.mat new;
load('moni.mat');
%% 预处理
[delete,m1,m2,m3]=p_mean(monitor);% 去偏置
% delete(:,1)=test(:,1);
% delete(:,2)=test(:,2)+0.1789;
% delete(:,3)=test(:,3)+0.2053;
% delete(:,4)=test(:,4)+0.2047;
out=p_outlier(delete);% 去野值
filt=p_50hz(out);% 陷波
filted=p_butter(filt);% 滤波

figure(1)
plot(delete(:,2));
hold on;
grid on;
%% 特征提取+分类识别
%采用滑动窗思想，截取一段时间窗length_t,滑动窗大小delta_t,单位ms
length_t=100;
delta_t=20;
m=1; % 决策次数
result=[]; % 决策矩阵
tic
for i=1:delta_t:size(filted,1)
    % 跳出循环条件
    if i+length_t>size(filted,1)
        break;
    end
      
    % 取时间窗
    win= filted(i:i+length_t,:);
    
    % 阈值处理
    datadetect=f_detect(filted(i:i+length_t,:));% 将低于活动段阈值的数据置零
    b=(datadetect==0);
    zeronum=sum(b(:));% 置零项个数
    zeroratio=zeronum/length_t;%置零项比例
    
    %判断处于活动段范围
    if zeroratio < 0.4000
 
        plot(i,0,'r+');%绘制活动段采样点
        
        feature=f_feature(win,0);% 特征提取
        
        F=c_normal_rule(feature,rule); % 数据归一化
        
        %将特征矩阵转换成libsvm可识别的格式
        instance=sparse(F(1,1:27));
        lab=F(1,28);
        libsvmwrite('emgtest3',lab, instance);
        
        % 对活动段分类预测
        [label, data] = libsvmread('emgtest3');% 读取数据
        predict = libsvmpredict(label,data,model);% 数据分类
        result(m)=predict;
        
    else
        % 对静息段直接置零
        result(m)=0;
    end
    m=m+1;
end
%% 结果输出

figure(3)
t=(1:20:20*length(result));% 设置x轴步长
stairs(t,result,'r.','markersize',20);
set(gca,'ytick',0:1:6);% 设置y轴步长
title('Predict Result');
grid on;
