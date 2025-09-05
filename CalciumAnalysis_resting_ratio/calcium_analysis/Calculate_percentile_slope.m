function [pos_340_380_upper,pos_380_340_upper,neg_340_380_upper,neg_380_340_upper,no_points_pos,no_points_neg]=Calculate_percentile_slope(Signal_Ca_ratio_diff_340_380_tmp,Signal_Ca_ratio_diff_380_340_tmp)

pos_340_380_index=find(Signal_Ca_ratio_diff_340_380_tmp>0);
pos_340_380=Signal_Ca_ratio_diff_340_380_tmp(pos_340_380_index);
neg_340_380_index=find(Signal_Ca_ratio_diff_340_380_tmp<0);
neg_340_380=Signal_Ca_ratio_diff_340_380_tmp(neg_340_380_index);
%pos_340_380_upper=prctile(pos_340_380,50);
%neg_340_380_upper=prctile(neg_340_380,50);
pos_340_380_upper=mean(pos_340_380);
neg_340_380_upper=mean(neg_340_380);
no_points_pos=size(pos_340_380,1);
no_points_neg=size(neg_340_380,1);

pos_380_340_index=find(Signal_Ca_ratio_diff_380_340_tmp>0);
pos_380_340=Signal_Ca_ratio_diff_380_340_tmp(pos_380_340_index);
neg_380_340_index=find(Signal_Ca_ratio_diff_380_340_tmp<0);
neg_380_340=Signal_Ca_ratio_diff_380_340_tmp(neg_380_340_index);
%pos_380_340_upper=prctile(pos_380_340,50);
%neg_380_340_upper=prctile(neg_380_340,50);
pos_380_340_upper=mean(pos_380_340);
neg_380_340_upper=mean(neg_380_340);

return