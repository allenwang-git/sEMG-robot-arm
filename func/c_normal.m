%% 按列归一化 normalization
% 先以特征为单位归一化再转换为libsvm数据,OriginalData最后一列必须带标签,veci为特征数
function [normal,rule]=c_normal(OriginalData,ymin,ymax,veci)

normalrule(:,1)=(1:veci);% 归一化规则的特征序号

for i=1:veci
data = OriginalData(:,i); % 展开矩阵第i列，然后转置为一行。
xmax=max(data);
xmin=min(data);
normaldata(:,i)=(ymax-ymin)*(data-xmin)/(xmax-xmin)+ymin;% 最大最小归一
normalrule(i,2:3)=[xmin,xmax];

end
normal=[normaldata,OriginalData(:,(veci+1))];
rule=[veci,ymin,ymax;
      normalrule];
