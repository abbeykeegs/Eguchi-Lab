function [time_ratio,Signal_Ca_ratio,sub_output_folder]=Convert_raw_data_to_ratio(folder_name,input_file,output_folder_name)

% This function reads in the raw recordings and calculate the correct ratio

headerlinesIn = 1;

% Start to read in the file
file_to_read=[folder_name,'/',input_file,'.xlsx'];
Signal_all=importdata(file_to_read,headerlinesIn);
Signal=Signal_all.data.Data0x28ROIs0x29;
% Calculate the number of cells being recorded
number_signal=size(Signal,1);
number_columns=size(Signal,2);
% Time [s]	ND.T	ND.Z	ND.M  #1 #2 .....
number_cells=number_columns-4-1;
time=Signal(:,1);
time_ratio=time(1:2:end,:);

Signal_Ca=Signal(:,5:number_columns);
% Assume the first recording is from 340 channel, followed by the 380
% channel
Signal_Ca_340_channel=Signal_Ca(1:2:end,:);
Signal_Ca_380_channel=Signal_Ca(2:2:end,:);
% Check whether the dimensions agree
if size(Signal_Ca_340_channel,1)>size(Signal_Ca_380_channel)
    Signal_Ca_340_channel(end,:)=[];
elseif size(Signal_Ca_340_channel,1)<size(Signal_Ca_380_channel)
    Signal_Ca_380_channel(end,:)=[];
end

time_ratio=time(1:2:end);
time_ratio_diff=diff(time_ratio);
Signal_Ca_ratio=zeros(size(Signal_Ca_340_channel,1),number_cells);
Signal_Ca_ratio_diff=zeros(size(Signal_Ca_340_channel,1)-1,number_cells);
% Calculate ratio, assume starting signal is 340
current_figure=figure('units','normalized','outerposition',[0 0 1 1]);
for c=1:number_cells
    Signal_Ca_ratio_340_380(:,c)=Signal_Ca_340_channel(:,c)./Signal_Ca_380_channel(:,c);
    subplot(2,2,3),plot(Signal_Ca_ratio_340_380(:,c),'ko-','MarkerFaceColor','g','LineWidth',1);
    subplot(2,2,3),title('1st/2nd');
    xlim([0 500]);
    Signal_Ca_ratio_380_340(:,c)=Signal_Ca_380_channel(:,c)./Signal_Ca_340_channel(:,c);
    subplot(2,2,4),plot(Signal_Ca_ratio_380_340(:,c),'ko-','MarkerFaceColor','g','LineWidth',1);
    subplot(2,2,4), title('2nd/1st');
    xlim([0 500]);
    % Smooth the signal
    Signal_Ca_ratio_340_380_tmp=smooth_signal( Signal_Ca_ratio_340_380(:,c));
    Signal_Ca_ratio_380_340_tmp=smooth_signal( Signal_Ca_ratio_380_340(:,c));
    % Calculate the slope of the signals    
    Signal_Ca_ratio_diff_340_380(:,c)=diff(Signal_Ca_ratio_340_380_tmp)/time_ratio_diff(1);
    Signal_Ca_ratio_diff_380_340(:,c)=diff(Signal_Ca_ratio_380_340_tmp)/time_ratio_diff(1);
	%{
    if c==1
     % Calculate percentile of positive and negative slopes
        [pos_340_380_upper,pos_380_340_upper,neg_340_380_upper,neg_380_340_upper,no_points_pos,no_points_neg]...
            =Calculate_percentile_slope(Signal_Ca_ratio_diff_340_380(:,c),Signal_Ca_ratio_diff_380_340(:,c));
        if (pos_340_380_upper>pos_380_340_upper) & ...
                no_points_pos<no_points_neg
               %(neg_340_380_upper>neg_380_340_upper)
         %if (neg_340_380_upper>neg_380_340_upper)   % Slower descend   
            Signal_Ca_ratio(:,c)=Signal_Ca_ratio_340_380(:,c);
            ratio_option=1;
        else
            Signal_Ca_ratio(:,c)=Signal_Ca_ratio_380_340(:,c);
            ratio_option=2;
        end
    elseif ratio_option==1
        Signal_Ca_ratio(:,c)=Signal_Ca_ratio_340_380(:,c);
    elseif ratio_option==2
        Signal_Ca_ratio(:,c)=Signal_Ca_ratio_380_340(:,c);
    end
	%}
	% Look at the maximum dCa/dt to distinguish
    if max(Signal_Ca_ratio_diff_340_380(:,c))>max(Signal_Ca_ratio_diff_380_340(:,c))    
        % Subtract background noise
        Signal_Ca_340_channel(:,c)=Signal_Ca_340_channel(:,c)-Signal_Ca_340_channel(:,end);
        Signal_Ca_380_channel(:,c)=Signal_Ca_380_channel(:,c)-Signal_Ca_380_channel(:,end);
        Signal_Ca_ratio_340_380(:,c)=Signal_Ca_340_channel(:,c)./Signal_Ca_380_channel(:,c);
        Signal_Ca_ratio(:,c)=Signal_Ca_ratio_340_380(:,c);
    else
        % Subtract background noise
        Signal_Ca_340_channel(:,c)=Signal_Ca_340_channel(:,c)-Signal_Ca_340_channel(:,end);
        Signal_Ca_380_channel(:,c)=Signal_Ca_380_channel(:,c)-Signal_Ca_380_channel(:,end);
        Signal_Ca_ratio_380_340(:,c)=Signal_Ca_380_channel(:,c)./Signal_Ca_340_channel(:,c);
        Signal_Ca_ratio(:,c)=Signal_Ca_ratio_380_340(:,c);
    end
    % Plot the correted ratio
    subplot(2,1,1),plot(Signal_Ca_ratio(:,c),'ko-','MarkerFaceColor','g','LineWidth',1);
    subplot(2,1,1), title([input_file,' Corrected Ratio for Cell ',num2str(c)]);
    output_screenshots=[output_folder_name,'/Converted_Ratio_Cell_Number_',num2str(c)];
    print(current_figure,output_screenshots,'-dpng');
    fprintf(' Corrected ratio has been calculated for cell No. %d\n',c);
    % clear figure
    clf;
end

return