function [x_train, y_train,  x_test, y_test] = c_split(x, y, ratio)
%split_dataset 分割训练集和测试集
%  参数x是数据矩阵 y是对应类标签 ratio是训练集的比例
%  返回训练集x_train和对应的类标签y_train 测试集x_test和对应的类标签y_test

m = size(x, 1);
y_labels = unique(y); % 去重，k应该等于length(y_labels) 
d = (1:m)';%生成所有数据的序号矩阵1-m
x_train(2500,27)=0;%预分配内存
y_train(2500,1)=0;

for i = 1:4
    all_i = find(y == y_labels(i));% 第I类所有数据序号
    size_all_i = length(all_i);
    rp = randperm(size_all_i); % 随机排列1-k的所有整数
    rp_ratio = rp(1:floor(size_all_i * ratio));% 生成（k*ratio）个1-k内的整数

   %生成训练集
   if i==1
       x_train = x(all_i(rp_ratio),:);
       y_train = y(all_i(rp_ratio),:);
   else
       x_train = [x_train; x(all_i(rp_ratio),:)];
       y_train = [y_train; y(all_i(rp_ratio),:)];
   end
    d = setdiff(d, all_i(rp_ratio)); % 取数据集中余下元素
end
% 生成测试集
x_test = x(d, :);
y_test = y(d, :);

end


