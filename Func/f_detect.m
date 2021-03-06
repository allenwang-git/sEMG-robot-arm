function sum=f_detect(data)
%% 活动段检测
sumemg=abs(data(:,2))+abs(data(:,3))+abs(data(:,4));
% plot(sumemg,'b')
% hold on;
% % 计算活动段阈值
% u=1.8;% 增益系数
% v=var(sumemg);
% theta=mean(sumemg)+u*sqrt(var(sumemg));

theta=0.1007;
%sum(1,length(sumemg))=0;
for i=1:length(sumemg)
    if sumemg(i)<=theta
        sum(i)=0.0000;
    else
        sum(i)=sumemg(i);
    end
end
% plot(sum);