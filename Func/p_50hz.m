function delete50= p_50hz(data)
% 50HZ陷波 delete 50hz
% 1-t, 2-ch1, 3-ch2, 4-ch3, 5-label;

f0=50;%要滤掉的频率，单位Hz
fs=100;%采样频率，单位Hz
Ts=1/fs;
%构造陷波器
apha=-2*cos(2*pi*f0*Ts);
beta=0.99;
b=[1 apha 1];
a=[1 apha*beta beta^2];

if size(data,2)==5
    delete50(:,1)=data(:,1);
    delete50(:,2)=dlsim(b,a,data(:,2));%陷波器滤波处理
    delete50(:,3)=dlsim(b,a,data(:,3));
    delete50(:,4)=dlsim(b,a,data(:,4));
    delete50(:,5)=data(:,5);
    
elseif size(data,2)==4
    delete50(:,1)=data(:,1);
    delete50(:,2)=dlsim(b,a,data(:,2));%陷波器滤波处理
    delete50(:,3)=dlsim(b,a,data(:,3));
    delete50(:,4)=dlsim(b,a,data(:,4));
else
    disp("Function Inputdata Error.")
end
        
end

