%% 斜率符合变化次数 - SSC - Slope Sign Change, number times
function feature = f_ssc(data)
     
    DeadZone = 10e-7;
    data_size = size(data);
    feature = 0;

    if data_size == 0
        feature = 0;
    else
        for j=3:data_size
            difference1 = data(j-1) - data(j-2);
            difference2 = data(j-1) - data(j);
            Sign = difference1 * difference2;
            if Sign > 0
                if abs(difference1)>DeadZone || abs(difference2)>DeadZone
                    feature = feature + 1;
                end
            end
        end
        feature = (feature)/data_size(1);
    end
end
