%% 均方根值 - RMS - Root Mean Square
function feature = f_rms(data)
    
    feature = sqrt(mean(data.^2));  
    
end