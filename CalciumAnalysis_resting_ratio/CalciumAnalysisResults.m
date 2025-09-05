function CalciumAnalysisResults(Calc_main)

    calc_init_user_adj_profile=getappdata(0,'calc_init_user_adj_profile');
    calc_init_user_framerate=getappdata(0,'calc_init_user_framerate');    
    min_Nframes=getappdata(0,'min_Nframes');
    
    %create new window for parameter
    %fig size
    figsize=[680,1300];
    %get screen size
    screensize = get(0,'ScreenSize');
    %position fig on center of screen
    xpos = ceil((screensize(3)-figsize(2))/2);
    ypos = ceil((screensize(4)-figsize(1))/2);
    %create fig; invisible at first
    Calc_Auto(1).fig=figure(...
        'position',[xpos, ypos, figsize(2), figsize(1)],...
        'units','pixels',...
        'renderer','OpenGL',...
        'MenuBar','none',...
        'PaperPositionMode','auto',...
        'Name','Automatic Results',...
        'NumberTitle','off',...
        'Resize','off',...
        'Color',[.2,.2,.2],...
        'visible','off');

    pcolor = [.2 .2 .2];
    ptcolor = [1 1 1];
    bcolor = [.3 .3 .3];
    btcolor = [1 1 1];
    Calc_Auto(1).ForegroundColor = ptcolor;
    Calc_Auto(1).BackgroundColor = pcolor;

    %uipanel for overall signal
    Calc_Auto(1).panel_signal = uipanel('Parent',Calc_Auto(1).fig,'Title','Input Signal','units','pixels','Position',[20,20,600,500],'BorderType','none');
    Calc_Auto(1).panel_signal.ForegroundColor = ptcolor;
    Calc_Auto(1).panel_signal.BackgroundColor = pcolor;
    Calc_Auto(1).axes_signal = axes('Parent',Calc_Auto(1).panel_signal,'Units', 'pixels','Position',[5,50,500,400],'box','on');

    %uipanel for average peak
    Calc_Auto(1).panel_peak = uipanel('Parent',Calc_Auto(1).fig,'Title','Average Peak','units','pixels','Position',[640,20,600,275],'BorderType','none');
    Calc_Auto(1).panel_peak.ForegroundColor = ptcolor;
    Calc_Auto(1).panel_peak.BackgroundColor = pcolor;
    Calc_Auto(1).axes_peak = axes('Parent',Calc_Auto(1).panel_peak,'Units', 'pixels','Position',[5,5,500,250],'box','on');

    %uipanel for all peaks
    Calc_Auto(1).panel_all_peaks = uipanel('Parent',Calc_Auto(1).fig,'Title','All Peaks','units','pixels','Position',[640,300,600,275],'BorderType','none');
    Calc_Auto(1).panel_all_peaks.ForegroundColor = ptcolor;
    Calc_Auto(1).panel_all_peaks.BackgroundColor = pcolor;
    Calc_Auto(1).axes_all_peaks = axes('Parent',Calc_Auto(1).panel_all_peaks,'Units', 'pixels','Position',[5,5,500,250],'box','on');
   
    %text 1: show which video (i/n)
    numVids = size(calc_init_user_adj_profile,1);
    Calc_Auto(1).text_whichvid = uicontrol('Parent',Calc_Auto(1).fig,'style','text','position',[550,575,50,15],'string',['(1/',num2str(numVids),')'],'HorizontalAlignment','left');
    Calc_Auto(1).text_whichvid.ForegroundColor = ptcolor;
    Calc_Auto(1).text_whichvid.BackgroundColor = pcolor;
    
    %text 2: show peak duration av
    Calc_Auto(1).text_peak_duration_av = uicontrol('Parent',Calc_Auto(1).fig,'style','text','position',[1150,535,150,15],'string','Peak Duration Av (s): ','HorizontalAlignment','left');
    Calc_Auto(1).text_peak_duration_av.ForegroundColor = ptcolor;
    Calc_Auto(1).text_peak_duration_av.BackgroundColor = pcolor;

    %text 3: show peak duration std
    Calc_Auto(1).text_peak_duration_std = uicontrol('Parent',Calc_Auto(1).fig,'style','text','position',[1150,495,150,15],'string','Peak Duration Std (s): ','HorizontalAlignment','left');
    Calc_Auto(1).text_peak_duration_std.ForegroundColor = ptcolor;
    Calc_Auto(1).text_peak_duration_std.BackgroundColor = pcolor;

    %text 4: show time to peak av
    Calc_Auto(1).text_time_to_peak_av = uicontrol('Parent',Calc_Auto(1).fig,'style','text','position',[1150,455,150,15],'string','Time To Peak Av (s): ','HorizontalAlignment','left');
    Calc_Auto(1).text_time_to_peak_av.ForegroundColor = ptcolor;
    Calc_Auto(1).text_time_to_peak_av.BackgroundColor = pcolor;

    %text 5: show time to peak std
    Calc_Auto(1).text_time_to_peak_std = uicontrol('Parent',Calc_Auto(1).fig,'style','text','position',[1150,415,150,15],'string','Time To Peak Std (s): ','HorizontalAlignment','left');
    Calc_Auto(1).text_time_to_peak_std.ForegroundColor = ptcolor;
    Calc_Auto(1).text_time_to_peak_std.BackgroundColor = pcolor;
   
    %text 6: show amplitude av
    Calc_Auto(1).text_amplitude_av = uicontrol('Parent',Calc_Auto(1).fig,'style','text','position',[1150,375,150,15],'string','Amplitude Av (a.u.): ','HorizontalAlignment','left');
    Calc_Auto(1).text_amplitude_av.ForegroundColor = ptcolor;
    Calc_Auto(1).text_amplitude_av.BackgroundColor = pcolor;

    %text 7: show amplitude std
    Calc_Auto(1).text_amplitude_std = uicontrol('Parent',Calc_Auto(1).fig,'style','text','position',[1150,335,150,15],'string','Amplitude Std (a.u.): ','HorizontalAlignment','left');
    Calc_Auto(1).text_amplitude_std.ForegroundColor = ptcolor;
    Calc_Auto(1).text_amplitude_std.BackgroundColor = pcolor;

    %text 8: show frequency
    Calc_Auto(1).text_frequency = uicontrol('Parent',Calc_Auto(1).fig,'style','text','position',[1150,295,150,15],'string','Frequency (1/s): ','HorizontalAlignment','left');
    Calc_Auto(1).text_frequency.ForegroundColor = ptcolor;
    Calc_Auto(1).text_frequency.BackgroundColor = pcolor;

    %text 9: show num peaks
    Calc_Auto(1).text_num_peaks = uicontrol('Parent',Calc_Auto(1).fig,'style','text','position',[1150,255,150,15],'string','Number Of Peaks: ','HorizontalAlignment','left');
    Calc_Auto(1).text_num_peaks.ForegroundColor = ptcolor;
    Calc_Auto(1).text_num_peaks.BackgroundColor = pcolor;
    
    %edit 1: peak duration av
    Calc_Auto(1).edit_peak_duration_av = uicontrol('Parent',Calc_Auto(1).fig,'style','edit','position',[1150,515,125,15],'HorizontalAlignment','center','Enable','off');
    %edit 2: peak duration std
    Calc_Auto(1).edit_peak_duration_std = uicontrol('Parent',Calc_Auto(1).fig,'style','edit','position',[1150,475,125,15],'HorizontalAlignment','center','Enable','off');
    %edit 3: time to peak av
    Calc_Auto(1).edit_time_to_peak_av = uicontrol('Parent',Calc_Auto(1).fig,'style','edit','position',[1150,435,125,15],'HorizontalAlignment','center','Enable','off');
    %edit 4: time to peak std
    Calc_Auto(1).edit_time_to_peak_std = uicontrol('Parent',Calc_Auto(1).fig,'style','edit','position',[1150,395,125,15],'HorizontalAlignment','center','Enable','off');
    %edit 5: amplitude av
    Calc_Auto(1).edit_amplitude_av = uicontrol('Parent',Calc_Auto(1).fig,'style','edit','position',[1150,355,125,15],'HorizontalAlignment','center','Enable','off');
    %edit 6: peak amplitude std
    Calc_Auto(1).edit_amplitude_std = uicontrol('Parent',Calc_Auto(1).fig,'style','edit','position',[1150,315,125,15],'HorizontalAlignment','center','Enable','off');
    %edit 7: frequency
    Calc_Auto(1).edit_frequency = uicontrol('Parent',Calc_Auto(1).fig,'style','edit','position',[1150,275,125,15],'HorizontalAlignment','center','Enable','off');
    %edit 8: num peaks
    Calc_Auto(1).edit_num_peaks = uicontrol('Parent',Calc_Auto(1).fig,'style','edit','position',[1150,235,125,15],'HorizontalAlignment','center','Enable','off');
  
    %button 1: forwards
    Calc_Auto(1).button_forwards = uicontrol('Parent',Calc_Auto(1).fig,'style','pushbutton','position',[650,575,25,25],'string','>');
    %button 2: backwards
    Calc_Auto(1).button_backwards = uicontrol('Parent',Calc_Auto(1).fig,'style','pushbutton','position',[450,575,25,25],'string','<');
    %button 3: ok
    Calc_Auto(1).button_ok = uicontrol('Parent',Calc_Auto(1).fig,'style','pushbutton','position',[1200,575,100,20],'string','OK','visible','on','enable','off');
    %button 4: add min
    Calc_Auto(1).button_add_min = uicontrol('Parent',Calc_Auto(1).fig,'style','pushbutton','position',[75,575,75,25],'string','Add min');
    %button 5: add max
    Calc_Auto(1).button_add_max = uicontrol('Parent',Calc_Auto(1).fig,'style','pushbutton','position',[150,575,75,25],'string','Add max');
    %button 6: select poi
    Calc_Auto(1).button_select_poi = uicontrol('Parent',Calc_Auto(1).fig,'style','pushbutton','position',[250,575,75,25],'string','Select poi');
 
    Calc_Auto(1).buttongroup_type = uibuttongroup('Parent',Calc_Auto(1).fig,'Units', 'pixels','Position',[750,575,200,25]);
    %radiobutton 1: auto
    Calc_Auto(1).radiobutton_auto = uicontrol('Parent',Calc_Auto(1).buttongroup_type,'style','radiobutton','position',[1,0,75,25],'string','Auto','tag','radiobutton_auto','value',1);
    %radiobutton 2: manual
    Calc_Auto(1).radiobutton_manual = uicontrol('Parent',Calc_Auto(1).buttongroup_type,'style','radiobutton','position',[100,0,75,25],'string','Manual','tag','radiobutton_manual','value',0);
    
    Calc_Auto(1).buttongroup_qual = uibuttongroup('Parent',Calc_Auto(1).fig,'Units', 'pixels','Position',[400,625,400,40]);
    %radiobutton 1: class1 trace
    Calc_Auto(1).radiobutton_class1 = uicontrol('Parent',Calc_Auto(1).buttongroup_qual,'style','radiobutton','position',[1,1,75,30],'string','Class I','tag','radiobutton_class1','value',0);
    %radiobutton 2: class2 trace
    Calc_Auto(1).radiobutton_class2 = uicontrol('Parent',Calc_Auto(1).buttongroup_qual,'style','radiobutton','position',[100,1,75,30],'string','Class II','tag','radiobutton_class2','value',0);
    %radiobutton 3: class3 trace
    Calc_Auto(1).radiobutton_class2_plus = uicontrol('Parent',Calc_Auto(1).buttongroup_qual,'style','radiobutton','position',[200,1,75,30],'string','Class III','tag','radiobutton_class3','value',0);
    %radiobutton 3: noisy trace
    Calc_Auto(1).radiobutton_noise = uicontrol('Parent',Calc_Auto(1).buttongroup_qual,'style','radiobutton','position',[300,1,75,30],'string','Noise','tag','radiobutton_noise','value',0);
   
    set(Calc_Auto(1).button_forwards,'callback',{@results_push_forwards_backwards,Calc_Auto,'forwards','auto'})
    set(Calc_Auto(1).button_backwards,'callback',{@results_push_forwards_backwards,Calc_Auto,'backwards','auto'})
    set(Calc_Auto(1).button_ok,'callback',{@results_push_ok,Calc_Auto,'auto'})
    set(Calc_Auto(1).buttongroup_qual,'SelectionChangeFcn',{@select_buttongroup_type_qual,Calc_Auto})    
    set(Calc_Auto(1).button_add_min,'callback',{@results_push_add_pts,Calc_Auto,'min','auto'})
    set(Calc_Auto(1).button_add_max,'callback',{@results_push_add_pts,Calc_Auto,'max','auto'})
    set(Calc_Auto(1).button_select_poi,'callback',{@results_push_select_poi,Calc_Auto})
    set(Calc_Auto(1).buttongroup_type,'SelectionChangeFcn',{@results_push_switch_type,Calc_Auto})
    
    %perform automatic calculation for all videos 
    calc_results_user_signal = cell(size(calc_init_user_adj_profile));
    calc_results_user_peak = cell(size(calc_init_user_adj_profile));
    calc_results_user_amplitude = cell(size(calc_init_user_adj_profile));
    calc_results_user_amplitude_std = cell(size(calc_init_user_adj_profile));
    calc_results_user_peak_duration = cell(size(calc_init_user_adj_profile));
    calc_results_user_peak_duration_std = cell(size(calc_init_user_adj_profile));
    calc_results_user_time_to_peak = cell(size(calc_init_user_adj_profile));
    calc_results_user_time_to_peak_std = cell(size(calc_init_user_adj_profile));
    calc_results_user_delay_time = cell(size(calc_init_user_adj_profile));
    calc_results_user_delay_time_std = cell(size(calc_init_user_adj_profile));
    calc_results_user_frequency = cell(size(calc_init_user_adj_profile));
    calc_results_user_npeaks = cell(size(calc_init_user_adj_profile));
    calc_results_user_poi = cell(size(calc_init_user_adj_profile));
    calc_results_user_maxs = cell(size(calc_init_user_adj_profile));
    calc_results_user_mins = cell(size(calc_init_user_adj_profile));
    calc_results_user_max_values = cell(size(calc_init_user_adj_profile));
    calc_results_user_min_values = cell(size(calc_init_user_adj_profile));
    calc_results_user_display_peaks = cell(size(calc_init_user_adj_profile));
    calc_results_user_analysis_type = zeros(size(calc_init_user_adj_profile));
    calc_results_user_amplitude_av_manual = cell(size(calc_init_user_adj_profile));
    calc_results_user_amplitude_std_manual = cell(size(calc_init_user_adj_profile));
    calc_results_user_peak_duration_av_manual = cell(size(calc_init_user_adj_profile));
    calc_results_user_peak_duration_std_manual = cell(size(calc_init_user_adj_profile));
    calc_results_user_time_to_peak_av_manual = cell(size(calc_init_user_adj_profile));
    calc_results_user_time_to_peak_std_manual = cell(size(calc_init_user_adj_profile));
    calc_results_user_delay_time_av_manual = cell(size(calc_init_user_adj_profile));
    calc_results_user_delay_time_std_manual = cell(size(calc_init_user_adj_profile));
    calc_results_user_frequency_manual = cell(size(calc_init_user_adj_profile));
    calc_results_user_npeaks_manual = cell(size(calc_init_user_adj_profile));
    for ivid = 1:numVids
        times = (1:min_Nframes)/calc_init_user_framerate(ivid);
        if times(end) > 10
            calc_results_user_poi{ivid} = [times(end)/2 - 5, times(end)/2 + 5];
        else
            calc_results_user_poi{ivid} = [times(end)/4, 3*times(end)/4];
        end 
        frames_poi = round(calc_results_user_poi{ivid} * calc_init_user_framerate(ivid));
        [s,p_av,stats] = signalAnalysis(times(frames_poi(1):frames_poi(2)), ...
             calc_init_user_adj_profile{ivid}(frames_poi(1):frames_poi(2)), ...
             calc_init_user_framerate(ivid), 0);
        %calc_results_user_signal{ivid} = s.fsignal;
        calc_results_user_signal{ivid} = calc_init_user_adj_profile{ivid};
        calc_results_user_peak{ivid} = p_av.av_peak;
        calc_results_user_amplitude{ivid} = stats.amplitude_av;
        calc_results_user_amplitude_std{ivid} = stats.amplitude_std;
        calc_results_user_peak_duration{ivid} = stats.peak_duration_av;
        calc_results_user_peak_duration_std{ivid} = stats.peak_duration_std;
        calc_results_user_time_to_peak{ivid} = stats.time_to_peak_av;
        calc_results_user_time_to_peak_std{ivid} = stats.time_to_peak_std;
        calc_results_user_delay_time{ivid} = stats.delay_time_av;
        calc_results_user_delay_time_std{ivid} = stats.delay_time_std;
        calc_results_user_frequency{ivid} = p_av.n_peaks / (calc_results_user_poi{ivid}(2) - calc_results_user_poi{ivid}(1));
        calc_results_user_npeaks{ivid} = p_av.n_peaks;
        if ~isnan(s.pd_xcorr_peaks_lags)
            calc_results_user_display_peaks{ivid} = stats.display_peaks;
        end
        calc_results_user_maxs{ivid} = [];
        calc_results_user_max_values{ivid} = [];
        calc_results_user_mins{ivid} = [];
        calc_results_user_min_values{ivid} = [];
    end
    calc_results_user_qual = zeros(size(calc_results_user_frequency));
    setappdata(0,'calc_results_user_signal',calc_results_user_signal);
    setappdata(0,'calc_results_user_peak',calc_results_user_peak);
    setappdata(0,'calc_results_user_amplitude',calc_results_user_amplitude);
    setappdata(0,'calc_results_user_amplitude_std',calc_results_user_amplitude_std);
    setappdata(0,'calc_results_user_peak_duration',calc_results_user_peak_duration);
    setappdata(0,'calc_results_user_peak_duration_std',calc_results_user_peak_duration_std);
    setappdata(0,'calc_results_user_time_to_peak',calc_results_user_time_to_peak);    
    setappdata(0,'calc_results_user_time_to_peak_std',calc_results_user_time_to_peak_std);
    setappdata(0,'calc_results_user_delay_time',calc_results_user_delay_time);
    setappdata(0,'calc_results_user_delay_time_std',calc_results_user_delay_time_std);
    setappdata(0,'calc_results_user_frequency',calc_results_user_frequency);
    setappdata(0,'calc_results_user_npeaks',calc_results_user_npeaks);
    setappdata(0,'calc_results_user_qual',calc_results_user_qual);
    setappdata(0,'calc_results_user_display_peaks',calc_results_user_display_peaks);
    setappdata(0,'calc_results_user_analysis_type',calc_results_user_analysis_type);
    setappdata(0,'calc_results_user_maxs',calc_results_user_maxs);
    setappdata(0,'calc_results_user_max_values',calc_results_user_max_values);
    setappdata(0,'calc_results_user_mins',calc_results_user_mins);
    setappdata(0,'calc_results_user_min_values',calc_results_user_min_values);
    setappdata(0,'calc_results_user_poi',calc_results_user_poi);
    setappdata(0,'calc_results_user_peak_duration_av_manual',calc_results_user_peak_duration_av_manual);
    setappdata(0,'calc_results_user_peak_duration_std_manual',calc_results_user_peak_duration_std_manual);
    setappdata(0,'calc_results_user_time_to_peak_av_manual', calc_results_user_time_to_peak_av_manual);
    setappdata(0,'calc_results_user_time_to_peak_std_manual',calc_results_user_time_to_peak_std_manual);
    setappdata(0,'calc_results_user_delay_time_av_manual', calc_results_user_delay_time_av_manual);
    setappdata(0,'calc_results_user_delay_time_std_manual', calc_results_user_delay_time_std_manual);
    setappdata(0,'calc_results_user_amplitude_av_manual',calc_results_user_amplitude_av_manual);
    setappdata(0,'calc_results_user_amplitude_std_manual',calc_results_user_amplitude_std_manual);
    setappdata(0,'calc_results_user_frequency_manual',calc_results_user_frequency_manual);
    setappdata(0,'calc_results_user_npeaks_manual',calc_results_user_npeaks_manual);
    calc_results_user_counter = 1;
    setappdata(0,'calc_results_user_counter',calc_results_user_counter);
   
    %display results
    display_results(Calc_Auto, 'peak');
    display_results(Calc_Auto, 'signal');
    
    set(Calc_Auto(1).button_backwards,'enable','off');
    if numVids == 1
        set(Calc_Auto(1).button_forwards,'enable','off');
    end
    
    if isempty(calc_results_user_peak{calc_results_user_counter})
        figuresize=[40,450];
        screensize=get(0,'ScreenSize');
        xpos = ceil((screensize(3)-figuresize(2))/2);
        ypos = ceil((screensize(4)-figuresize(1))/2);
        %create figure
        autoFailWarning.fig=figure(...
            'position',[xpos, ypos, figuresize(2), figuresize(1)],...
            'units','pixels',...
            'renderer','OpenGL',...
            'MenuBar','none',...
            'PaperPositionMode','auto',...
            'Name','Warning',...
            'NumberTitle','off',...
            'Resize','off',...
            'Color','w',...
            'Visible','off');
        annotation('textbox',[0.1 0.1 0.8 0.8], 'String', ['Automatic analysis failed for video ', num2str(calc_results_user_counter), '. Add points manually, or try with a different poi.'], 'FitBoxToText', 'on', 'LineStyle', 'none');
        autoFailWarning.fig.Visible='on';
        waitfor(autoFailWarning.fig);
    end
    
    set(Calc_Auto(1).fig,'visible','on');
