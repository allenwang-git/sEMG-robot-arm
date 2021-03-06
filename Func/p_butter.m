function filted = p_butter(data)
% butterworth高通滤波
% 1-t, 2-ch1, 3-ch2, 4-ch3, 5-label;

fs=100;%采样频率，单位Hz
fc=10;%截至频率
wn=2*fc/fs;%归一化频率0-1
[b,a]=butter(5,wn,'high'); %滤波器阶数，边界频率，模式

if size(data,2)==5
filted(:,1)=data(:,1);
filted(:,2)=filter(b,a,data(:,2));%陷波器滤波处理
filted(:,3)=filter(b,a,data(:,3));
filted(:,4)=filter(b,a,data(:,4));
filted(:,5)=data(:,5);
    
elseif size(data,2)==4
filted(:,1)=data(:,1);
filted(:,2)=filter(b,a,data(:,2));%陷波器滤波处理
filted(:,3)=filter(b,a,data(:,3));
filted(:,4)=filter(b,a,data(:,4));

else
    disp("Function Inputdata Error.")
end

end

