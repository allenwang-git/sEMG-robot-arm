%% 中值频率 - MDF - Median Frequency
function feature = f_mdf(data)
    
    Fs = 100;           
    feature = medfreq(data, Fs);    % medfreq()计算中值频率
    
end
