%% ²¨ÐÎ³¤ - WL - Waveform Length
function feature = f_wl(data)
    
    feature = sum(abs(diff(data)))/length(data);
    
end

