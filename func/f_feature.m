function feature=f_feature(win,q)
% 特征提取
data1=win(:,2);
data2=win(:,3);
data3=win(:,4);


feature(1,28)=0;% 给特征向量提前分配内存
%提取时域特征,每个通道9个特征，总共27个特征
feature(1,1) = f_mav(data1);   feature(1,11) = max(data2);     feature(1,21)= f_var(data3);
feature(1,2) = max(data1);     feature(1,12) = f_var(data2);   feature(1,22)= f_rms(data3);
feature(1,3) = f_var(data1);   feature(1,13) = f_rms(data2);   feature(1,23)= f_iemg(data3);
feature(1,4) = f_rms(data1);   feature(1,14) = f_iemg(data2);  feature(1,24)= f_zc(data3);
feature(1,5) = f_iemg(data1);  feature(1,15) = f_zc(data2);    feature(1,25)= f_wl(data3);
feature(1,6) = f_zc(data1);    feature(1,16) = f_wl(data2);    feature(1,26)= f_mdf(data3);
feature(1,7) = f_wl(data1);    feature(1,17) = f_mdf(data2);   feature(1,27)= f_mnf(data3);
feature(1,8) = f_mdf(data1);   feature(1,18) = f_mnf(data2);
feature(1,9) = f_mnf(data1);   feature(1,19) = f_mav(data3);
feature(1,10)= f_mav(data2);   feature(1,20) = max(data3);
if q==0
    feature(1,28)= 0;%给测试集标签列打标签0
elseif (q==1||q==2||q==3||q==4||q==5)
    feature(1,28)= win(1,5);%给训练集标签列打标签
else
    disp("Function Error")
end

end