end

function results_push_forwards_backwards(Object, eventdata, Calc_Auto, flag, label)

    calc_results_user_counter=getappdata(0,'calc_results_user_counter');
    calc_results_user_signal=getappdata(0,'calc_results_user_signal');
    calc_results_user_peak=getappdata(0,'calc_results_user_peak');
    calc_init_user_framerate=getappdata(0,'calc_init_user_framerate');
    calc_results_user_maxs=getappdata(0,'calc_results_user_maxs');
    calc_results_user_mins=getappdata(0,'calc_results_user_mins');
    calc_results_user_min_values=getappdata(0,'calc_results_user_min_values');
    calc_results_user_max_values=getappdata(0,'calc_results_user_max_values');
    calc_results_user_qual=getappdata(0,'calc_results_user_qual');
    calc_results_user_analysis_type=getappdata(0,'calc_results_user_analysis_type');
    min_Nframes=getappdata(0,'min_Nframes');
    
    if strcmp(flag, 'forwards')
        calc_results_user_counter = calc_results_user_counter + 1;
    else
        calc_results_user_counter = calc_results_user_counter - 1;
    end
   
    if calc_results_user_qual(calc_results_user_counter) == 0
        set(Calc_Auto(1).radiobutton_class1, 'value', 1);
        set(Calc_Auto(1).radiobutton_class2, 'value', 0);
        set(Calc_Auto(1).radiobutton_class2_plus, 'value', 0);
        set(Calc_Auto(1).radiobutton_noise, 'value', 0);
    elseif calc_results_user_qual(calc_results_user_counter) == 1
        set(Calc_Auto(1).radiobutton_class1, 'value', 0);
        set(Calc_Auto(1).radiobutton_class2, 'value', 1);
        set(Calc_Auto(1).radiobutton_class2_plus, 'value', 0);
        set(Calc_Auto(1).radiobutton_noise, 'value', 0);
    elseif calc_results_user_qual(calc_results_user_counter) == 2
        set(Calc_Auto(1).radiobutton_class1, 'value', 0);
        set(Calc_Auto(1).radiobutton_class2, 'value', 0);
        set(Calc_Auto(1).radiobutton_class2_plus, 'value', 1);
        set(Calc_Auto(1).radiobutton_noise, 'value', 0);
    elseif calc_results_user_qual(calc_results_user_counter) == 3
        set(Calc_Auto(1).radiobutton_class1, 'value', 0);
        set(Calc_Auto(1).radiobutton_class2, 'value', 0);
        set(Calc_Auto(1).radiobutton_class2_plus, 'value', 0);
        set(Calc_Auto(1).radiobutton_noise, 'value', 1);
    end
    
    if calc_results_user_analysis_type(calc_results_user_counter) == 0
        set(Calc_Auto(1).radiobutton_auto, 'value', 1);
        set(Calc_Auto(1).radiobutton_manual, 'value', 0);
    elseif calc_results_user_analysis_type(calc_results_user_counter) == 1
        set(Calc_Auto(1).radiobutton_auto, 'value', 0);
        set(Calc_Auto(1).radiobutton_manual, 'value', 1);
    end
       
    set(Calc_Auto(1).text_whichvid,'String',[num2str(calc_results_user_counter),'/',num2str(size(calc_results_user_signal,1))]);
    
    if calc_results_user_counter == size(calc_results_user_signal,1)
        set(Calc_Auto(1).button_forwards,'enable','off');
    else
        set(Calc_Auto(1).button_forwards,'enable','on');
    end
    if calc_results_user_counter == 1
        set(Calc_Auto(1).button_backwards,'enable','off');
    else
        set(Calc_Auto(1).button_backwards,'enable','on');
    end
    if strcmp(flag,'manual')
        if sum(cellfun(@isempty,calc_results_user_maxs)) == 0 && sum(cellfun(@isempty,calc_results_user_peak)) == 0
            set(Calc_Auto(1).button_ok,'enable','on');
        end
    elseif sum(cellfun(@isempty,calc_results_user_peak)) == 0
            set(Calc_Auto(1).button_ok,'enable','on');    
    end
    
    setappdata(0,'calc_results_user_counter',calc_results_user_counter);
    
    %display results
    display_results(Calc_Auto, 'signal');
    
    if strcmp(label, 'auto')
        display_results(Calc_Auto, 'peak');
    end
    
    if isempty(calc_results_user_peak{calc_results_user_counter}) && isempty(calc_results_user_mins{calc_results_user_counter})
        figuresize=[40,450];
        screensize=get(0,'ScreenSize');
        xpos = ceil((screensize(3)-figuresize(2))/2);
        ypos = ceil((screensize(4)-figuresize(1))/2);
        %create figure
        autoFailWarning.fig=figure(...
            'position',[xpos, ypos, figuresize(2), figuresize(1)],...
            'units','pixels',...
            'renderer','OpenGL',...
            'MenuBar','none',...
            'PaperPositionMode','auto',...
            'Name','Warning',...
            'NumberTitle','off',...
            'Resize','off',...
            'Color','w',...
            'Visible','off');
        annotation('textbox',[0.1 0.1 0.8 0.8], 'String', ['Automatic analysis failed for video ', num2str(calc_results_user_counter), '. Add points manually, or try with a different poi.'], 'FitBoxToText', 'on', 'LineStyle', 'none');
        autoFailWarning.fig.Visible='on';
        waitfor(autoFailWarning.fig);
    end
