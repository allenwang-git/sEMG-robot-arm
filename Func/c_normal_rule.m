%% 按列归一化 normalization
% 先以特征为单位归一化再转换为libsvm数据,OriginalData最后一列必须带标签,veci为特征数
function normal=c_normal_rule(OriginalData,normalrule)

veci=normalrule(1,1);
ymin=normalrule(1,2);
ymax=normalrule(1,3);

for i=1:veci
data = OriginalData(1,i); % data-第i个特征

xmin=normalrule(i+1,2);
xmax=normalrule(i+1,3);
%避免数据溢出规则范围
if data>=xmax
    data=xmax;
elseif data<=xmin
    data=xmin;
end
%按规则归一化
normaldata(1,i)=(ymax-ymin)*(data-xmin)/(xmax-xmin)+ymin;
end
normal=[normaldata,OriginalData(1,(veci+1))];% 带标签输出

