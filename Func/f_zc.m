%% Áã´©Ô½´ÎÊý - ZC - Zero Crossing
function feature = f_zc(data)
   
    DeadZone = 10e-7;
    data_size = size(data);
    feature = 0;

    if data_size == 0
        feature = 0;
    else
        for i=2:data_size
            difference = data(i) - data(i-1);
            multy      = data(i) * data(i-1);
            if abs(difference)>DeadZone && multy<0
                feature = feature + 1;
            end
        end
        feature = feature/data_size(1);
    end
    
end
