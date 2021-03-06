% t3=0.05*(1:9999); 
% % ch3,jpg
% subplot(3,1,1);
% plot(t3,raw(1:9999,2),'r'); 
% xlabel('t/s'); ylabel('U/mV');title('ch-1');
% 
% subplot(3,1,2); 
% plot(t3,raw(1:9999,3),'b');
% title('ch-2'); xlabel('t/s'); ylabel('U/mV');
% 
% subplot(3,1,3);
% plot(t3,raw(1:9999,4),'y'); 
% xlabel('t/s');title('ch-3'); ylabel('U/mV');1000:2999


% a=raw(10001:12000,3);
% t=0.05*(1:2000);
% aout=p_outlier(raw(10001:12000,:));
% figure(2);
% subplot(1,2,1);plot(t,a,'b');grid on;title('原始信号');xlabel('t/s');ylabel('U/mV');
% subplot(1,2,2);plot(t,aout(:,3),'b');grid on;title('去偏置信号');xlabel('t/s');ylabel('U/mV');


%% FFT 频谱分析
fs=2000;%采样频率，单位Hz y
% n=0:N-1;
% N=length(t);
N=50000;t=(N-1)/fs;
for i=1:50000
   y=5*10e-6*sin(100*pi*0.0005*i); k(i)=b(i,1)+y;
end
fx=fft(k,N);
fx=abs(fx(1:round(N/2-1)));
figure(3)
subplot(1,2,1);
plot((1:round(N/2-1))*fs/N,fx);%绘制信号的频谱，横轴对应实际频率
grid on;title('原始信号频谱图');xlabel('f/Hz');ylabel('振幅');


%% Butterworth高通滤波器
% fc=500;%截至频率
% wn=2*fc/fs;%归一化频率0-1
% [c,a]=butter(5,wn,'low'); %滤波器阶数，边界频率，模式
% bb=filter(c,a,b(1:30000,1));
% fxx=fft(bb,N);%频谱分析
% fxx=abs(fxx(1:round(N/2-1)));
% subplot(1,2,2);plot((1:round(N/2-1))*fs/N,fxx);
% grid on;title('滤波后频谱图');xlabel('f/Hz');ylabel('振幅');
% % 
f0=50;%要滤掉的频率，单位Hz
Ts=1/fs;
apha=-2*cos(2*pi*f0*Ts);
beta=0.99;
d=[1 apha 1];
a=[1 apha*beta beta^2];
bbb=dlsim(d,a,b(1:30000,1));%陷波器滤波处理
fxxx=fft(bbb,N);%频谱分析
fxxx=abs(fxxx(1:round(N/2-1)));
subplot(1,2,2);plot((1:round(N/2-1))*fs/N,fxxx);
grid on;title('50Hz陷波后频谱图');xlabel('f/Hz');ylabel('振幅');