end

function results_push_ok(Object, eventdata, Calc_Auto, flag)

    % process results and save to excel sheets
    calc_results_user_signal=getappdata(0,'calc_results_user_signal');
    calc_results_user_peak=getappdata(0,'calc_results_user_peak'); 
    calc_results_user_amplitude=getappdata(0,'calc_results_user_amplitude');
    calc_results_user_amplitude_std=getappdata(0,'calc_results_user_amplitude_std');
    calc_results_user_peak_duration=getappdata(0,'calc_results_user_peak_duration');
    calc_results_user_peak_duration_std=getappdata(0,'calc_results_user_peak_duration_std');
    calc_results_user_time_to_peak=getappdata(0,'calc_results_user_time_to_peak');    
    calc_results_user_time_to_peak_std=getappdata(0,'calc_results_user_time_to_peak_std');  
    calc_results_user_delay_time=getappdata(0,'calc_results_user_delay_time');
    calc_results_user_delay_time_std=getappdata(0,'calc_results_user_delay_time_std');
    calc_results_user_frequency=getappdata(0,'calc_results_user_frequency');
    calc_results_user_npeaks=getappdata(0,'calc_results_user_npeaks');
    calc_results_user_mins=getappdata(0,'calc_results_user_mins');
    calc_results_user_maxs=getappdata(0,'calc_results_user_maxs');
    calc_results_user_poi=getappdata(0,'calc_results_user_poi');
    calc_results_user_analysis_type=getappdata(0,'calc_results_user_analysis_type');
    calc_init_user_filenamestack=getappdata(0,'calc_init_user_filenamestack');
    calc_init_user_pathnamestack=getappdata(0,'calc_init_user_pathnamestack');
    calc_init_user_framerate=getappdata(0,'calc_init_user_framerate');
    calc_results_user_qual=getappdata(0,'calc_results_user_qual');
    min_Nframes=getappdata(0,'min_Nframes');
    
    curPath = '';
    curPathCount = 1;
    class1_count = 0;
    low_freq_count = 0;
    noise_count = 0;
    f = filesep;
    for ivid = 1:size(calc_results_user_signal,1)
        if strcmp(curPath, calc_init_user_pathnamestack{ivid})
            curPathCount = curPathCount + 1;
        else
            curPath = calc_init_user_pathnamestack{ivid};
            curPathCount = 1;
            class1_count = 0;
        end
        [~, curDir, ~] = fileparts(strip(curPath,f));
        sheet = 'Full Results';
        if strcmp(flag, 'auto')
            newfile=[calc_init_user_pathnamestack{ivid},curDir,'_CalciumResults.xlsx'];
        else
            newfile=[calc_init_user_pathnamestack{ivid},curDir,'_CalciumResultsManual.xlsx'];
        end
        if curPathCount == 1
            xlRange = 'A1';
            xlwrite(newfile,{'Cell', 'Peak duration (s)', 'Peak duration std (s)', 'Time to peak (s)', 'Time to peak std (s)', 'Peak transcience (s)', 'Peak transcience std (s)', 'Peak amplitude (a.u.)', 'Peak amplitude std (a.u.)', 'Peak frequency (1/s)', 'Number of peaks', 'Qualitative description', 'Mean min', 'Std min', 'Mean max', 'Std max'},sheet,xlRange);
            sheet = 'Class I Trace Results';
            xlwrite(newfile,{'Cell', 'Peak duration (s)', 'Peak duration std (s)', 'Time to peak (s)', 'Time to peak std (s)', 'Peak transcience (s)', 'Peak transcience std (s)', 'Peak amplitude (a.u.)', 'Peak amplitude std (a.u.)', 'Peak frequency (1/s)', 'Number of peaks', 'Qualitative description', 'Mean min', 'Std min', 'Mean max', 'Std max'},sheet,xlRange);
            sheet = 'Noise';
            xlwrite(newfile,{'Cell', 'Peak duration (s)', 'Peak duration std (s)', 'Time to peak (s)', 'Time to peak std (s)', 'Peak transcience (s)', 'Peak transcience std (s)', 'Peak amplitude (a.u.)', 'Peak amplitude std (a.u.)', 'Peak frequency (1/s)', 'Number of peaks', 'Qualitative description', 'Mean min', 'Std min', 'Mean max', 'Std max'},sheet,xlRange);            
            sheet = 'Full Results';
        end
        if strcmp(flag,'auto') && ~calc_results_user_analysis_type(ivid)
%             [~, peakLoc] = max(calc_results_user_peak{ivid});
%             findMinFirstHalf = calc_results_user_peak{ivid}(1:peakLoc);
%             [~, firstMinLoc] = min(findMinFirstHalf);
%             findMinFirstHalf = calc_results_user_peak{ivid}(peakLoc:size(calc_results_user_peak{ivid},1));
%             [~, secondMinLoc] = min(findMinFirstHalf);
%             secondMinLoc = secondMinLoc + peakLoc - 1;
%             peakDuration = (secondMinLoc - firstMinLoc) / calc_init_user_framerate(ivid);
%             timeToPeak = (peakLoc - firstMinLoc) / calc_init_user_framerate(ivid);
            peakDuration = calc_results_user_peak_duration{ivid} / calc_init_user_framerate(ivid);
            peakDurationStd = calc_results_user_peak_duration_std{ivid} / calc_init_user_framerate(ivid);
            timeToPeak = calc_results_user_time_to_peak{ivid} / calc_init_user_framerate(ivid);
            timeToPeakStd = calc_results_user_time_to_peak_std{ivid} / calc_init_user_framerate(ivid);
            delayTime = calc_results_user_delay_time{ivid} / calc_init_user_framerate(ivid);
            delayTimeStd = calc_results_user_delay_time_std{ivid} / calc_init_user_framerate(ivid);
            amplitude = calc_results_user_amplitude{ivid};
            amplitudeStd = calc_results_user_amplitude_std{ivid};
            frequency = calc_results_user_frequency{ivid};
            nPeaks = calc_results_user_npeaks{ivid};
        else
            %update mins and maxs to only fall in poi
            calc_results_user_mins{ivid} = calc_results_user_mins{ivid}(calc_results_user_mins{ivid} > calc_results_user_poi{ivid}(1) * calc_init_user_framerate(ivid));
            calc_results_user_mins{ivid} = calc_results_user_mins{ivid}(calc_results_user_mins{ivid} < calc_results_user_poi{ivid}(2) * calc_init_user_framerate(ivid));
            calc_results_user_maxs{ivid} = calc_results_user_maxs{ivid}(calc_results_user_maxs{ivid} > calc_results_user_poi{ivid}(1) * calc_init_user_framerate(ivid));
            calc_results_user_maxs{ivid} = calc_results_user_maxs{ivid}(calc_results_user_maxs{ivid} < calc_results_user_poi{ivid}(2) * calc_init_user_framerate(ivid));
            
            offset = 0;
            peakDurations = nan(size(calc_results_user_mins{ivid},1), 1);
            timeToPeaks = nan(size(calc_results_user_mins{ivid},1), 1);
            delayTimes = nan(size(calc_results_user_mins{ivid},1), 1);
            amplitudes = nan(size(calc_results_user_mins{ivid},1), 1);
            nPeaks = 0;
            calc_results_user_mins{ivid} = sort(calc_results_user_mins{ivid});
            calc_results_user_maxs{ivid} = sort(calc_results_user_maxs{ivid});
            for ipeak = 1:size(calc_results_user_mins{ivid},1)
                if ipeak > 1
                    peakDurations(ipeak) = calc_results_user_mins{ivid}(ipeak) - calc_results_user_mins{ivid}(ipeak - 1);
                    nPeaks = nPeaks + 1;
                end
                while ipeak + offset <= size(calc_results_user_maxs{ivid},1) && calc_results_user_maxs{ivid}(ipeak + offset) < calc_results_user_mins{ivid}(ipeak)
                    offset = offset + 1;
                end
                if ipeak + offset <= size(calc_results_user_maxs{ivid},1)
                    imin = calc_results_user_mins{ivid}(ipeak);
                    imax = calc_results_user_maxs{ivid}(ipeak + offset);
                    if ipeak < size(calc_results_user_mins{ivid},1)
                        iMinNext = calc_results_user_mins{ivid}(ipeak + 1);
                        delayTimes(ipeak) = iMinNext - imax;
                    end
                    timeToPeaks(ipeak) = imax - imin;                 
                    amplitudes(ipeak) = calc_results_user_signal{ivid}(imax) - calc_results_user_signal{ivid}(imin);
                end
            end
            peakDurations = peakDurations / calc_init_user_framerate(ivid);
            timeToPeaks = timeToPeaks / calc_init_user_framerate(ivid);
            delayTimes = delayTimes / calc_init_user_framerate(ivid);
            peakDuration = nanmean(peakDurations);
            peakDurationStd = nanstd(peakDurations);
            timeToPeak = nanmean(timeToPeaks);
            timeToPeakStd = nanstd(timeToPeaks);
            delayTime = nanmean(delayTimes);
            delayTimeStd = nanstd(delayTimes);
            amplitude = nanmean(amplitudes);
            amplitudeStd = nanstd(amplitudes);
            %time_period = (calc_results_user_poi{ivid}(2) - calc_results_user_poi{ivid}(1)) /  calc_init_user_framerate(ivid);
            %frequency = min(size(calc_results_user_mins{ivid}, 1), size(calc_results_user_maxs{ivid}, 1)) / time_period;
            frequency = size(calc_results_user_maxs{ivid}, 1) / (calc_results_user_poi{ivid}(2) - calc_results_user_poi{ivid}(1));
        end
        
        meanMin = nanmean(calc_results_user_signal{ivid}(calc_results_user_mins{ivid}));
        stdMin = nanstd(calc_results_user_signal{ivid}(calc_results_user_mins{ivid}));
        meanMax = nanmean(calc_results_user_signal{ivid}(calc_results_user_maxs{ivid}));
        stdMax = nanstd(calc_results_user_signal{ivid}(calc_results_user_maxs{ivid}));
        
        if calc_results_user_qual(ivid) == 0
            qual_description = 'class1';
        elseif calc_results_user_qual(ivid) == 1
            qual_description = 'class2';
        elseif calc_results_user_qual(ivid) == 2
            qual_description = 'class3';
        else
            qual_description = 'noise';
        end
        if frequency >= 0
            if calc_results_user_qual(ivid) == 3
                noise_count = noise_count + 1;
                sheet = 'Noise';
                xlRange = ['A',num2str(noise_count + 1)];
                xlwrite(newfile,{num2str(ivid), peakDuration, peakDurationStd, timeToPeak, timeToPeakStd, delayTime, delayTimeStd, amplitude, amplitudeStd, frequency, nPeaks, qual_description, meanMin, stdMin, meanMax, stdMax},sheet,xlRange);
            end
            xlRange = ['A',num2str(curPathCount + 1 - low_freq_count - noise_count)];
            xlwrite(newfile,{num2str(ivid), peakDuration, peakDurationStd, timeToPeak, timeToPeakStd, delayTime, delayTimeStd, amplitude, amplitudeStd, frequency, nPeaks, qual_description, meanMin, stdMin, meanMax, stdMax},sheet,xlRange);
            if calc_results_user_qual(ivid) == 0
                class1_count = class1_count + 1;
                sheet = 'Class I Trace Results';
                xlRange = ['A',num2str(class1_count + 1)];
                xlwrite(newfile,{num2str(ivid), peakDuration, peakDurationStd, timeToPeak, timeToPeakStd, delayTime, delayTimeStd, amplitude, amplitudeStd, frequency, nPeaks, qual_description, meanMin, stdMin, meanMax, stdMax},sheet,xlRange);
            end
        else
            low_freq_count = low_freq_count + 1;
            sheet = 'Noise';
            xlRange = ['A',num2str(low_freq_count + 1)];
            xlwrite(newfile,{num2str(ivid), peakDuration, peakDurationStd, timeToPeak, timeToPeakStd, delayTime, delayTimeStd, amplitude, amplitudeStd, frequency, nPeaks, qual_description, meanMin, stdMin, meanMax, stdMax},sheet,xlRange);
        end
    end
    close(Calc_Auto(1).fig);    
end

