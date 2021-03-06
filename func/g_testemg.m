function result=g_testemg(model,rule,test,i,length_t)
%% 测试模型程序
% 利用训练好的分类模型对未知数据进行预测
% model 训练好的分类模型，详见trainonline.m
% rule 训练集的归一化法则，详见c_normal.m
% i 采样点序数
% length_t 滑动窗长度
% By Yinuo Wang 2020/4/15

    % 取时间窗内数据
    win= test(i:i+length_t,:);
    
    % 预处理
    delete=p_mean(win);% 去偏置
    out=p_outlier(delete);% 去野值
    filt=p_50hz(out);% 陷波
    filted=p_butter(filt);% 滤波
    
    % 阈值处理
    datadetect=f_detect(filted);% 将低于活动段阈值的数据置零
    b=(datadetect==0);
    zeronum=sum(b(:));% 置零项个数
    zeroratio=zeronum/length_t;%置零项比例
    
    %判断处于活动段范围
    if zeroratio < 0.4000
        
%         plot(i,0,'b+');%绘制活动段采样点



        feature=f_feature(filted,0);% 特征提取
        
        F=c_normal_rule(feature,rule); % 数据归一化
        
        %将特征矩阵转换成libsvm可识别的格式
        instance=sparse(F(1,1:27));
        lab=F(1,28);
        libsvmwrite('emgtest3',lab, instance);
        
        % 对活动段分类预测
        [label, data] = libsvmread('emgtest3');% 读取数据
        predict = libsvmpredict(label,data,model);% 数据分类
        result=predict;
        
    else
        % 对静息段直接置零
        result=0;
    end


end