function [deletemean,mean1,mean2,mean3] = p_mean(data)
% 三通道去偏置 delete mean
%1-t, 2-ch1, 3-ch2, 4-ch3, 5-label;
mean1=mean(data(:,2));
mean2=mean(data(:,3));
mean3=mean(data(:,4));

if size(data,2)==5
deletemean(:,1)=data(:,1);
deletemean(:,2)=data(:,2)-mean(data(:,2));
deletemean(:,3)=data(:,3)-mean(data(:,3));
deletemean(:,4)=data(:,4)-mean(data(:,4));
deletemean(:,5)=data(:,5);
    
elseif size(data,2)==4
deletemean(:,1)=data(:,1);
deletemean(:,2)=data(:,2)-mean(data(:,2));
deletemean(:,3)=data(:,3)-mean(data(:,3));
deletemean(:,4)=data(:,4)-mean(data(:,4));

else
    disp("Function Inputdata Error.")
end

end