function results_push_add_pts(Object, eventdata, gui, flag, call_fnc)
    
    %%TO DO
    % Define region of interest (default middle 10)
    % Remove videos with less than 10 peaks
 
    calc_results_user_counter=getappdata(0,'calc_results_user_counter');
    calc_results_user_signal=getappdata(0,'calc_results_user_signal');
    calc_results_user_peak=getappdata(0,'calc_results_user_peak');
    calc_results_user_display_peaks=getappdata(0,'calc_results_user_display_peaks');
    calc_results_user_mins=getappdata(0,'calc_results_user_mins');
    calc_results_user_maxs=getappdata(0,'calc_results_user_maxs');
    calc_results_user_min_values=getappdata(0,'calc_results_user_min_values');
    calc_results_user_max_values=getappdata(0,'calc_results_user_max_values');
    calc_results_user_poi=getappdata(0,'calc_results_user_poi');
    calc_init_user_framerate=getappdata(0,'calc_init_user_framerate');
    min_Nframes=getappdata(0,'min_Nframes');
    
    figsize=[900,1600];
    %get screen size
    screensize = get(0,'ScreenSize');
    %position fig on center of screen
    xpos = ceil((screensize(3)-figsize(2))/2);
    ypos = ceil((screensize(4)-figsize(1))/2);
    hf=figure('position',[xpos, ypos, figsize(2), figsize(1)],...
        'units','pixels',...
        'renderer','OpenGL');
    times = (1:min_Nframes) / calc_init_user_framerate(calc_results_user_counter); 
    y_scale = max(calc_results_user_signal{calc_results_user_counter}) / max(times);
    plot(times,calc_results_user_signal{calc_results_user_counter} / y_scale)
    hold on;
    if strcmp(flag, 'min')
        title(['Select minimums for image ', num2str(calc_results_user_counter), '. Press Enter to stop.']);

    else
        title(['Select maximums for image ', num2str(calc_results_user_counter), '. Press Enter to stop.']);

    end
    max_times = calc_results_user_maxs{calc_results_user_counter} / calc_init_user_framerate(calc_results_user_counter);
    plot(max_times, calc_results_user_max_values{calc_results_user_counter} / y_scale, '.r','MarkerSize',10);
    min_times = calc_results_user_mins{calc_results_user_counter} / calc_init_user_framerate(calc_results_user_counter);
    plot(min_times, calc_results_user_min_values{calc_results_user_counter} / y_scale, '.g','MarkerSize',10);
    leftX = calc_results_user_poi{calc_results_user_counter}(1);
    rightX = calc_results_user_poi{calc_results_user_counter}(2);
    lim = ylim;
    ySpace = lim(2) - 0.99*lim(2);
    patch([leftX, leftX, rightX, rightX], [lim(1)+ySpace, 0.99*lim(2), 0.99*lim(2), lim(1)+ySpace], 'r', 'FaceAlpha', .3);
    [x,y] = getpts;
    close(hf)

    %find closest points
    
    pts = zeros(size(x));
    values = zeros(size(x));
    for i = 1:size(x,1)
        d = zeros(size(calc_results_user_signal{calc_results_user_counter},1),1);
        for h = 1:size(calc_results_user_signal{calc_results_user_counter},1)

            % calculate dx, dy
            dx = x(i) - (h / calc_init_user_framerate(calc_results_user_counter));
            dy = y(i) - (calc_results_user_signal{calc_results_user_counter}(h) / y_scale);

            % calculate distance
            d(h) = sqrt(dx^2+dy^2);
        end
        % find index of min(d)
        [~,pts(i)] = min(d);
        values(i) = calc_results_user_signal{calc_results_user_counter}(pts(i));
    end
    
    if strcmp(flag, 'min')
        calc_results_user_mins{calc_results_user_counter} = pts;
        calc_results_user_min_values{calc_results_user_counter} = values;
        setappdata(0,'calc_results_user_mins',calc_results_user_mins);
        setappdata(0,'calc_results_user_min_values',calc_results_user_min_values);
    else
        calc_results_user_maxs{calc_results_user_counter} = pts;
        calc_results_user_max_values{calc_results_user_counter} = values;
        setappdata(0,'calc_results_user_maxs',calc_results_user_maxs);
        setappdata(0,'calc_results_user_max_values',calc_results_user_max_values);
    end
    
    display_results(gui, 'signal')
       
    calc_results_user_mins{calc_results_user_counter} = sort(calc_results_user_mins{calc_results_user_counter});
    calc_results_user_maxs{calc_results_user_counter} = sort(calc_results_user_maxs{calc_results_user_counter});    
    if strcmp(call_fnc, 'auto') && size(calc_results_user_mins{calc_results_user_counter},1) > 0 && size(calc_results_user_maxs{calc_results_user_counter},1) > 0
        display_peaks = [];
        max_diff = 0;
        for imin = 1:size(calc_results_user_mins{calc_results_user_counter}, 1) - 1
            max_diff = max(max_diff, calc_results_user_mins{calc_results_user_counter}(imin + 1) -  calc_results_user_mins{calc_results_user_counter}(imin));
        end
        max_width = 1.25*max_diff;
        max_pre_width = 0.125*max_diff;
        max_post_width = max_width - max_pre_width;
        max_post_width = min(max_post_width, size(calc_results_user_signal{calc_results_user_counter}, 1) - calc_results_user_mins{calc_results_user_counter}(end));
        max_pre_width = min(max_pre_width, calc_results_user_mins{calc_results_user_counter}(1) - 1);
        for imin = 1:size(calc_results_user_mins{calc_results_user_counter}, 1)  
            start_frame = calc_results_user_mins{calc_results_user_counter}(imin) - max_pre_width;
            end_frame = start_frame + max_post_width;
            display_peaks(:,imin) = calc_results_user_signal{calc_results_user_counter}(start_frame:end_frame);
        end
        calc_results_user_display_peaks{calc_results_user_counter} = display_peaks;
        setappdata(0, 'calc_results_user_display_peaks', calc_results_user_display_peaks);
        av_peak = mean(display_peaks, 2);
        calc_results_user_peak{calc_results_user_counter} = av_peak;
        setappdata(0, 'calc_results_user_peak', calc_results_user_peak);
        display_results(gui, 'peak');
    end
end

function results_push_select_poi(Object, eventdata, gui)

    try
  
    calc_results_user_signal=getappdata(0,'calc_results_user_signal');
    calc_results_user_peak=getappdata(0,'calc_results_user_peak');
    calc_init_user_adj_profile=getappdata(0,'calc_init_user_adj_profile');
    calc_results_user_mins=getappdata(0,'calc_results_user_mins');
    calc_results_user_maxs=getappdata(0,'calc_results_user_maxs');
    calc_results_user_min_values=getappdata(0,'calc_results_user_min_values');
    calc_results_user_max_values=getappdata(0,'calc_results_user_max_values');
    calc_results_user_amplitude=getappdata(0,'calc_results_user_amplitude');
    calc_results_user_amplitude_std=getappdata(0,'calc_results_user_amplitude_std');
    calc_results_user_peak_duration=getappdata(0,'calc_results_user_peak_duration');
    calc_results_user_peak_duration_std=getappdata(0,'calc_results_user_peak_duration_std');
    calc_results_user_time_to_peak=getappdata(0,'calc_results_user_time_to_peak');    
    calc_results_user_time_to_peak_std=getappdata(0,'calc_results_user_time_to_peak_std');    
    calc_results_user_frequency=getappdata(0,'calc_results_user_frequency');
    calc_results_user_display_peaks=getappdata(0,'calc_results_user_display_peaks');
    calc_results_user_peak=getappdata(0,'calc_results_user_peak');
    calc_results_user_poi=getappdata(0,'calc_results_user_poi');
    calc_init_user_framerate=getappdata(0,'calc_init_user_framerate');
    calc_results_user_counter=getappdata(0,'calc_results_user_counter');
    calc_results_user_analysis_type=getappdata(0,'calc_results_user_analysis_type');
    min_Nframes=getappdata(0,'min_Nframes');
    
    figsize=[900,1600];
    %get screen size
    screensize = get(0,'ScreenSize');
    %position fig on center of screen
    xpos = ceil((screensize(3)-figsize(2))/2);
    ypos = ceil((screensize(4)-figsize(1))/2);
    hf=figure('position',[xpos, ypos, figsize(2), figsize(1)],...
        'units','pixels',...
        'renderer','OpenGL',...
        'visible','off');
    times = (1:min_Nframes) / calc_init_user_framerate(calc_results_user_counter); 
    y_scale = max(calc_results_user_signal{calc_results_user_counter}) / max(times);
    plot(times,calc_results_user_signal{calc_results_user_counter} / y_scale)
    hold on;
    title(['Select period of interest for video ', num2str(calc_results_user_counter), '. Press Enter to stop.']);
    max_times = calc_results_user_maxs{calc_results_user_counter} / calc_init_user_framerate(calc_results_user_counter);
    plot(max_times, calc_results_user_max_values{calc_results_user_counter} / y_scale, '.r','MarkerSize',10);
    min_times = calc_results_user_mins{calc_results_user_counter} / calc_init_user_framerate(calc_results_user_counter);
    plot(min_times, calc_results_user_min_values{calc_results_user_counter} / y_scale, '.g','MarkerSize',10);
    poi = drawrectangle();
    hf.set('visible','on');
   
    % Extract info from poi
    calc_results_user_poi{calc_results_user_counter} = [poi.Position(1), poi.Position(1) + poi.Position(3)];    
    close(hf);
    
    setappdata(0,'calc_results_user_poi',calc_results_user_poi);
    
    frames_poi = round(calc_results_user_poi{calc_results_user_counter} * calc_init_user_framerate(calc_results_user_counter));
    [s,p_av,stats] = signalAnalysis(times(frames_poi(1):frames_poi(2)), ...
         calc_init_user_adj_profile{calc_results_user_counter}(frames_poi(1):frames_poi(2)), ...
         calc_init_user_framerate(calc_results_user_counter), 0);
    %calc_results_user_signal{ivid} = s.fsignal;
    calc_results_user_peak{calc_results_user_counter} = p_av.av_peak;
    calc_results_user_amplitude{calc_results_user_counter} = stats.amplitude_av;
    calc_results_user_amplitude_std{calc_results_user_counter} = stats.amplitude_std;
    calc_results_user_peak_duration{calc_results_user_counter} = stats.peak_duration_av;
    calc_results_user_peak_duration_std{calc_results_user_counter} = stats.peak_duration_std;
    calc_results_user_time_to_peak{calc_results_user_counter} = stats.time_to_peak_av;
    calc_results_user_time_to_peak_std{calc_results_user_counter} = stats.time_to_peak_std;
    calc_results_user_frequency{calc_results_user_counter} = p_av.n_peaks ...
        / (calc_results_user_poi{calc_results_user_counter}(2) - calc_results_user_poi{calc_results_user_counter}(1));
    if ~isempty(s.pd_xcorr_peaks_lags)
        calc_results_user_display_peaks{calc_results_user_counter} = stats.display_peaks;
    end
    setappdata(0,'calc_results_user_peak',calc_results_user_peak);
    setappdata(0,'calc_results_user_amplitude',calc_results_user_amplitude);
    setappdata(0,'calc_results_user_amplitude_std',calc_results_user_amplitude_std);
    setappdata(0,'calc_results_user_peak_duration',calc_results_user_peak_duration);
    setappdata(0,'calc_results_user_peak_duration_std',calc_results_user_peak_duration_std);
    setappdata(0,'calc_results_user_time_to_peak',calc_results_user_time_to_peak);    
    setappdata(0,'calc_results_user_time_to_peak_std',calc_results_user_time_to_peak_std);    
    setappdata(0,'calc_results_user_frequency',calc_results_user_frequency);
    setappdata(0,'calc_results_user_poi',calc_results_user_poi);
    setappdata(0,'calc_results_user_display_peaks',calc_results_user_display_peaks);
    
    display_results(gui, 'signal');
    if ~calc_results_user_analysis_type(calc_results_user_counter)
        display_results(gui, 'peak');
    end
    
    if isempty(calc_results_user_peak{calc_results_user_counter})
        figuresize=[40,450];
        screensize=get(0,'ScreenSize');
        xpos = ceil((screensize(3)-figuresize(2))/2);
        ypos = ceil((screensize(4)-figuresize(1))/2);
        %create figure
        autoFailWarning.fig=figure(...
            'position',[xpos, ypos, figuresize(2), figuresize(1)],...
            'units','pixels',...
            'renderer','OpenGL',...
            'MenuBar','none',...
            'PaperPositionMode','auto',...
            'Name','Warning',...
            'NumberTitle','off',...
            'Resize','off',...
            'Color','w',...
            'Visible','off');
        annotation('textbox',[0.1 0.1 0.8 0.8], 'String', ['Automatic analysis failed for video ', num2str(calc_results_user_counter), '. Add points manually, or try with a different poi.'], 'FitBoxToText', 'on', 'LineStyle', 'none');
        autoFailWarning.fig.Visible='on';
        waitfor(autoFailWarning.fig);
     end
    
    catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'));
       
    end
    
end

