function Extract_trace_properties_FB(time,Ca_multiple_cells, input_file,sub_output_folder,cells_to_exclude)

% This script is designed to analyse the trace and evaluate the following
% properties

% Evaluat the total number of cells
number_of_cells=size(Ca_multiple_cells,2);

% Define the number of cycles to exclude
number_cycles_to_exclude=1;
% Define an array to store final results
Ca_properties_all=[];
% Open a figure to plot
current_figure=figure('units','normalized','outerposition',[0 0 1 1]);

for c=1:number_of_cells
    if isempty(find(c==cells_to_exclude))
        % Isolate Ca trace for one cell at a time
        Ca=table2array(Ca_multiple_cells(:,c));
        % For certain recording, the number of data is not completely 1480,
        % therefore, need to manipulate time to match that
        if size(time,1)~=size(Ca,1)
            time(end)=[];
        end
        % Plot the raw signals
        plot(time,Ca,'k-','LineWidth',1);
        hold on;
        title([input_file,'\_Cell\_No.', num2str(c)],'FontSize',12,'Interpreter','none');
        %%%%%%%%%%%% Calculate the period of the signal %%%%%%%%%%%%%%
        [T,dt]=finding_freq(time,Ca);
        peak_dis=T/dt;
        
        %%%%%%%%%%%% Extract local maximum %%%%%%%%%%%%%%%%%%
        % Find peaks assuming the neighboring peaks should not be within 5 smaple
        % points
        %[peaks,peaks_locations]=findpeaks(Ca);
        % Find the peaks that drop at least 0.1 on either side before the signal attains a higher value
        Peak_detection_threshold=(max(Ca)-min(Ca))*0.3;
        [peaks,peaks_locations]=findpeaks(Ca,'MinPeakProminence',0.025,'MinPeakDistance',peak_dis/2);%
        % Eliminate peaks which magnitude falls 1/3 of the minimum peaks
        peaks_all=peaks;
        peaks_locations_all=peaks_locations;
        peaks_to_include_index=find(peaks_all>=(max(peaks_all)*2/3));
        peaks=peaks_all(peaks_to_include_index);
        peaks_locations=peaks_locations_all(peaks_to_include_index);
        peaks_time=time(peaks_locations);
        Ca_peaks_all_time=peaks_time;
        Ca_peaks_all_locations=peaks_locations;
        Ca_peaks_all=peaks;

        % The following lines are manual method to eliminate some of the local
        % minima, but MinPeakProminence option did the trick, so the follow lines
        % are commented out.
        %{
        peaks_locations_diff=diff(peaks_locations);
        index=find(peaks_locations_diff<4);
        peaks_time(index+1)=[];
        peaks_locations(index+1)=[];
        peaks(index+1)=[];
        
        
        % Evaluate the histogram to extract the positions of the maximum ratios
        [peaks_bin_counts,peaks_centers]=hist(peaks);
        % The following command is to find the dominant peaks
        max_peak_centers_index=find(peaks_bin_counts==max(peaks_bin_counts));
        % If there are multiple peaks with same height, then do not make
        % further modifications to the peaks
        if size(max_peak_centers_index,2)==1
            %max_peak_centers=peaks_centers(max_peak_centers_index)-(peaks_centers(max_peak_centers_index)-peaks_centers(max_peak_centers_index-1))/2;
            zero_bin_counts=find(peaks_bin_counts==0);
            if ~isempty(zero_bin_counts)
                if size(zero_bin_counts,2)>1
                    max_peak_centers=peaks_centers(zero_bin_counts(end));
                end
            else
                max_peak_centers=peaks_centers(max_peak_centers_index-1);
            end
        end
        % Filter out local peaks
        Ca_peaks_all=peaks(find(peaks>max_peak_centers));
        Ca_peaks_all_locations=peaks_locations(find(peaks>max_peak_centers));
        Ca_peaks_all_time=peaks_time(find(peaks>max_peak_centers));
        %}
        
        plot(Ca_peaks_all_time,Ca_peaks_all,'rd','MarkerSize',8,'MarkerFace','r');
        hold on;
        grid on;
        grid minor;
        % Calculate the total number of peak points
        no_peaks=size(Ca_peaks_all_locations,1);

        %%%%%%%%%%%% Extract local minimum %%%%%%%%%%%%%%%%%%
        Ca_baseline_all=[];
        Ca_baseline_time_all=[];
        Ca_baseline_locations_wrt_whole_all=[];

        % For each peak, back-step a few sample points to find the minium value
        for i=1:size(Ca_peaks_all_locations,1)
            if (Ca_peaks_all_locations(i)-round(peak_dis/2))<=0
                Ca_valley=Ca(1:Ca_peaks_all_locations(i));
            else
                Ca_valley=Ca((Ca_peaks_all_locations(i)-round(peak_dis/4)):Ca_peaks_all_locations(i));
            end
            Ca_baseline=min(Ca_valley);
            Ca_baseline_locations=find(Ca_valley==Ca_baseline);
            Ca_baseline_locations_wrt_whole_tmp=find(Ca==Ca_baseline);
            % This follow lines will compare the existing troughs with the
            % one from the last cycle to eliminate troughs from previous
            % cycles
            if i>1
                Ca_baseline_locations_wrt_whole_index=find(Ca_baseline_locations_wrt_whole_tmp>Ca_baseline_locations_wrt_whole_all(end));
            else
                Ca_baseline_locations_wrt_whole_index=1;
            end
            % If the two troughs are too close, then pick the next one
            if i>1 &(Ca_baseline_locations_wrt_whole_tmp(Ca_baseline_locations_wrt_whole_index(1))-Ca_baseline_locations_wrt_whole_all(end))<(peak_dis/2)
                Ca_baseline_time=time(Ca_baseline_locations_wrt_whole_tmp(Ca_baseline_locations_wrt_whole_index(2)));
            else
                Ca_baseline_time=time(Ca_baseline_locations_wrt_whole_tmp(Ca_baseline_locations_wrt_whole_index(1)));
            end
            Ca_baseline_all=[Ca_baseline_all;Ca_baseline];
            Ca_baseline_time_all=[Ca_baseline_time_all;Ca_baseline_time];
            Ca_baseline_locations_wrt_whole_all=[Ca_baseline_locations_wrt_whole_all;Ca_baseline_locations_wrt_whole_tmp(Ca_baseline_locations_wrt_whole_index(1))];
        end
        no_baseline=size(Ca_baseline_all,1);
        plot(Ca_baseline_time_all,Ca_baseline_all,'gd','MarkerSize',8,'MarkerFacecolor','g');

        number_of_cycles_total=size(Ca_peaks_all_locations,1);
        cycles_to_include=[number_cycles_to_exclude+1,number_of_cycles_total-number_cycles_to_exclude];

        %
        %%%%%%%%%%%% Extract baseline ratio%%%%%%%%%%%%%%%%%%
        % Exclude the 1st and last cycle
        Ca_baseline_all_reduc=Ca_baseline_all(cycles_to_include(1):cycles_to_include(end));
        Ca_baseline_all_reduc_mean=mean(Ca_baseline_all_reduc);
        Ca_baseline_all_reduc_std=std(Ca_baseline_all_reduc);

        %%%%%%%%%%%% Extract the amplitude %%%%%%%%%%%%%%%%
        Ca_peaks_all_reduc=Ca_peaks_all(cycles_to_include(1):cycles_to_include(end));
        if no_peaks==no_baseline
            Ca_amplitude_all_reduc=Ca_peaks_all_reduc-Ca_baseline_all_reduc;
        end
        Ca_amplitude_all_reduc_mean=mean(Ca_amplitude_all_reduc);
        Ca_amplitude_all_reduc_std=std(Ca_amplitude_all_reduc);

        %%%%%%%%%%%% Extract peak to peak duration %%%%%%%%%%%%%%%%%%
        % Calculate the duration between peaks
        p_p_durations=diff(Ca_peaks_all_time);
        % Exclude the 1st and last cycle
        p_p_durations_all_reduc=p_p_durations(cycles_to_include(1):cycles_to_include(end));
        p_p_durations_all_reduc_mean=mean(p_p_durations_all_reduc);
        p_p_durations_all_reduc_std=std(p_p_durations_all_reduc);

        %%%%%%%%%%%% Extract time-to-peak %%%%%%%%%%%%%%%%%%
        % Time-to-peak is difference between peak time and current baseline time
        Ca_peaks_all_time_reduc=Ca_peaks_all_time(cycles_to_include(1):cycles_to_include(end));
        Ca_baseline_time_all_reduc=Ca_baseline_time_all(cycles_to_include(1):cycles_to_include(end));
        Ca_time_to_peak_all_reduc=Ca_peaks_all_time_reduc-Ca_baseline_time_all_reduc;
        Ca_time_to_peak_all_reduc_mean=mean(Ca_time_to_peak_all_reduc);
        Ca_time_to_peak_all_reduc_std=std(Ca_time_to_peak_all_reduc);


        %%%%%%%%%%%% Extract half-decay time & tau %%%%%%%%%%%%%%%%%%
        half_decay_time_all=[];
        time_constant_decay_all=[];
        for i=cycles_to_include(1):(cycles_to_include(end)-1)
            % Isolate individual cycle
            time_decay_per_cycle=time(Ca_peaks_all_locations(i):(Ca_baseline_locations_wrt_whole_all(i+1)));
            Ca_decay_per_cycle=Ca(Ca_peaks_all_locations(i):(Ca_baseline_locations_wrt_whole_all(i+1)));
            %%%%%%%%%%%%%%%%% half-decay time %%%%%%%%%%%%%%%%%
            % Find half-decay value
            half_decay_magnitude=Ca_decay_per_cycle(end)+(Ca_decay_per_cycle(1)-Ca_decay_per_cycle(end))/2;
            % Calculate the difference between actual signal and half-decay
            % magnitude
            half_decay_diff=abs(Ca_decay_per_cycle-half_decay_magnitude);
            half_decay_index=find(half_decay_diff==min(half_decay_diff));
            half_decay_time=time_decay_per_cycle(half_decay_index(1))-time_decay_per_cycle(1);
            half_decay_time_all=[half_decay_time_all;half_decay_time];
            plot(time_decay_per_cycle(half_decay_index(1)),Ca_decay_per_cycle(half_decay_index(1)),'cd','MarkerSize',8,'MarkerFaceColor','c');
            %{
            %%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%%
            % Calculate time constant by finding the time taken to let the signal fall 37%
            Ca_time_constant=(Ca_decay_per_cycle(1)-Ca_decay_per_cycle(end))*0.37+Ca_decay_per_cycle(end);
            Ca_time_constant_diff=abs(Ca_decay_per_cycle-Ca_time_constant);
            Ca_time_constant_index=find(Ca_time_constant_diff==min(Ca_time_constant_diff));
            time_constant_decay=time_decay_per_cycle(Ca_time_constant_index)-time_decay_per_cycle(1);
            time_constant_decay_all=[time_constant_decay_all;time_constant_decay];
            plot(time_decay_per_cycle(Ca_time_constant_index),Ca_time_constant,'md','MarkerSize',8,'MarkerFaceColor','m');
            % Calculate time constant by fitting an exponential function
           
            %%%%%%%%%%%%%%%%% tau %%%%%%%%%%%%%%%%%
            % Offset Ca based on the minimum value
            Ca_decay_per_cycle_offset=Ca_decay_per_cycle-min(Ca_decay_per_cycle);
            f = fit(time_decay_per_cycle,Ca_decay_per_cycle_offset,'exp1');
            exp_fit=coeffvalues(f);
            Ca_decay_per_cycle_model=exp_fit(1)*exp(exp_fit(2)*time_decay_per_cycle)+min(Ca_decay_per_cycle);
            plot(time_decay_per_cycle,Ca_decay_per_cycle_model,'r-','LineWidth',2);
            % Calculate the time taken to reach 37% (1/e) of the magnitude
            time_constant_decay=1/(-exp_fit(2));
            time_constant_decay_all=[time_constant_decay_all;time_constant_decay];
             %}
        end
        half_decay_time_all_reduc_mean=mean(half_decay_time_all);
        half_decay_time_all_reduc_std=std(half_decay_time_all);
        %time_constant_decay_all_reduc_mean=mean(time_constant_decay_all);
        %time_constant_decay_all_reduc_std=std(time_constant_decay_all);

        %%%%%%%%%% Write output to figure %%%%%%%%
        str={[' Amplitude : ',num2str(Ca_amplitude_all_reduc_mean),' +/- ',num2str(Ca_amplitude_all_reduc_std)],...
             [' Peak-Peak interval : ',num2str(p_p_durations_all_reduc_mean), ' +/- ',num2str(p_p_durations_all_reduc_std)]
             [' Time-to-peak : ',num2str(Ca_time_to_peak_all_reduc_mean),' +/- ',num2str(Ca_time_to_peak_all_reduc_std)],...
             [' Half-decay time : ',num2str(half_decay_time_all_reduc_mean),' +/- ',num2str(half_decay_time_all_reduc_std)]};
        dim = [0.8 0.01 0.4 0.2];
        annotation('textbox',dim,'String',str,'FitBoxToText','on');
        output_screenshots=[sub_output_folder,'/Signal_Cell_Number_',num2str(c)];
        print(current_figure,output_screenshots,'-dpng');

        %%%%%%%%%% Write the output %%%%%%%%%%%
        Ca_properties_all_per_cell=[c,Ca_amplitude_all_reduc_mean, Ca_amplitude_all_reduc_std, ...
                                                     p_p_durations_all_reduc_mean, p_p_durations_all_reduc_std, ...
                                                     Ca_time_to_peak_all_reduc_mean, Ca_time_to_peak_all_reduc_std, ...
                                                     half_decay_time_all_reduc_mean, half_decay_time_all_reduc_std];
                                                 %  time_constant_decay_all_reduc_mean, time_constant_decay_all_reduc_std

        Ca_properties_all=[Ca_properties_all;Ca_properties_all_per_cell];
        %}
        clf;
    end
end

    
    %%%%%%%%%%% Write the output to file %%%%%%%%
    filenamew=[sub_output_folder,'/Ca_properties.txt'];
    header={'Cell_number','Amplitude_average','Amplitude_std',...
              'P-P_interval_average','P-P_interval_std','Time_to_peak_average','Time_to_peak_std',...
              'Half-decay_time_average','Half-dacay_time_std'};
    Output_quantities=[cellstr(header);num2cell(Ca_properties_all)];
    output = cell2table(Output_quantities);
    writetable(output,filenamew,'WriteVariableNames',false,'Delimiter','tab');
    %xlswrite(filenamew,Output_quantities);


return