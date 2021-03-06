%% ¾ùÖµÆµÂÊ - MNF - Mean Frequency
function feature = f_mnf(data)
 
    Fs = 100; 
    feature = meanfreq(data, Fs);
    
end