function results_push_switch_type(Object, eventdata, gui)

    try
        
    calc_results_user_peak=getappdata(0,'calc_results_user_peak');
    calc_init_user_adj_profile=getappdata(0,'calc_init_user_adj_profile');
    calc_results_user_amplitude=getappdata(0,'calc_results_user_amplitude');
    calc_results_user_amplitude_std=getappdata(0,'calc_results_user_amplitude_std');
    calc_results_user_peak_duration=getappdata(0,'calc_results_user_peak_duration');
    calc_results_user_peak_duration_std=getappdata(0,'calc_results_user_peak_duration_std');
    calc_results_user_time_to_peak=getappdata(0,'calc_results_user_time_to_peak');    
    calc_results_user_time_to_peak_std=getappdata(0,'calc_results_user_time_to_peak_std');    
    calc_results_user_frequency=getappdata(0,'calc_results_user_frequency');
    calc_results_user_display_peaks=getappdata(0,'calc_results_user_display_peaks');
    calc_results_user_poi=getappdata(0,'calc_results_user_poi');
    calc_init_user_framerate=getappdata(0,'calc_init_user_framerate');
    calc_results_user_counter=getappdata(0,'calc_results_user_counter');
    calc_results_user_analysis_type=getappdata(0,'calc_results_user_analysis_type');
    calc_results_user_mins=getappdata(0,'calc_results_user_mins');
    calc_results_user_maxs=getappdata(0,'calc_results_user_maxs');
    calc_results_user_signal=getappdata(0,'calc_results_user_signal');
    min_Nframes=getappdata(0,'min_Nframes');
    
    switch get(eventdata.NewValue, 'Tag')
        case 'radiobutton_auto'
            calc_results_user_analysis_type(calc_results_user_counter) = 0;
        case 'radiobutton_manual'
            calc_results_user_analysis_type(calc_results_user_counter) = 1;
    end
    setappdata(0,'calc_results_user_analysis_type',calc_results_user_analysis_type);
    
    if calc_results_user_analysis_type(calc_results_user_counter) == 0
        times = (1:min_Nframes) / calc_init_user_framerate(calc_results_user_counter); 
        frames_poi = round(calc_results_user_poi{calc_results_user_counter} * calc_init_user_framerate(calc_results_user_counter));
        [s,p_av,stats] = signalAnalysis(times(frames_poi(1):frames_poi(2)), ...
             calc_init_user_adj_profile{calc_results_user_counter}(frames_poi(1):frames_poi(2)), ...
             calc_init_user_framerate(calc_results_user_counter), 0);
        %calc_results_user_signal{ivid} = s.fsignal;
        calc_results_user_peak{calc_results_user_counter} = p_av.av_peak;
        calc_results_user_amplitude{calc_results_user_counter} = stats.amplitude_av;
        calc_results_user_amplitude_std{calc_results_user_counter} = stats.amplitude_std;
        calc_results_user_peak_duration{calc_results_user_counter} = stats.peak_duration_av;
        calc_results_user_peak_duration_std{calc_results_user_counter} = stats.peak_duration_std;
        calc_results_user_time_to_peak{calc_results_user_counter} = stats.time_to_peak_av;
        calc_results_user_time_to_peak_std{calc_results_user_counter} = stats.time_to_peak_std;
        calc_results_user_frequency{calc_results_user_counter} = p_av.n_peaks ...
            / (calc_results_user_poi{calc_results_user_counter}(2) - calc_results_user_poi{calc_results_user_counter}(1));
        if ~isempty(s.pd_xcorr_peaks_lags)
            calc_results_user_display_peaks{calc_results_user_counter} = stats.display_peaks;
        end
        setappdata(0,'calc_results_user_peak',calc_results_user_peak);
        setappdata(0,'calc_results_user_amplitude',calc_results_user_amplitude);
        setappdata(0,'calc_results_user_amplitude_std',calc_results_user_amplitude_std);
        setappdata(0,'calc_results_user_peak_duration',calc_results_user_peak_duration);
        setappdata(0,'calc_results_user_peak_duration_std',calc_results_user_peak_duration_std);
        setappdata(0,'calc_results_user_time_to_peak',calc_results_user_time_to_peak);    
        setappdata(0,'calc_results_user_time_to_peak_std',calc_results_user_time_to_peak_std);    
        setappdata(0,'calc_results_user_frequency',calc_results_user_frequency);
        setappdata(0,'calc_results_user_poi',calc_results_user_poi);
        setappdata(0,'calc_results_user_display_peaks',calc_results_user_display_peaks);

        display_results(gui, 'signal');
        display_results(gui, 'peak');

        if isempty(calc_results_user_peak{calc_results_user_counter})
            figuresize=[40,450];
            screensize=get(0,'ScreenSize');
            xpos = ceil((screensize(3)-figuresize(2))/2);
            ypos = ceil((screensize(4)-figuresize(1))/2);
            %create figure
            autoFailWarning.fig=figure(...
                'position',[xpos, ypos, figuresize(2), figuresize(1)],...
                'units','pixels',...
                'renderer','OpenGL',...
                'MenuBar','none',...
                'PaperPositionMode','auto',...
                'Name','Warning',...
                'NumberTitle','off',...
                'Resize','off',...
                'Color','w',...
                'Visible','off');
            annotation('textbox',[0.1 0.1 0.8 0.8], 'String', ['Automatic analysis failed for video ', num2str(calc_results_user_counter), '. Add points manually, or try with a different poi.'], 'FitBoxToText', 'on', 'LineStyle', 'none');
            autoFailWarning.fig.Visible='on';
            waitfor(autoFailWarning.fig);
        end
    else
        calc_results_user_peak_duration_av_manual=getappdata(0,'calc_results_user_peak_duration_av_manual');
        calc_results_user_peak_duration_std_manual=getappdata(0,'calc_results_user_peak_duration_std_manual');
        calc_results_user_time_to_peak_av_manual=getappdata(0,'calc_results_user_time_to_peak_av_manual');
        calc_results_user_time_to_peak_std_manual=getappdata(0,'calc_results_user_time_to_peak_std_manual');
        calc_results_user_delay_time_av_manual=getappdata(0,'calc_results_user_delay_time_av_manual');
        calc_results_user_delay_time_std_manual=getappdata(0,'calc_results_user_delay_time_std_manual');
        calc_results_user_amplitude_av_manual=getappdata(0,'calc_results_user_amplitude_av_manual');
        calc_results_user_amplitude_std_manual=getappdata(0,'calc_results_user_amplitude_std_manual');
        calc_results_user_frequency_manual=getappdata(0,'calc_results_user_frequency_manual');
        calc_results_user_npeaks_manual=getappdata(0,'calc_results_user_npeaks_manual');

        if isempty(calc_results_user_mins{calc_results_user_counter})
            results_push_add_pts(Object, eventdata, gui, 'min', 'auto');
            calc_results_user_mins=getappdata(0,'calc_results_user_mins');
        end
        if isempty(calc_results_user_maxs{calc_results_user_counter})
            results_push_add_pts(Object, eventdata, gui, 'max', 'auto');
        end
        
        %update mins and maxs to only fall in poi
        calc_results_user_mins{calc_results_user_counter} = calc_results_user_mins{calc_results_user_counter}(calc_results_user_mins{calc_results_user_counter} > calc_results_user_poi{calc_results_user_counter}(1) * calc_init_user_framerate(calc_results_user_counter));
        calc_results_user_mins{calc_results_user_counter} = calc_results_user_mins{calc_results_user_counter}(calc_results_user_mins{calc_results_user_counter} < calc_results_user_poi{calc_results_user_counter}(2) * calc_init_user_framerate(calc_results_user_counter));
        calc_results_user_maxs{calc_results_user_counter} = calc_results_user_maxs{calc_results_user_counter}(calc_results_user_maxs{calc_results_user_counter} > calc_results_user_poi{calc_results_user_counter}(1) * calc_init_user_framerate(calc_results_user_counter));
        calc_results_user_maxs{calc_results_user_counter} = calc_results_user_maxs{calc_results_user_counter}(calc_results_user_maxs{calc_results_user_counter} < calc_results_user_poi{calc_results_user_counter}(2) * calc_init_user_framerate(calc_results_user_counter));

        display_peaks = [];
        max_diff = 0;
        calc_results_user_mins{calc_results_user_counter} = sort(calc_results_user_mins{calc_results_user_counter});
        calc_results_user_maxs{calc_results_user_counter} = sort(calc_results_user_maxs{calc_results_user_counter});        
        for imin = 1:size(calc_results_user_mins{calc_results_user_counter}, 1) - 1
            max_diff = max(max_diff, calc_results_user_mins{calc_results_user_counter}(imin + 1) -  calc_results_user_mins{calc_results_user_counter}(imin));
        end
        max_width = 1.25*max_diff;
        max_pre_width = 0.125*max_diff;
        max_post_width = max_width - max_pre_width;
        max_post_width = min(max_post_width, size(calc_results_user_signal{calc_results_user_counter}, 1) - calc_results_user_mins{calc_results_user_counter}(end));
        max_pre_width = min(max_pre_width, calc_results_user_mins{calc_results_user_counter}(1) - 1);
        for imin = 1:size(calc_results_user_mins{calc_results_user_counter}, 1)  
            start_frame = calc_results_user_mins{calc_results_user_counter}(imin) - max_pre_width;
            end_frame = start_frame + max_post_width;
            display_peaks(:,imin) = calc_results_user_signal{calc_results_user_counter}(start_frame:end_frame);
        end
        calc_results_user_display_peaks{calc_results_user_counter} = display_peaks;
        setappdata(0, 'calc_results_user_display_peaks', calc_results_user_display_peaks);
        av_peak = mean(display_peaks, 2);
        calc_results_user_peak{calc_results_user_counter} = av_peak;
        setappdata(0, 'calc_results_user_peak', calc_results_user_peak);
 
        offset = 0;
        peakDurations = nan(size(calc_results_user_mins{calc_results_user_counter},1), 1);
        timeToPeaks = nan(size(calc_results_user_mins{calc_results_user_counter},1), 1);
        delayTimes = nan(size(calc_results_user_mins{calc_results_user_counter}, 1), 1);
        amplitudes = nan(size(calc_results_user_mins{calc_results_user_counter},1), 1);
        nPeaks = 0;
        calc_results_user_mins{calc_results_user_counter} = sort(calc_results_user_mins{calc_results_user_counter});
        calc_results_user_maxs{calc_results_user_counter} = sort(calc_results_user_maxs{calc_results_user_counter});
        for ipeak = 1:size(calc_results_user_mins{calc_results_user_counter},1)
            if ipeak > 1
                peakDurations(ipeak) = calc_results_user_mins{calc_results_user_counter}(ipeak) - calc_results_user_mins{calc_results_user_counter}(ipeak - 1);
                nPeaks = nPeaks + 1;
            end
            while ipeak + offset <= size(calc_results_user_maxs{calc_results_user_counter},1) && calc_results_user_maxs{calc_results_user_counter}(ipeak + offset) < calc_results_user_mins{calc_results_user_counter}(ipeak)
                offset = offset + 1;
            end
            if ipeak + offset <= size(calc_results_user_maxs{calc_results_user_counter},1)
                imin = calc_results_user_mins{calc_results_user_counter}(ipeak);
                imax = calc_results_user_maxs{calc_results_user_counter}(ipeak + offset);
                if ipeak < size(calc_results_user_mins{calc_results_user_counter},1)
                    iMinNext = calc_results_user_mins{calc_results_user_counter}(ipeak + 1);
                    delayTimes(ipeak) = iMinNext - imax;
                end                
                timeToPeaks(ipeak) = imax - imin;
                amplitudes(ipeak) = calc_results_user_signal{calc_results_user_counter}(imax) - calc_results_user_signal{calc_results_user_counter}(imin);
            end
        end
        calc_results_user_peak_duration_av_manual{calc_results_user_counter} = nanmean(peakDurations);
        calc_results_user_peak_duration_std_manual{calc_results_user_counter} = nanstd(peakDurations);
        calc_results_user_time_to_peak_av_manual{calc_results_user_counter} = nanmean(timeToPeaks);
        calc_results_user_time_to_peak_std_manual{calc_results_user_counter} = nanstd(timeToPeaks);
        calc_results_user_delay_time_av_manual{calc_results_user_counter} = nanmean(delayTimes);
        calc_results_user_delay_time_std_manual{calc_results_user_counter} = nanstd(delayTimes);
        calc_results_user_amplitude_av_manual{calc_results_user_counter} = nanmean(amplitudes);
        calc_results_user_amplitude_std_manual{calc_results_user_counter} = nanstd(amplitudes);
        calc_results_user_frequency_manual{calc_results_user_counter} = size(calc_results_user_maxs{calc_results_user_counter}, 1) / (calc_results_user_poi{calc_results_user_counter}(2) - calc_results_user_poi{calc_results_user_counter}(1));
        calc_results_user_npeaks_manual{calc_results_user_counter} = nPeaks;
        
        setappdata(0,'calc_results_user_peak_duration_av_manual',calc_results_user_peak_duration_av_manual);
        setappdata(0,'calc_results_user_peak_duration_std_manual',calc_results_user_peak_duration_std_manual);
        setappdata(0,'calc_results_user_time_to_peak_av_manual', calc_results_user_time_to_peak_av_manual);
        setappdata(0,'calc_results_user_time_to_peak_std_manual',calc_results_user_time_to_peak_std_manual);
        setappdata(0,'calc_results_user_delay_time_av_manual', calc_results_user_delay_time_av_manual);
        setappdata(0,'calc_results_user_delay_time_std_manual', calc_results_user_delay_time_std_manual);
        setappdata(0,'calc_results_user_amplitude_av_manual',calc_results_user_amplitude_av_manual);
        setappdata(0,'calc_results_user_amplitude_std_manual',calc_results_user_amplitude_std_manual);
        setappdata(0,'calc_results_user_frequency_manual',calc_results_user_frequency_manual);
        setappdata(0,'calc_results_user_npeaks_manual',calc_results_user_npeaks_manual);
        
        display_results(gui, 'signal');
        display_results(gui, 'peak');
    end
    catch errorObj
        % If there is a problem, we display the error message
        errordlg(getReport(errorObj,'extended','hyperlinks','off'));
    end
