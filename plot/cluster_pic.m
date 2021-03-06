
figure(1)
%显示数据
set(gca,'xdir','reverse','ydir','reverse');
% plot3(X(1   :1119,5),X(1   :1119,14),X(1   :1119,23),"ro");hold on;grid on;legend on;
% plot3(X(1120:2244,5),X(1120:2244,14),X(1120:2244,23),"gx");
% plot3(X(2245:3383,5),X(2245:3383,14),X(2245:3383,23),"y*");
% plot3(X(3384:4542,5),X(3384:4542,14),X(3384:4542,23),"bd");

plot3(rr(1    :458,2),rr(1    :458,3),rr(1    :458,4),"ro");hold on;grid on;legend on;
plot3(rr(459  :771,2),rr(459  :771,3),rr(459  :771,4),"gx");
plot3(rr(772 :1176,2),rr(772 :1176,3),rr(772 :1176,4),"y*");
plot3(rr(1177:1599,2),rr(1177:1599,3),rr(1177:1599,4),"bd");
% 
% plot3(X(1    :458,8),X(1    :458,17),X(1     :458,26),"ro");hold on;grid on;legend on;
% plot3(X(1459:1771,8),X(1459:1771,17),X(1459 :1771,26),"gx");
% plot3(X(2772:3176,8),X(2772:3176,17),X(2772 :3176,26),"y*");
% plot3(X(4177:4542,8),X(4177:4542,17),X(4177 :4542,26),"bd");

legend('open','index','grasp','middle');
xlabel('通道一原始值');
ylabel('通道二原始值');
zlabel('通道三原始值');
title('原始EMG聚类分析');

% figure(2)
% %显示数据
% set(gca,'xdir','reverse','ydir','reverse');
% plot3(X(1    :458,9),X(1    :458,18),X(1     :458,27),"ro");hold on;grid on;legend on;
% plot3(X(1459:1771,9),X(1459:1771,18),X(1459 :1771,27),"gx");
% plot3(X(2772:3176,9),X(2772:3176,18),X(2772 :3176,27),"y*");
% plot3(X(4177:4542,9),X(4177:4542,18),X(4177 :4542,27),"bd");
% 
% legend('open','index','grasp','middle');
% xlabel('通道一特征值');
% ylabel('通道二特征值');
% zlabel('通道三特征值');
% title('MPF聚类分析');
% 
% figure(3)
% %显示数据
% set(gca,'xdir','reverse','ydir','reverse');
% plot3(X(1    :458,2),X(1    :458,11),X(1     :458,20),"ro");hold on;grid on;legend on;
% plot3(X(1459:1771,2),X(1459:1771,11),X(1459 :1771,20),"bd");
% plot3(X(2772:3176,2),X(2772:3176,11),X(2772 :3176,20),"y*");
% plot3(X(4177:4542,2),X(4177:4542,11),X(4177 :4542,20),"gx");
% 
% legend('open','index','grasp','middle');
% xlabel('通道一特征值');
% ylabel('通道二特征值');
% zlabel('通道三特征值');
% title('SSC聚类分析');
% 
% figure(4)
% %显示数据
% set(gca,'xdir','reverse','ydir','reverse');
% plot3(X(1    :458,6),X(1    :458,15),X(1     :458,24),"ro");hold on;grid on;legend on;
% plot3(X(1459:1771,6),X(1459:1771,15),X(1459 :1771,24),"bd");
% plot3(X(2772:3176,6),X(2772:3176,15),X(2772 :3176,24),"y*");
% plot3(X(4177:4542,6),X(4177:4542,15),X(4177 :4542,24),"gx");
% 
% legend('open','index','grasp','middle');
% xlabel('通道一特征值');
% ylabel('通道二特征值');
% zlabel('通道三特征值');
% title('ZC聚类分析');
