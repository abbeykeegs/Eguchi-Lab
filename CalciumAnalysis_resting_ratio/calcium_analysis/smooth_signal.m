function raw_signal_smooth=smooth_signal(raw_signal)

% This function performs smoothing on the raw data using the moving average
% 5 algorithm

raw_signal_smooth=raw_signal;

for i=1:size(raw_signal,1)
    if i==1
        raw_signal_smooth(i)=raw_signal(i);
    elseif i==2;
        raw_signal_smooth(i)=(raw_signal(i)+raw_signal(i+1)+raw_signal(i+2))/3;
    elseif i==(size(raw_signal,1)-1)
        raw_signal_smooth(i)=(raw_signal(i-2)+raw_signal(i-1)+raw_signal(i))/3;
    elseif i==(size(raw_signal,1))
        raw_signal_smooth(i)=raw_signal(size(raw_signal,1));
    else
        raw_signal_smooth(i)=(raw_signal(i-2)+raw_signal(i-1)+raw_signal(i)+raw_signal(i+1)+raw_signal(i+2))/5;
    end
end

return