end

function display_results(gui, flag)
    calc_results_user_counter=getappdata(0,'calc_results_user_counter');
    calc_results_user_signal=getappdata(0,'calc_results_user_signal');
    calc_results_user_mins=getappdata(0,'calc_results_user_mins');
    calc_results_user_maxs=getappdata(0,'calc_results_user_maxs');
    calc_init_user_framerate=getappdata(0,'calc_init_user_framerate');
    calc_results_user_min_values=getappdata(0,'calc_results_user_min_values');
    calc_results_user_max_values=getappdata(0,'calc_results_user_max_values');
    calc_results_user_peak=getappdata(0,'calc_results_user_peak');
    calc_results_user_poi=getappdata(0,'calc_results_user_poi');
    calc_results_user_display_peaks=getappdata(0,'calc_results_user_display_peaks');
    calc_results_user_analysis_type=getappdata(0,'calc_results_user_analysis_type');
    min_Nframes=getappdata(0,'min_Nframes');
    times = (1:min_Nframes) / calc_init_user_framerate(calc_results_user_counter); 
    %display results  
    if strcmp(flag, 'signal')
        axes(gui(1).axes_signal);
        plot(times, calc_results_user_signal{calc_results_user_counter});
        hold on;
        min_times = calc_results_user_mins{calc_results_user_counter} / calc_init_user_framerate(calc_results_user_counter);
        max_times = calc_results_user_maxs{calc_results_user_counter} / calc_init_user_framerate(calc_results_user_counter);
        if isempty(calc_results_user_max_values{calc_results_user_counter})
            plot(min_times, calc_results_user_signal{calc_results_user_counter}(calc_results_user_mins{calc_results_user_counter}), '.r','MarkerSize',10);
        else
            plot(min_times, calc_results_user_min_values{calc_results_user_counter}, '.g','MarkerSize',10);
        end
        if isempty(calc_results_user_max_values{calc_results_user_counter})
            plot(max_times, calc_results_user_signal{calc_results_user_counter}(calc_results_user_maxs{calc_results_user_counter}), '.r','MarkerSize',10);
        else
            plot(max_times, calc_results_user_max_values{calc_results_user_counter}, '.r','MarkerSize',10);
        end
        leftX = calc_results_user_poi{calc_results_user_counter}(1);
        rightX = calc_results_user_poi{calc_results_user_counter}(2);
        lim = ylim;
        ySpace = lim(2) - 0.99*lim(2);
        patch([leftX, leftX, rightX, rightX], [lim(1)+ySpace, 0.99*lim(2), 0.99*lim(2), lim(1)+ySpace], 'r', 'FaceAlpha', .3);
        hold off;
        xlabel('Time (s)');
        ylabel('deltaF/F0');
    else
        times = (1:size(calc_results_user_peak{calc_results_user_counter}, 1)) / calc_init_user_framerate(calc_results_user_counter);
        axes(gui(1).axes_peak);
        if isempty(calc_results_user_peak{calc_results_user_counter})
            plot(NaN)
        else
            plot(times, calc_results_user_peak{calc_results_user_counter});
        end
        xlabel('Time (s)');
        ylabel('deltaF/F0');
        axes(gui(1).axes_all_peaks);
        colors = ['r', 'g', 'b', 'c', 'm', 'k'];
        if size(calc_results_user_display_peaks{calc_results_user_counter}, 2) == 0
            plot(NaN);
            return;
        end
        for ipeak = 1:size(calc_results_user_display_peaks{calc_results_user_counter}, 2)
            plot(times, calc_results_user_display_peaks{calc_results_user_counter}(:,ipeak), '--', 'LineWidth', 0.5, 'Color', colors(1 + mod(ipeak, length(colors))));
            hold on;
            firstIndex = find(~isnan(calc_results_user_display_peaks{calc_results_user_counter}(:,ipeak)), 1);
            firstIndexValue = calc_results_user_display_peaks{calc_results_user_counter}(firstIndex,ipeak);
            secondIndex = find(~isnan(calc_results_user_display_peaks{calc_results_user_counter}(:,ipeak)), 1, 'last');
            secondIndexValue = calc_results_user_display_peaks{calc_results_user_counter}(secondIndex,ipeak);
            plot(times([firstIndex, secondIndex]), [firstIndexValue, secondIndexValue], '*', 'MarkerSize', 10, 'Color', colors(1 + mod(ipeak, length(colors))))
        end
        xlabel('Time (s)');
        ylabel('deltaF/F0');
        hold off;
    end
    
    % update text 
    if calc_results_user_analysis_type(calc_results_user_counter) == 0
        calc_results_user_amplitude=getappdata(0,'calc_results_user_amplitude');
        calc_results_user_amplitude_std=getappdata(0,'calc_results_user_amplitude_std');
        calc_results_user_peak_duration=getappdata(0,'calc_results_user_peak_duration');
        calc_results_user_peak_duration_std=getappdata(0,'calc_results_user_peak_duration_std');
        calc_results_user_time_to_peak=getappdata(0,'calc_results_user_time_to_peak');    
        calc_results_user_time_to_peak_std=getappdata(0,'calc_results_user_time_to_peak_std');    
        calc_results_user_frequency=getappdata(0,'calc_results_user_frequency');
        calc_results_user_npeaks=getappdata(0,'calc_results_user_npeaks');
    else
        calc_results_user_amplitude=getappdata(0,'calc_results_user_amplitude_av_manual');
        calc_results_user_amplitude_std=getappdata(0,'calc_results_user_amplitude_std_manual');
        calc_results_user_peak_duration=getappdata(0,'calc_results_user_peak_duration_av_manual');
        calc_results_user_peak_duration_std=getappdata(0,'calc_results_user_peak_duration_std_manual');
        calc_results_user_time_to_peak=getappdata(0,'calc_results_user_time_to_peak_av_manual');    
        calc_results_user_time_to_peak_std=getappdata(0,'calc_results_user_time_to_peak_std_manual');    
        calc_results_user_frequency=getappdata(0,'calc_results_user_frequency_manual');
        calc_results_user_npeaks=getappdata(0,'calc_results_user_npeaks_manual');
    end
    
    calc_results_user_peak_duration{calc_results_user_counter} = calc_results_user_peak_duration{calc_results_user_counter} / calc_init_user_framerate(calc_results_user_counter);
    calc_results_user_peak_duration_std{calc_results_user_counter} = calc_results_user_peak_duration_std{calc_results_user_counter} / calc_init_user_framerate(calc_results_user_counter);
    calc_results_user_time_to_peak{calc_results_user_counter} = calc_results_user_time_to_peak{calc_results_user_counter} / calc_init_user_framerate(calc_results_user_counter);
    calc_results_user_time_to_peak_std{calc_results_user_counter} = calc_results_user_time_to_peak_std{calc_results_user_counter} / calc_init_user_framerate(calc_results_user_counter);
        
    if isempty(calc_results_user_peak_duration{calc_results_user_counter})
        set(gui(1).edit_peak_duration_av,'String','NaN');
    else
        set(gui(1).edit_peak_duration_av,'String',num2str(calc_results_user_peak_duration{calc_results_user_counter}));
    end
    if isempty(calc_results_user_peak_duration_std{calc_results_user_counter})
        set(gui(1).edit_peak_duration_std,'String','NaN');
    else
        set(gui(1).edit_peak_duration_std,'String',num2str(calc_results_user_peak_duration_std{calc_results_user_counter}));
    end
    if isempty(calc_results_user_time_to_peak{calc_results_user_counter})
        set(gui(1).edit_time_to_peak_av,'String','NaN');
    else
        set(gui(1).edit_time_to_peak_av,'String',num2str(calc_results_user_time_to_peak{calc_results_user_counter}));
    end
    if isempty(calc_results_user_time_to_peak_std{calc_results_user_counter})
        set(gui(1).edit_time_to_peak_std,'String','NaN');
    else
        set(gui(1).edit_time_to_peak_std,'String',num2str(calc_results_user_time_to_peak_std{calc_results_user_counter}));
    end
    if isempty(calc_results_user_amplitude{calc_results_user_counter})
        set(gui(1).edit_amplitude_av,'String','NaN');
    else
        set(gui(1).edit_amplitude_av,'String',num2str(calc_results_user_amplitude{calc_results_user_counter}));
    end
    if isempty(calc_results_user_amplitude_std{calc_results_user_counter})
        set(gui(1).edit_amplitude_std,'String','NaN');
    else
        set(gui(1).edit_amplitude_std,'String',num2str(calc_results_user_amplitude_std{calc_results_user_counter}));
    end
    if isempty(calc_results_user_frequency{calc_results_user_counter})
        set(gui(1).edit_frequency,'String','NaN');
    else
        set(gui(1).edit_frequency,'String',num2str(calc_results_user_frequency{calc_results_user_counter}));
    end
    if isempty(calc_results_user_npeaks{calc_results_user_counter})
        set(gui(1).edit_num_peaks,'String','NaN');
    else
        set(gui(1).edit_num_peaks,'String',num2str(calc_results_user_npeaks{calc_results_user_counter}));
    end
    
    if calc_results_user_analysis_type(calc_results_user_counter) == 1
        if sum(cellfun(@isempty,calc_results_user_maxs)) == 0 && sum(cellfun(@isempty,calc_results_user_peak)) == 0
            set(gui(1).button_ok,'enable','on');
        end
    elseif sum(cellfun(@isempty,calc_results_user_peak)) == 0
            set(gui(1).button_ok,'enable','on');    
    end
    
end

function select_buttongroup_type_qual(hObject, eventdata, gui)
    calc_results_user_counter=getappdata(0,'calc_results_user_counter');
    calc_results_user_qual=getappdata(0,'calc_results_user_qual');
    
    switch get(eventdata.NewValue, 'Tag')
        case 'radiobutton_class1'
            calc_results_user_qual(calc_results_user_counter) = 0;
        case 'radiobutton_class2'
            calc_results_user_qual(calc_results_user_counter) = 1;
        case 'radiobutton_class3'
            calc_results_user_qual(calc_results_user_counter) = 2;
        case 'radiobutton_noise'
            calc_results_user_qual(calc_results_user_counter) = 3;
    end
    setappdata(0,'calc_results_user_qual',calc_results_user_qual)
end

