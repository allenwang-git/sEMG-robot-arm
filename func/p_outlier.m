function out=p_outlier(delete)
% 去野值

for j=2:4
    dj=delete(:,j);% 三通道逐次去野值
   for i=21:size(dj)
       m=max(abs(dj(i-20:i-1)));
       me=mean(abs(dj(i-20:i)));
       if abs(dj(i))>3*m % 数据值若大于阈值则置为2倍均值
          if dj(i)<0
              dj(i)=-2*me;
          else
              dj(i)=2*me;
          end
       end
   end
   delete(:,j)=dj;
end
out=delete;
