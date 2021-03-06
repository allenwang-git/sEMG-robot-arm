function feature = f_iemg(data)
% 积分肌电值 iEMG
    t=0.01;
    feature=sum(abs(data)*t)/size(data,1);
end