%version 1.0 written by Gaspard Pardon (gaspard@stanford.edu)
function [s,p_av,stats] = signalAnalysis(t, signal, fs, incl_diff)
    %function to find repeating pattern in signal, extract repeating peak and
    %calculate average peak
    %Input arguments: signal time vector, curve signal, frame rate/sampling
    %    frequency, include differential calculation
    %Oupt arguments: peak_av structure with fields: 
    %t_peak, av_peak, peak_max, peak_max_t, peak_min, peak_min_t,...
    %    peak_bl, p_av.peak_amp, dpeak_max, dpeak_max_t, dpeak_min, dpeak_min_t,...
    %    peak_area_contr, peak_area_rel, peak_area_tot, autocorr_signal, frequency,
    %    n_peaks, comments;
    %corresponding to: peak time vector, average peak signal, peak max,
    %peak max time location, peak
    %minimums, peak minimums locations, baseline, peak amplitude, first derivative maximum, first derivative maximum time location, first derivative
    %minimum,first derivative minimum time location, area under the curve
    %during contraction, area under the curve during relaxation, total area
    %under the peak, auto-correlation signal, peaks frequency, number of peaks
    %detected, comments

    %Initialize output structure with NaNs
    s.fsignal = NaN;
    s.signal_t = t;
    s.framerate = fs;
    s.autocorr_signal = NaN;
    s.autocorr_lags = NaN;
    s.autocorr_peaks = NaN;
    s.autocorr_peaks_lags = NaN;
    s.av_peak_spac = NaN;
    s.av_peak_spac_std = NaN;
    s.f_main_peak = NaN;
    s.f_main_peak_std = NaN;
    s.av_peak_w = NaN;%?
    s.av_peak_w_std = NaN;%?
    s.comment = '';

    s.peaks = NaN;
    s.peaks_lags = NaN;
    s.ref_peak = NaN;
    s.ref_peak_lag = NaN;
    
    s.pd_xcorr_peaks_lags = [];

    p_av.peaks = NaN;
    p_av.n_peaks = NaN;

    p_av.filtyoffs = NaN;

    p_av.t_peak = NaN;
    p_av.av_peak = [];
    p_av.av_peak_std = NaN;

    p_av.peak_max = NaN;
    p_av.peak_max_t = NaN;
    p_av.peak_max_std = NaN;
    p_av.peak_max_t_std = NaN;

    p_av.peak_min = NaN;
    p_av.peak_min_t = NaN;
    p_av.peak_min_std = NaN;

    p_av.peak_basel = NaN;
    p_av.peak_basel_std = NaN;

    p_av.peak_amp = NaN;
    p_av.peak_amp_std = NaN;

    p_av.av_peak_width = NaN;
    p_av.av_peak_width_std = NaN;

    p_av.peak_area_contr = NaN;
    p_av.peak_area_contr_std = NaN;

    p_av.peak_area_rel = NaN;
    p_av.peak_area_rel_std = NaN;

    p_av.peak_area_tot = NaN;
    p_av.peak_area_tot_std = NaN;

    p_av.d_t_peak = NaN;
    p_av.d_av_peak = NaN;
    p_av.d_av_peak_std = NaN;

    p_av.d_peak_max = NaN;
    p_av.d_peak_max_t = NaN;
    p_av.d_peak_max_std = NaN;

    p_av.d_peak_min = NaN;
    p_av.d_peak_min_t = NaN;
    p_av.d_peak_min_std = NaN;

    stats.peak_duration_av = NaN;
    stats.peak_duration_std = NaN;
    stats.time_to_peak_av = NaN;
    stats.time_to_peak_std = NaN;
    stats.amplitude_av = NaN;
    stats.amplitude_std = NaN;
    stats.delay_time_av = NaN;
    stats.delay_time_std = NaN;
    
    %check for column vector inputs
    if isrow(s.signal_t)
        s.signal_t = transpose(s.signal_t);
    end
    if isrow(signal)
        signal = transpose(signal);
    end

    %Prepare curve vector
    signal(isnan(signal))=0;%change NaN to 0

    % %Plot curve
    % figure(1)
    % f1p1=plot(s.signal_t,signal);
    % hold on 

    %%
    %Filtering
    %================================

    %Compute curve - average for comparison with fft filter below
    %curve = curve - nanmean(curve);

    %Use fft to filter signalwith a bandpass filter
    df = fs/size(signal,1);
    f_range = ((-fs/2:df:fs/2-df)+(df-mod(size(signal,1),2)*df/2))';
    bp_filter = ((1/3 < abs(f_range)) & (abs(f_range) < 10));

    fft_signal = fftshift(fft(signal-mean(signal)));
    fft_signal = bp_filter.*fft_signal;
    %Transform curve back to time domain
    s.fsignal = real(ifft(ifftshift(fft_signal)));

    % %Plot filtered curve
    % hold on
    % fip2=plot(s.signal_t,s.fsignal);
    % hold on


    %%
    %Autocorrelation of curve with itself
    %================================

    [s.autocorr_signal, s.autocorr_lags] = xcorr(s.fsignal, 'coeff');

    %Extract positive part of autocorrelation signal
    pos_el = find(s.autocorr_lags>=0);
    s.autocorr_lags = s.autocorr_lags(pos_el);
    s.autocorr_signal = s.autocorr_signal(pos_el);

    % %Plot autocorrelation signal
    % figure(2)
    % plot(s.autocorr_lags/fs,s.autocorr_signal)
    % hold on 

    %Find peaks of autocorrelation signal, using a specific peak prominence and height
    [s.autocorr_peaks,s.autocorr_peaks_lags,w] = findpeaks(s.autocorr_signal,'MinPeakDistance',60/220/fs,'MinPeakWidth',fs/8,'MinPeakProminence',0.2);%,'MinPeakHeight',0.1);%'SortStr','descend','MinPeakDistance',0.25*fs

    %if no autocorrelation peak is detected, output message and output
    %arbitrary peak of height 0.1, and lad and width of 1 second = fs frames 
    if isempty(s.autocorr_peaks)
        s.comment = 'No correlation peak detected'; 
        s.autocorr_peaks = 0.1;
        s.autocorr_peaks_lags = fs;
        w = fs;
    elseif size(s.autocorr_peaks,1) == 1
        s.comment = 'Only 1 correlation peak detected';
    end

    %Find the average peak distance and divide by sampling frequency to get the
    %time between peaks
    s.av_peak_spac = mean(diff([0; s.autocorr_peaks_lags]))/fs;% Measure of beating frequency
    % if isnan(s.av_peak_spac)
    %     s.comment = 'Peak spacing is NaN';
    % end
    s.av_peak_spac_std = std(diff([0; s.autocorr_peaks_lags]))/fs;% Measure of the arrythmia 
    %Calculate the average peak width
    s.av_peak_w = mean(w)/fs;% Measure of the peak duration
    s.av_peak_w_std = std(w)/fs;% Measure of the variability in peak duration
    %Calculate the peak frequency
    s.f_main_peak = 1/s.av_peak_spac;
    s.f_main_peak_std = s.f_main_peak*sqrt((s.av_peak_spac_std/s.av_peak_spac)^2);

    % %Plot the position of the average peak in autocorrelation signal
    % hold on
    % pks = plot(s.autocorr_lags(s.autocorr_peaks_lags(1))/fs,s.autocorr_peaks(1)+0.05,'vk');
    % hold off
    % legend('Signal auto-correlation','Average peak position')

    %%
    %Determine the width of the window framing a single peak
    %================================
    s.ref_peak_l = floor(s.av_peak_spac*fs);

    %Add an overlapping factor of 25% on each side of the peak
    overlap = 1.6;
    %Determine a moving window length and duration
    s.peak_win_l = min(floor(size(s.signal_t,1)/2),floor(s.ref_peak_l*overlap));
    peak_d = s.signal_t(s.peak_win_l);
    %Make an index and time vector for the moving windows
    peak_wins_ind = s.signal_t<=peak_d;
    p_av.peak_wins_t = s.signal_t(peak_wins_ind);


    %%
    %Find most prominent peak of width peakwin_l in curve to use as reference
    %peak
    %================================
    [s.peaks,s.peaks_lags,w,p] = findpeaks(s.fsignal,'MinPeakDistance',0.75*s.av_peak_spac*fs,'MinPeakProminence',rms(s.fsignal),'MaxPeakWidth',min(2*fs*(s.av_peak_w+4*s.av_peak_w_std),size(s.fsignal,1)/2));%max(4*fs, size(s.fsignal,2)/2));
    %[s.peaks,s.peaks_lags,w,p] = findpeaks(s.fsignal,'MinPeakDistance',0.75*s.av_peak_spac*fs,'MinPeakProminence',1.5*rms(s.fsignal),'MaxPeakWidth',min(s.av_peak_w+4*s.av_peak_w_std,size(s.fsignal,1)/2)*fs);%max(4*fs, size(s.fsignal,2)/2));

    %exit function if no prominent peak is found in the signal
    if isempty(s.peaks)
        s.comment = [s.comment ': No prominent peak found in the signal'];
        return
    end

    %Restrict to full peaks only, i.e. exclude peaks at the beginning and end
    %of the signal to avoid truncation
    s.peaks = s.peaks(find((s.peaks_lags>s.peak_win_l/2) .* (s.peaks_lags<size(s.fsignal,1)-s.peak_win_l/2)));
    s.peaks_lags = s.peaks_lags(find((s.peaks_lags>s.peak_win_l/2) .* (s.peaks_lags<size(s.fsignal,1)-s.peak_win_l/2)));
    w = w(find((s.peaks_lags>s.peak_win_l/2) .* (s.peaks_lags<size(s.fsignal,1)-s.peak_win_l/2)));
    p = p(find((s.peaks_lags>s.peak_win_l/2) .* (s.peaks_lags<size(s.fsignal,1)-s.peak_win_l/2)))';

    %Check that there is a full peak to use as reference and if not find
    %another peak with less strict criteria
    if isempty(s.peaks)
        [s.peaks,s.peaks_lags,w,p] = findpeaks(s.fsignal(floor(s.peak_win_l/2):end-floor(s.peak_win_l/2)),'MinPeakDistance',0.75*s.av_peak_spac, 'MaxPeakWidth',fs,'SortStr','descend','NPeaks',1);
        s.peaks_lags = s.peaks_lags+floor(s.peak_win_l/2);
        s.comment = [s.comment ': Non prominent peak selected because no prominent peak detected'];
    end

    %second check to ensure one peak is selected, even if not really prominent
    %(to be deleted if never used)
    if isempty(s.peaks)
        [s.peaks,s.peaks_lags,w,p] = findpeaks(s.fsignal(floor(s.peak_win_l/2):end-floor(s.peak_win_l/2)),'MinPeakDistance',0.75*s.av_peak_spac,'SortStr','descend','NPeaks',1);
        s.peaks_lags = s.peaks_lags+floor(s.peak_win_l/2);
        s.comment = [s.comment 'Random peak selected because no prominent peak detected'];
    end

    % %Plot peaks
    % figure(1)
    % fip3=plot(s.signal_t(s.peaks_lags),s.peaks,'vk');
    % hold on

    %Find most prominent peak
    mp_peak_num = find(p==max(p));
    %Save peak height and peak lag in variable
    mp_peak = s.peaks(mp_peak_num);
    mp_peak_lg = s.peaks_lags(mp_peak_num);

    %%
    %Extract most prominent peak window from curve signal 
    %================================
    s.ref_peak = s.fsignal(mp_peak_lg-floor(s.peak_win_l/2)+1:mp_peak_lg+floor(s.peak_win_l/2));
    s.ref_peak_lag = s.signal_t(mp_peak_lg-floor(s.peak_win_l/2)+1:mp_peak_lg+floor(s.peak_win_l/2));
    % %Calculate the number of moving window that can be juxtaposed along the
    % %signal length
    % n_peak_wins = floor(size(s.signal_t,1)/s.ref_peak_l);

    % %Plot the first moving window
    % figure (1)
    % fip4=plot(s.ref_peak_lag,s.ref_peak,'-og');
    % legend([f1p1 fip2 fip3 fip4], {'Original signal', 'FFT low-pass filter and baseline correction','Detected peaks','Reference window'});


    %%
    %Pad the curve signal with mean*zeros in front and back 
    %================================
    %calculate mean of curve
    mcurve = nanmean(s.fsignal);

    %Pad curve with a full moving window length in front and back
    %Add zeros in front
    s.pd_signal = [ones(s.peak_win_l,1)*mcurve;s.fsignal;ones(s.peak_win_l,1)*mcurve];
    s.pd_t = linspace(0,size(s.pd_signal,1),size(s.pd_signal,1))'/fs;

    %%Plot padded signal 
    %figure(3)
    % plot(s.pd_t,s.pd_signal)
    % hold on
    % legend('Padded and filtered signal')

    %%
    %Cross-correlate the reference peak with the curve signal
    %================================

    %Cross-correlate reference window with signal
    [s.x_curve_win,s.x_lags] = xcorr(s.pd_signal,s.ref_peak);
    %Extract positive part of the cross-correlation signal
    s.x_curve_win = s.x_curve_win(s.x_lags>=0);
    s.x_curve_win = s.x_curve_win(1:size(s.fsignal,1));
    s.x_lags = s.x_lags(s.x_lags>=0);
    s.x_lags = s.x_lags(1:size(s.fsignal,1));

    % %Plot the cross-correlated signal
    % figure(4)
    % plot((s.x_lags+s.peak_win_l/2+1)/fs,s.x_curve_win)

    %Find correlation peaks
    [s.xcorr_peaks,s.xcorr_peaks_lags,w,p] = findpeaks(s.x_curve_win,'MinPeakDistance',floor(s.peak_win_l/2),'MinPeakProminence',0.3*max(s.x_curve_win));
    if isempty(s.xcorr_peaks)
        s.xcorr_peaks = s.x_curve_win(1);
        s.xcorr_peaks_lags = 1;
    end

    %Save the number of peaks found
    p_av.n_peaks = size(s.xcorr_peaks,1);

    %Compensate for the padding
    s.pd_xcorr_peaks_lags = s.xcorr_peaks_lags+floor(s.peak_win_l/2);

    % %Plot the peaks on the cross-correlated signal
    % hold on
    % plot(s.pd_xcorr_peaks_lags/fs,s.xcorr_peaks,'ok')
    % hold on
    % %Plot the padded curve, *1e-8 is a scaling factor for the plotting on same
    % %axis
    % plot(s.pd_t,s.pd_signal*1e-8)
    % hold on
    % legend('Cross-correlation of signal with reference peak','Detected peaks','Padded and filtered signal')


    %%
    %Extract the repeating windows
    %================================

    %Extract the repeating windows, setting the padding elements to NaN to
    %neglect them
    s.pd_signal(1:s.peak_win_l) = nan(s.peak_win_l,1);
    s.pd_signal(end-s.peak_win_l+1:end) = nan(s.peak_win_l,1);
    p_av.peaks = zeros(s.peak_win_l,p_av.n_peaks);
    for i = 1:p_av.n_peaks
        p_av.peaks(:,i) = s.pd_signal(s.pd_xcorr_peaks_lags(i)-floor(s.peak_win_l/2)+1:s.pd_xcorr_peaks_lags(i)+ceil(s.peak_win_l/2));
    end
    %%
    %Calculate the average peak based on the repeating peak shape
    %================================

    %Calculate the average peak and the standard deviation envelop 
    p_av.av_peak = nanmean(p_av.peaks,2);
    p_av.av_peak_std = nanstd(p_av.peaks,0,2);

    %Find minimum and remove y-offset
    p_av.filtyoffs = min(p_av.av_peak);
    p_av.av_peak = p_av.av_peak - p_av.filtyoffs;

    %Get time vector for peaks average
    p_av.t_peak = p_av.peak_wins_t(1:s.peak_win_l);

    % %Plot all repeating signal windows overlapped
    % figure(5)
    % f5p1 = plot(p_av.t_peak,p_av.peaks);
    % hold on
    % %Plot the average peak
    % f5p2 = plot(p_av.t_peak,p_av.av_peak,'-*k');
    % hold on
    % %Plot the std envelop
    % f5p3=plot(p_av.t_peak,p_av.av_peak-p_av.av_peak_std,':k');
    % hold on
    % f5p4=plot(p_av.t_peak,p_av.av_peak+p_av.av_peak_std,':k');
    % legend([f5p2 f5p3],{'Average peak signal','Standard deviation envelop'})

    %================================

    % %================================
    % %Control code to see how well aligned the peaks are using cross-correlation
    % %of the extracted peaks. 
    % %NOTE: A second round of alignement and
    % %y-alignement of the peak maximum could also be performed as part of this step as well
    % %================================
    % 
    % %Take the cross-correlation of the extracted repeating windows
    % [s.x_curve_win,s.x_lags] = xcorr(p_av.peaks,'coeff');
    % %Extract the cross correlation of the first windows with the others
    % s.x_curve_win = s.x_curve_win(:,1:end);
    % 
    % %Plot the cross-correlation signals
    % figure(6)
    % plot(s.x_lags/fs,s.x_curve_win)
    % hold on
    % legend('Cross-correlation of the extracted peaks')
    % %================================

    %Find the width of each peaks and get the statistics
    %=================================
    width = nan(size(p_av.peaks,2),1);
    for i =1:size(p_av.peaks,2) 
        test = floor(0.25*s.ref_peak_l);
        [~,~,width_i,~] = findpeaks(p_av.peaks(floor(0.25*s.ref_peak_l):end-floor(0.25*s.ref_peak_l),i),'MinPeakProminence',0.5*(max(p_av.av_peak)-min(p_av.av_peak)),'SortStr','descend', 'NPeaks',1);
        if ~isempty(width_i)
            width(i) = width_i;
        end
    end
    p_av.av_peak_width = nanmean(width)/fs;
    p_av.av_peak_width_std = nanstd(width)/fs;

    %Calculate properties of av peak min and max
    p_av = find_min_max(s, p_av);

    
    %Calculate properties of all peak min and max
    stats.peak_durations = [];
    stats.time_to_peaks = [];
    stats.amplitudes = [];
    stats.display_peaks = [];
    stats.delay_times = [];
    analyzedCount = 0;
    for ipeak = 1:size(p_av.peaks, 2)
       if sum(isnan(p_av.peaks(:,ipeak))) > size(p_av.peaks(:,ipeak),1) / 2
           continue;
       end
       analyzedCount = analyzedCount + 1;
       cur_p = p_av;
       cur_p.av_peak = cur_p.peaks(:,ipeak);
       cur_p = find_min_max(s, cur_p);
       stats.peak_durations(analyzedCount) = cur_p.peak_min_t(2) - cur_p.peak_min_t(1);
       stats.time_to_peaks(analyzedCount) = cur_p.peak_max_t - cur_p.peak_min_t(1);
       stats.amplitudes(analyzedCount) = cur_p.peak_amp;
       stats.display_peaks(:,analyzedCount) = cur_p.av_peak;
       stats.delay_times(analyzedCount) = cur_p.peak_min_t(2) - cur_p.peak_max_t;
    end
    stats.peak_duration_av = nanmean(stats.peak_durations);
    stats.peak_duration_std = nanstd(stats.peak_durations);
    stats.time_to_peak_av = nanmean(stats.time_to_peaks);
    stats.time_to_peak_std = nanstd(stats.time_to_peaks);
    stats.delay_time_av = nanmean(stats.delay_times);
    stats.delay_time_std = nanstd(stats.delay_times);
    stats.amplitude_av = nanmean(stats.amplitudes);
    stats.amplitude_std = nanstd(stats.amplitudes);
    
    %Calculate the integral under the curve
    p_av.peak_area_contr = sum(p_av.av_peak(min(p_av.peak_min_t):p_av.peak_max_t)*(p_av.peak_wins_t(2)-p_av.peak_wins_t(1)));
    p_av.peak_area_contr_std = sum((p_av.av_peak(min(p_av.peak_min_t):p_av.peak_max_t)+p_av.av_peak_std(min(p_av.peak_min_t):p_av.peak_max_t))*(p_av.peak_wins_t(2)-p_av.peak_wins_t(1)))-p_av.peak_area_contr;
    p_av.peak_area_rel = sum(p_av.av_peak(p_av.peak_max_t:max(p_av.peak_min_t))*(p_av.peak_wins_t(2)-p_av.peak_wins_t(1)));
    p_av.peak_area_rel_std = sum((p_av.av_peak(p_av.peak_max_t:max(p_av.peak_min_t))+p_av.av_peak_std(p_av.peak_max_t:max(p_av.peak_min_t)))*(p_av.peak_wins_t(2)-p_av.peak_wins_t(1)))-p_av.peak_area_contr;
    p_av.peak_area_tot = p_av.peak_area_contr + p_av.peak_area_rel;
    p_av.peak_area_tot_std = sqrt(p_av.peak_area_contr_std^2+p_av.peak_area_rel_std^2);
    %%
    %Take the derivative
    %================================
    if incl_diff

        p_av.d_t_peak  = diff(p_av.peak_wins_t,1);
        p_av.d_peaks = diff(p_av.peaks,1)./p_av.d_t_peak(1);
        p_av.d_t_peak  = p_av.t_peak(1:end-1);

        %Calculate the average peak derivative and the standard deviation envelop 
        p_av.d_av_peak = nanmean(p_av.d_peaks,2);
        p_av.d_av_peak_std = nanstd(p_av.d_peaks,0,2);

        %Find max point for the contracting speed
        [p_av.d_peak_max,p_av.d_peak_max_t] = findpeaks(p_av.d_av_peak(min(p_av.peak_min_t):min(max(p_av.peak_min_t),size(p_av.d_av_peak,1))),'MinPeakDistance',size(p_av.d_av_peak (min(p_av.peak_min_t):min(max(p_av.peak_min_t),size(p_av.d_av_peak,1))),1)/2,'SortStr','descend','NPeaks',1);
        if isempty(p_av.d_peak_max)
            [p_av.d_peak_max,p_av.d_peak_max_t] = max(p_av.d_av_peak (min(p_av.peak_min_t):min(max(p_av.peak_min_t),size(p_av.d_av_peak,1))));
        end
        p_av.d_peak_max = p_av.d_peak_max(1);
        p_av.d_peak_max_t = p_av.d_peak_max_t(1)+min(p_av.peak_min_t)-1;
        p_av.d_peak_max_std = p_av.d_av_peak_std(p_av.d_peak_max_t);

        %Find min points for the relaxing speed
        [p_av.d_peak_min,p_av.d_peak_min_t] = findpeaks(-p_av.d_av_peak (min(p_av.peak_min_t):min(max(p_av.peak_min_t),size(p_av.d_av_peak,1))),'MinPeakDistance',size(p_av.d_av_peak (min(p_av.peak_min_t):min(max(p_av.peak_min_t),size(p_av.d_av_peak,1))),1)/2,'SortStr','descend','NPeaks',1);%,'SortStr','descend');
        if isempty(p_av.d_peak_min)
            [p_av.d_peak_min,p_av.d_peak_min_t] = min(p_av.d_av_peak(min(p_av.peak_min_t):min(max(p_av.peak_min_t),size(p_av.d_av_peak,1))));
        end

        p_av.d_peak_min = -p_av.d_peak_min(1);
        p_av.d_peak_min_t = p_av.d_peak_min_t(1)+min(p_av.peak_min_t)-1;
        %p_av.d_peak_min = min(p_av.d_peak_min);
        p_av.d_peak_min_std = p_av.d_av_peak_std(p_av.d_peak_min_t);
    end
