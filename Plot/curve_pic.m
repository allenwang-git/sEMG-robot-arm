% 读取数据集
[label, data] = libsvmread('emg');
%%
% i=1;
% % 划分训练集和测试集
% for g=[10e-5,10e-4,10e-3,10e-2:10e-1,1,10,100]
% ratio =0.7;%训练集比例
% [traindata, trainlabel, testdata, testlabel]= c_split(data,label,ratio);
% 
% cmd = ['-s ',num2str(0),' -t ',num2str(2),' -v ',num2str(5),' -c ',num2str(4),' -g ',num2str(g)];
% cmdd= ['-s ',num2str(0),' -t ',num2str(2),' -c ',num2str(4),' -g ',num2str(g)];
% % % 训练模型
% valid(i)= libsvmtrain(trainlabel,traindata,cmd);
% 
% model= libsvmtrain(label,data,cmdd);
% % '-s 0 -t 2 -c num2str(c) -v 5 -q'
% % % 利用建立的模型看其在训练集合上的分类效果
% [ptrain,acctrain,~] = libsvmpredict(trainlabel,traindata,model);
% acc(i)=acctrain(1);
% % % 预测测试集合标签
% % [ptest,acctest,test_dec_values] = libsvmpredict(testlabel,testdata,model);
% i=i+1;
% end
% figure(4)
% gamma=[10e-5,10e-4,10e-3,10e-2:10e-1,1,10,100];
% semilogx(gamma,valid,'-rs',gamma,acc,'-b^','linewidth',2,'markersize',5);hold on;grid on;legend on;
% title('g验证曲线');xlabel('g');ylabel('Accuracy/%');legend('validation accuracy','trainset accuracy ');
%%
i=1;

% 划分训练集和测试集
for c=[10e-4,10e-3,10e-2:10e-1,1,10,100,1000,10e3,10e4,10e5,10e6]
ratio =0.7;%训练集比例
[traindata, trainlabel, testdata, testlabel]= c_split(data,label,ratio);

cmd = ['-s ',num2str(0),' -t ',num2str(2),' -v ',num2str(5),' -c ',num2str(c)];
cmdd= ['-s ',num2str(0),' -t ',num2str(2),' -c ',num2str(c)];
% % 训练模型
valid(i)= libsvmtrain(trainlabel,traindata,cmd);

model= libsvmtrain(label,data,cmdd);
% '-s 0 -t 2 -c num2str(c) -v 5 -q'
% % 利用建立的模型看其在训练集合上的分类效果
[ptrain,acctrain,~] = libsvmpredict(trainlabel,traindata,model);
acc(i)=acctrain(1);
% % 预测测试集合标签
% [ptest,acctest,test_dec_values] = libsvmpredict(testlabel,testdata,model);
i=i+1;
end
figure(5)
gamma= [10e-4,10e-3,10e-2:10e-1,1,10,100,1000,10e3,10e4,10e5,10e6];
semilogx(gamma,valid,'-rs',gamma,acc,'-b^','linewidth',2,'markersize',5);hold on;grid on;legend on;
title('c验证曲线');xlabel('c');ylabel('Accuracy/%');legend('validation accuracy','trainset accuracy ');

%%
% i=1;
% for ratio =0.05:0.05:1%训练集比例
% [traindata, trainlabel, testdata, testlabel]= c_split(data,label,ratio);
% % 训练模型
% valid(i)= libsvmtrain(trainlabel,traindata, '-s 0 -t 2 -c 4 -g 4 -v 5 -q');
% model= libsvmtrain(label,data, '-s 0 -t 2 -c 4 -g 4 -q');
% % 利用建立的模型看其在训练集合上的分类效果
% [ptrain,acctrain,~] = libsvmpredict(trainlabel,traindata,model);
% acc(i)=acctrain(1);
% i=i+1;
% end
% figure(5)
% ra=1000*(0.05:0.05:1);
% plot(ra,valid,'-rs',ra,acc,'-b^','linewidth',2,'markersize',5);hold on;grid on;legend on;
% title('学习曲线');xlabel('数据量');ylabel('Accuracy/%');legend('validation accuracy','trainset accuracy ');
% axis([0,1005,0,100]);