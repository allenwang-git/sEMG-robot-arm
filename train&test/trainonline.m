%% 训练模型程序
% 使用有标签的原始数据文件raw.mat训练模型，生成模型文件copymodel，归一化规则文件rule.mat

%% 数据准备
% % 导入xls数据，保存为mat文件
% test=xlsread('test1');%new1-5
% save new.mat new;
load('raw.mat');

%% 预处理
delete=p_mean(raw);% 去偏置
out=p_outlier(delete);% 去野值
filt=p_50hz(out);% 陷波
filted=p_butter(filt);% 滤波

%% 特征提取
labels = unique(filted(:,5));% 提取类别标签labels=[1,2,3,4,5]
label=filted(:,5);
for c=1:5 % 分5类提取特征
    num = find(label == labels(c));% 第c类所有数据序号1-39398
  
    figure(c)
    plot(filted(num(1):num(size(num),1),2));
    hold on;
    
    % 将第c类所有数据导出至newpart
    for k=1:length(num) 
        newpart(k,:)=filted(num(k),:);
    end

    % 采用滑动窗思想，截取一段时间窗length_t,滑动窗大小delta_t,单位ms
    length_t=100;
    delta_t=20;
    j=1; %数据量
    feature=[]; %提前分配内存
    
    tic
    for i=1:delta_t:size(newpart,1)
        % 跳出循环条件
        if i+length_t>size(newpart,1)% 判断是否超出数据范围
            break;
        end

        % 阈值处理
        datadetect=f_detect(newpart(i:i+length_t,:));     
        b=(datadetect==0);
        zeronum=sum(b(:));% 置零项个数
        zeroratio=zeronum/length_t;%置零项比例
        
        if zeroratio < 0.4000 %判断处于活动段范围
            
            plot(i,0,'r+');;%绘制活动段采样点
            feature(j,:)=f_feature(newpart(i:i+length_t,:),c);% 特征提取
            j=j+1;
            
        end
        
    end
    % 构造特征向量矩阵
    if c==1
        x=feature;
    else
        x=[x;feature];
    end
    newpart=[];% 释放临时变量
    toc
end

%% 归一化
[X,rule]=c_normal(x,0,1,27); % 归一化
save rule.mat rule;% 保存归一化规则

%将特征矩阵转换成libsvm可识别的格式
instance=sparse(X(:,1:27));
lab=X(:,28);
libsvmwrite('emg',lab, instance);


%% -- 训练模型 --%%
% 读取数据集
[label, data] = libsvmread('emg');

% 参数网格寻优
% [bestacc,bestc,bestg]=SVMcgForClass(label,data,-8,8,-8,8,5,1,1); % c,gamma寻优

% 划分训练集和测试集
ratio =0.8; %训练集比例
[traindata, trainlabel, testdata, testlabel]= c_split(data,label,ratio);

% 训练模型
model = libsvmtrain(label,data,'-s 0 -t 2  -c 1 -g 1 ');

% 利用建立的模型看其在训练集合上的分类效果-w1 0.8 -w3 2.5 -w4 1 -w5 2
[ptrain,acctrain,~] = libsvmpredict(trainlabel,traindata,model);

% 预测测试集合标签
[ptest,acctest,test_dec_values] = libsvmpredict(testlabel,testdata,model);

% 保存分类模型
libsvmsave(model,'copymodel.model');

% 预测结果可视化
figure(6)
p=[ptrain;ptest];
plot(p,'o');
grid on;
set(gca,'ytick',1:1:6);