end

function p_av = find_min_max(s, p_av)

    %%
    %Find relax and contracted point in the average peak
    %================================
    %Find the max peak

    %end_limit = size(p_av.av_peak,1)-floor(0.25*s.ref_peak_l)
    [p_av.peak_max,p_av.peak_max_t,w,p] = findpeaks(p_av.av_peak(floor(0.25*s.ref_peak_l):end-floor(0.25*s.ref_peak_l)),'MinPeakProminence',0.5*(max(p_av.av_peak)-min(p_av.av_peak)),'SortStr','descend', 'NPeaks',1);%,'MinPeakDistance',s.ref_peak_l/2
    if isempty(p_av.peak_max)
        [p_av.peak_max,p_av.peak_max_t,w,p] = findpeaks(p_av.av_peak(floor(0.25*s.ref_peak_l):end-floor(0.25*s.ref_peak_l)),'SortStr','descend', 'NPeaks',1);%'MinPeakDistance',s.ref_peak_l/2,
    end
    if isempty(p_av.peak_max)
        [p_av.peak_max,p_av.peak_max_t] = max(p_av.av_peak(floor(0.25*s.ref_peak_l):end-floor(0.25*s.ref_peak_l)));
    end
    p_av.peak_max_t = p_av.peak_max_t+floor(0.25*s.ref_peak_l)-1;
    p_av.peak_max_t = p_av.peak_max_t(1);
    p_av.peak_max = p_av.peak_max(1);
    p_av.peak_max_std = p_av.av_peak_std(p_av.peak_max_t);

    %find the stadard deviation along the x-axis
    %[value, index] = min(abs(p_av.av_peak(1:p_av.peak_max_t)+p_av.av_peak_std(1:p_av.peak_max_t) - p_av.peak_max));
    %p_av.peak_max_t_std = p_av.peak_max_t-index;

    %Find the min (relax) point
    %on the contraction side of the peak
    [p_av.peak_min,p_av.peak_min_t] = findpeaks([-p_av.av_peak(1)*1.01; -p_av.av_peak(1:max(3,p_av.peak_max_t))],'SortStr','descend','NPeaks',1);%'MinPeakDistance',s.ref_peak_l/2,
    p_av.peak_min_t = p_av.peak_min_t-1;
    if -p_av.av_peak(p_av.peak_min_t) < -p_av.av_peak(1)
        p_av.peak_min_t = 1;
        p_av.peak_min = -p_av.av_peak(1);
    end
    %on the relaxation side of the peak
    [p_av.peak_min_2,p_av.peak_min_t_2] = findpeaks(-p_av.av_peak(min(p_av.peak_max_t,end-3):end),'SortStr','descend','NPeaks',1);
    if -p_av.av_peak(p_av.peak_min_t_2+p_av.peak_max_t-1) < -p_av.av_peak(end)
        p_av.peak_min_t_2 = length(p_av.av_peak) - p_av.peak_max_t + 1;
        p_av.peak_min_2 = -p_av.av_peak(end);
    end
    %concatenate peak min in single array
    p_av.peak_min_t = [p_av.peak_min_t, p_av.peak_min_t_2+p_av.peak_max_t-1];
    p_av.peak_min = [p_av.peak_min,p_av.peak_min_2];

    %Check the peak min
    if size(p_av.peak_min,2)==1
        if p_av.peak_min_t < p_av.peak_max_t
            p_av.peak_min = [p_av.peak_min(1), -p_av.av_peak(end)];
            p_av.peak_min_t = [p_av.peak_min_t, size(p_av.av_peak,2)];
        else
            p_av.peak_min = [-p_av.av_peak(1), p_av.peak_min(end)];
            p_av.peak_min_t = [1, p_av.peak_min_t];
        end
    end
    if isempty(p_av.peak_min)
        p_av.peak_min = [-p_av.av_peak(1) -p_av.av_peak(end)];
        p_av.peak_min_t = [1 size(p_av.av_peak,1)];
    end
    if p_av.peak_min_t(2) < p_av.peak_max_t
        p_av.peak_min(2) = -p_av.av_peak(end);
        p_av.peak_min_t(2) = size(p_av.av_peak,1);
    end
    %take negative again
    p_av.peak_min = -p_av.peak_min;
    %p_av.peak_min_t = p_av.peak_min_t(find(p_av.peak_min == min(p_av.peak_min)));
    p_av.peak_min_std = sqrt(mean(p_av.av_peak_std(p_av.peak_min_t).^2));
    p_av.peak_basel = min(p_av.peak_min);
    p_av.peak_basel_std = p_av.av_peak_std(min(p_av.peak_min_t));

    %Calculate the peak amplitude
    p_av.peak_amp = nanmean(p_av.peak_max-p_av.peak_basel);
    p_av.peak_amp_std = sqrt(p_av.peak_max_std^2+p_av.peak_basel_std^2);
    %%Compare with the peak prominence
    %peak_prom = max(p);

end