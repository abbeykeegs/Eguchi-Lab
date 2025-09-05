function CalciumAnalysisLoad(Calc_main)
    figuresize=[500,1060];
    %get screen size
    screensize = get(0,'ScreenSize');
    %position figure on center of screen
    xpos = ceil((screensize(3)-figuresize(2))/2);
    ypos = ceil((screensize(4)-figuresize(1))/2);
    %create figure; invisible at first
    h_init(1).fig=figure(...
        'position',[xpos, ypos, figuresize(2), figuresize(1)],...
        'units','pixels',...
        'renderer','OpenGL',...
        'MenuBar','none',...
        'PaperPositionMode','auto',...
        'Name','Initialization',...
        'NumberTitle','off',...
        'Resize','off',...
        'Color',[.2,.2,.2],...
        'visible','off');

    %color of the background and foreground
    pcolor = [.2 .2 .2];
    ptcolor = [1 1 1];
    bcolor = [.3 .3 .3];
    btcolor = [1 1 1];
    h_init(1).ForegroundColor = ptcolor;
    h_init(1).BackgroundColor = pcolor;

    %create uipanel for readin & buttons
    %uipanel: contains readin button for videos and folders
    h_init(1).panel_read = uipanel('Parent',h_init(1).fig,'Title','Open 1 or more video files','units','pixels','Position',[20,350,155,135]);
    h_init(1).panel_read.ForegroundColor = ptcolor;
    h_init(1).panel_read.BackgroundColor = pcolor;
    %button 1: read in videos
    h_init(1).button_readvid = uicontrol('Parent',h_init(1).panel_read,'style','pushbutton','position',[5,95,140,25],'string','Add video (czi)');

    %create uipanel to display and delete loaded videos
    %uipanel: list all the loaded videos, invisible
    h_init(1).panel_list = uipanel('Parent',h_init(1).fig,'Title','List of loaded videos','units','pixels','Position',[20,45,155,300],'visible','off');
    h_init(1).panel_list.ForegroundColor = ptcolor;
    h_init(1).panel_list.BackgroundColor = pcolor;
    %listbox 1: lists videos
    h_init(1).listbox_display = uicontrol('Parent',h_init(1).panel_list,'style','listbox','position',[5,35,140,250]);
    %button 3: delete current video
    h_init(1).button_delete = uicontrol('Parent',h_init(1).panel_list,'style','pushbutton','position',[5,5,140,25],'string','Delete selected');

    %create uipanel to display video information and first frame
    %uipanel:
    h_init(1).panel_vid = uipanel('Parent',h_init(1).fig,'Title','Video information','units','pixels','Position',[190,45,850,440],'visible','off');
    h_init(1).panel_vid.ForegroundColor = ptcolor;
    h_init(1).panel_vid.BackgroundColor = pcolor;

    %axes: display first frame of current
    h_init(1).axes_C1 = axes('Parent',h_init(1).panel_vid,'Units', 'pixels','Position',[15,35,400,290]);
    h_init(1).axes_C2 = axes('Parent',h_init(1).panel_vid,'Units','pixels','Position',[430,35,400,290]);
    %button 4: forwards
    h_init(1).button_forwards = uicontrol('Parent',h_init(1).panel_vid,'style','pushbutton','position',[385,5,25,25],'string','>');
    %button 5: backwards
    h_init(1).button_backwards = uicontrol('Parent',h_init(1).panel_vid,'style','pushbutton','position',[360,5,25,25],'string','<');

    %button 6: left roi
    h_init(1).button_left = uicontrol('Parent',h_init(1).panel_vid,'style','pushbutton','position',[410,385,120,15],'string','Left roi');
    %button 6b: right roi
    h_init(1).button_right = uicontrol('Parent',h_init(1).panel_vid,'style','pushbutton','position',[410,365,120,15],'string','Right roi');
    %button 6c: custom roi
    h_init(1).button_custom = uicontrol('Parent',h_init(1).panel_vid,'style','pushbutton','position',[410,345,120,15],'string','Custom roi');

    %create ok button
    h_init(1).button_ok = uicontrol('Parent',h_init(1).fig,'style','pushbutton','position',[835,20,100,20],'string','OK','visible','off');
 
    %text 1: show which video (i/n)
    h_init(1).text_whichvid = uicontrol('Parent',h_init(1).panel_vid,'style','text','position',[300,10,50,15],'string','(1/1)','HorizontalAlignment','left');
    h_init(1).text_whichvid.ForegroundColor = ptcolor;
    h_init(1).text_whichvid.BackgroundColor = pcolor;

    %text 4: show number of frames
    h_init(1).text_nframes = uicontrol('Parent',h_init(1).panel_vid,'style','text','position',[10,385,150,15],'string','Number of frames','HorizontalAlignment','left');
    h_init(1).text_nframes.ForegroundColor = ptcolor;
    h_init(1).text_nframes.BackgroundColor = pcolor;

    %text 5: show cellname
    h_init(1).text_cellname = uicontrol('Parent',h_init(1).panel_vid,'style','text','position',[10,405,150,15],'string','Cell name','HorizontalAlignment','left');
    h_init(1).text_cellname.ForegroundColor = ptcolor;
    h_init(1).text_cellname.BackgroundColor = pcolor;

    %text 7: show which video (name)
    h_init(1).text_whichvidname = uicontrol('Parent',h_init(1).panel_vid,'style','text','position',[20,10,240,15],'string','Experiment','HorizontalAlignment','left');
    h_init(1).text_whichvidname.ForegroundColor = ptcolor;
    h_init(1).text_whichvidname.BackgroundColor = pcolor;

    %edit 1: number of frames
    h_init(1).edit_nframes = uicontrol('Parent',h_init(1).panel_vid,'style','edit','position',[120,385,70,15],'HorizontalAlignment','center');
    %edit 2: cellname
    h_init(1).edit_cellname = uicontrol('Parent',h_init(1).panel_vid,'style','edit','position',[120,405,70,15],'HorizontalAlignment','center');


    %assign callbacks to buttons
    set(h_init(1).button_readvid,'callback',{@init_push_readvid,h_init})
    set(h_init(1).button_delete,'callback',{@init_push_delete,h_init})
    set(h_init(1).button_forwards,'callback',{@init_push_forwards_backwards,h_init,'forwards'})
    set(h_init(1).button_backwards,'callback',{@init_push_forwards_backwards,h_init,'backwards'})
    set(h_init(1).button_left,'callback',{@init_push_create_roi,h_init,'left'})
    set(h_init(1).button_right,'callback',{@init_push_create_roi,h_init,'right'})
    set(h_init(1).button_custom,'callback',{@init_push_create_roi,h_init,'custom'})
    set(h_init(1).button_ok,'callback',{@init_push_ok,h_init,Calc_main})


    %if there are already files on the stack, make the other panels visible too
    %and show parameters

    if ~isempty(getappdata(0,'calc_init_user_filenamestack'))                          %files on stack
        %load shared parameters
        calc_init_user_counter=getappdata(0,'calc_init_user_counter');                %current video number
        calc_init_user_Nfiles=getappdata(0,'calc_init_user_Nfiles');                  %number of videos
        calc_init_user_Nframes=getappdata(0,'calc_init_user_Nframes');                %number of frames
        calc_init_user_cellname=getappdata(0,'calc_init_user_cellname');              %cellname
        calc_init_user_filenamestack=getappdata(0,'calc_init_user_filenamestack');    %filestack
        calc_init_user_preview_C1=getappdata(0,'calc_init_user_preview_C1');          %preview frame for each video
        calc_init_user_preview_C2=getappdata(0,'calc_init_user_preview_C2');          %preview frame for each video
        calc_init_user_background_roi=getappdata(0,'calc_init_user_background_roi');  %region of background roi
        
        %change display strings and values
        %put video files into listbox
        set(h_init(1).listbox_display,'String',calc_init_user_filenamestack);
        %select item in listbox
        set(h_init(1).listbox_display,'Value',calc_init_user_counter);

        %display 1st frame of new video
        axes(h_init(1).axes_C1);
        imshow(calc_init_user_preview_C1{calc_init_user_counter}); hold on;

        axes(h_init(1).axes_C2);
        imshow(calc_init_user_preview_C2{calc_init_user_counter}); hold on;
        
        %display new settings
        set(h_init(1).edit_nframes,'String',num2str(calc_init_user_Nframes{calc_init_user_counter}));                             %number of frames
        set(h_init(1).edit_cellname,'String',calc_init_user_cellname{calc_init_user_counter});                                    %cellname
        set(h_init(1).text_whichvidname,'String',[calc_init_user_filenamestack{1,calc_init_user_counter},' (showing 1st frame)']);%name of video
        set(h_init(1).text_whichvid,'String',[num2str(calc_init_user_counter),'/',num2str(calc_init_user_Nfiles)]);               %which video (i/N)
        set(h_init(1).edit_nframes,'Enable','off');         %disable Nframes edit
        %forwards and backwards buttons enable/disable
        if calc_init_user_counter==calc_init_user_Nfiles      %if current vid is the last on stack
            set(h_init(1).button_forwards,'Enable','off');  %disable forwards
        else
            set(h_init(1).button_forwards,'Enable','on');   %enable forwards
        end
        if calc_init_user_counter==1                         %if current vid is the first on stack
            set(h_init(1).button_backwards,'Enable','off'); %disable backwards
        else
            set(h_init(1).button_backwards,'Enable','on');  %enable backwards
        end
        %panels, button, listbox
        set(h_init(1).panel_vid,'Visible','on');        %show video panel
        set(h_init(1).panel_list,'Visible','on');       %show list panel
        set(h_init(1).button_ok,'Visible','on');        %show button panel
        set(h_init(1).button_ok,'Enable','off');        %disable button panel
        set(h_init(1).listbox_display,'Enable','off');  %disable listbox editing
    else %turn off panels
        set(h_init(1).panel_vid,'Visible','off');       %hide video panel
        set(h_init(1).panel_list,'Visible','off');      %hide list panel
        set(h_init(1).button_ok,'Visible','off');       %hide ok button
    end
    
    %make figure visible
    set(h_init(1).fig,'visible','on');
 
end

function init_push_readvid(hObject, eventdata, h_init)

%reads in a series of videos

%disable figure during calculation
enableDisableFig(h_init(1).fig,0);
%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_init(1).fig,1));

%error catching loop
try
    %load what shared para we need
    calc_init_user_filenamestack=getappdata(0,'calc_init_user_filenamestack');
    calc_init_user_pathnamestack=getappdata(0,'calc_init_user_pathnamestack');
    calc_init_user_Nframes=getappdata(0,'calc_init_user_Nframes');
    calc_init_user_cellname=getappdata(0,'calc_init_user_cellname');
    calc_init_user_preview_C1=getappdata(0,'calc_init_user_preview_C1');
    calc_init_user_preview_C2=getappdata(0,'calc_init_user_preview_C2');    
 
    if isempty(calc_init_user_pathnamestack)
        calc_init_user_pathnamestack{1} = cd;
    end
    
    %load video files: filename: 1xN cell w. strings; pathname string
    [filename,pathname] = uigetfile({'*.czi'},'Select calcium videos',calc_init_user_pathnamestack{1},'MultiSelect','on');
    %really a file or did user press cancel?
    if isequal(filename,0)
        return;
    end
    filename = cellstr(filename);
    
    %look if there already files on the image stack
    Nfiles0=size(calc_init_user_filenamestack,2);
    
    %add new files and paths to stacks
    for i=1:size(filename,2)
        [~,name,~]=fileparts(strcat(pathname,filename{1,i}));
        calc_init_user_filenamestack{1,Nfiles0+i}=name;
        calc_init_user_pathnamestack{1,Nfiles0+i}=pathname;
    end
    
    %put video files into listbox
    set(h_init(1).listbox_display,'String',calc_init_user_filenamestack);
    
    %new number of files
    calc_init_user_Nfiles=size(calc_init_user_filenamestack,2);

    %loop over vids and extract first frame data
    for j = 1:size(filename,2)

        %use bioformats for import
        ext = '.czi';
        [~,reader]=evalc('bfGetReader([calc_init_user_pathnamestack{1,Nfiles0+j},calc_init_user_filenamestack{1,Nfiles0+j},ext]);');
        omeMeta = reader.getMetadataStore();

        Nchannels = omeMeta.getChannelCount(0);
        N=omeMeta.getPlaneCount(0)/Nchannels; %number of frames
        calc_init_user_Nframes{Nfiles0+j} = N;
        calc_init_user_cellname{Nfiles0+j}=['cell_',num2str(Nfiles0+j)];
        frame = 1;
        [~,image]=evalc('bfGetPlane(reader, frame);');
        %convert to grey
        if ndims(image) == 3
            image=rgb2gray(image);
        end
        image=normalise(image);
        image=im2uint8(image);

        %save 1st frame in display
        calc_init_user_preview_C1{Nfiles0+j}=normalise(image);

        frame = 2;
        [~,image]=evalc('bfGetPlane(reader, frame);');
        %convert to grey
        if ndims(image) == 3
            image=rgb2gray(image);
        end
        image=normalise(image);
        image=im2uint8(image);

        %save 2st frame in display
        calc_init_user_preview_C2{Nfiles0+j}=normalise(image);  
               
        %set initial outlines and binaries to []
        calc_init_user_roi_background{Nfiles0+j}=[];
        calc_init_user_roi_x{Nfiles0+j}=[];
        calc_init_user_roi_y{Nfiles0+j}=[];
        calc_init_user_roi_region{Nfiles0+j} = [];
    end
    
    %turn on panels
    set(h_init(1).panel_list,'Visible','on');
    set(h_init(1).panel_vid,'Visible','on');
    set(h_init(1).button_ok,'Visible','on');
    
    set(h_init(1).edit_nframes,'String',num2str(calc_init_user_Nframes{1}));
    set(h_init(1).edit_nframes,'Enable','off');
    
    set(h_init(1).edit_cellname,'String',calc_init_user_cellname{1});
    set(h_init(1).text_whichvidname,'String',[calc_init_user_filenamestack{1,1},' (showing 1st frame)']);
    
    %set frame1 of 1st channel
    axes(h_init(1).axes_C1);
    imshow(calc_init_user_preview_C1{1});hold on;
    plot(calc_init_user_roi_x{1},calc_init_user_roi_y{1},'r','LineWidth',2);
    hold off;
    
    %set frame1 of 2nd channel
    axes(h_init(1).axes_C2);
    imshow(calc_init_user_preview_C2{1});hold on;
    plot(calc_init_user_roi_x{1},calc_init_user_roi_y{1},'r','LineWidth',2);
    hold off;
   
    set(h_init(1).axes_C1,'Visible','on');
    set(h_init(1).axes_C2,'Visible','on');
    
    %select item in listbox
    set(h_init(1).listbox_display,'Value',1);
    
    %update text (x/N)
    set(h_init(1).text_whichvid,'String',[num2str(1),'/',num2str(calc_init_user_Nfiles)]);
    
    %forwards and backwards buttons enable/disable
    if 1==calc_init_user_Nfiles %if current vid is the last on stack
        set(h_init(1).button_forwards,'Enable','off');  %disable forwards
    else
        set(h_init(1).button_forwards,'Enable','on');   %enable forwards
    end                     %if current vid is the first on stack
    set(h_init(1).button_backwards,'Enable','off'); %disable backwards
    

    %initiate counter for going through all videos
    calc_init_user_counter=1;
    
    %store everything for shared use
    setappdata(0,'calc_init_user_filenamestack',calc_init_user_filenamestack);
    setappdata(0,'calc_init_user_pathnamestack',calc_init_user_pathnamestack);
    setappdata(0,'calc_init_user_counter',calc_init_user_counter);
    setappdata(0,'calc_init_user_Nfiles',calc_init_user_Nfiles);
    setappdata(0,'calc_init_user_cellname',calc_init_user_cellname);
    setappdata(0,'calc_init_user_Nframes',calc_init_user_Nframes);
    setappdata(0,'calc_init_user_preview_C1',calc_init_user_preview_C1);
    setappdata(0,'calc_init_user_preview_C2',calc_init_user_preview_C2);
    setappdata(0,'calc_init_user_roi_x',calc_init_user_roi_x);
    setappdata(0,'calc_init_user_roi_y',calc_init_user_roi_y);
    setappdata(0,'calc_init_user_roi_background',calc_init_user_roi_background);
    setappdata(0,'calc_init_user_roi_region', calc_init_user_roi_region);

    %update statusbar
    sb=statusbar(h_init(1).fig,'Import - Done !');
    sb.getComponent(0).setForeground(java.awt.Color(0,.5,0));
    
    %grey out back button
    set(h_init(1).button_backwards,'Enable','off');
    
    %grey out listbox
    set(h_init(1).listbox_display,'Enable','off');
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'));
    
    %if there is an error, and there are no files on the stack, do not
    %display anything
    if isempty(getappdata(0,'calc_init_user_filenamestack'))
        set(h_init(1).panel_vid,'Visible','off');
        set(h_init(1).panel_list,'Visible','off');
        set(h_init(1).button_ok,'Visible','off');
    end
        
end 
end
    
function init_push_create_roi(hObject, eventdata, h_init, flag)

    %disable figure during calculation
    enableDisableFig(h_init(1).fig,0);
try
    %turn back on in the end
    clean1=onCleanup(@()enableDisableFig(h_init(1).fig,1));

    calc_init_user_roi_x=getappdata(0,'calc_init_user_roi_x');
    calc_init_user_roi_y=getappdata(0,'calc_init_user_roi_y');
    calc_init_user_roi_background=getappdata(0,'calc_init_user_roi_background');
    calc_init_user_preview_C1=getappdata(0,'calc_init_user_preview_C1');
    calc_init_user_preview_C2=getappdata(0,'calc_init_user_preview_C2');
    calc_init_user_roi_region=getappdata(0,'calc_init_user_roi_region');
    calc_init_user_counter=getappdata(0,'calc_init_user_counter');

    image_size = size(calc_init_user_preview_C1{calc_init_user_counter});
    if strcmp(flag, 'left')
        center = [image_size(1) / 2, image_size(2) / 8]; 
        set(h_init(1).button_left,'ForegroundColor',[0 .5 0]);
        set(h_init(1).button_right,'ForegroundColor',[0 0 0]);
        set(h_init(1).button_custom,'ForegroundColor',[0 0 0]);
        calc_init_user_roi_region{calc_init_user_counter} = 'left';
    elseif strcmp(flag, 'right')
        center = [image_size(1) / 2, 7*image_size(2) / 8]; 
        set(h_init(1).button_left,'ForegroundColor',[0 0 0]);
        set(h_init(1).button_right,'ForegroundColor',[0 .5 0]);
        set(h_init(1).button_custom,'ForegroundColor',[0 0 0]);
        calc_init_user_roi_region{calc_init_user_counter} = 'right';
    else
        set(h_init(1).button_left,'ForegroundColor',[0 0 0]);
        set(h_init(1).button_right,'ForegroundColor',[0 0 0]);
        set(h_init(1).button_custom,'ForegroundColor',[0 .5 0]);
        calc_init_user_roi_region{calc_init_user_counter} = 'custom';
        %open image in figure, and let user draw
        %show in new fig
        hf=figure;
        cellimage=calc_init_user_preview_C1{calc_init_user_counter};
        cellimage_enh=imadjust(cellimage,stretchlim(cellimage),[]);
        imshow(cellimage_enh);hold on;
        title(['Select (one) location of roi. Press Enter to stop.'])
        
        %user selected point
        [x,~] = getpts;
        center = [image_size(1) / 2, x];
        
%         %get cell blobb
%         roi = hFH.createMask();
%         roi_outline = bwboundaries(roi);
        %close fig
        close(hf);
    end
    
    radius = image_size(1) / 2;
    [x, y] = meshgrid(1:image_size(2), 1:image_size(1));
    roi = zeros(image_size);
    roi((x-center(2)).^2 +(y-center(1)).^2 < radius^2) = 1;
    roi_outline = bwboundaries(roi);
    calc_init_user_roi_background{calc_init_user_counter} = roi;
    calc_init_user_roi_x{calc_init_user_counter} = roi_outline{1}(:,2);
    calc_init_user_roi_y{calc_init_user_counter} = roi_outline{1}(:,1);
    
    %set frame1 of 1st channel
    axes(h_init(1).axes_C1);
    imshow(calc_init_user_preview_C1{calc_init_user_counter});hold on;
    plot(calc_init_user_roi_x{calc_init_user_counter},calc_init_user_roi_y{calc_init_user_counter},'r','LineWidth',1);
    hold off;
    
    %set frame1 of 2nd channel
    axes(h_init(1).axes_C2);
    imshow(calc_init_user_preview_C2{calc_init_user_counter});hold on;
    plot(calc_init_user_roi_x{calc_init_user_counter},calc_init_user_roi_y{calc_init_user_counter},'r','LineWidth',1);
    hold off;
    
    %check if all vids done
    if sum(cellfun(@isempty,calc_init_user_roi_region)) == 0
        set(h_init(1).button_ok,'Enable','on');
    end
    
    setappdata(0,'calc_init_user_roi_region', calc_init_user_roi_region);
    setappdata(0,'calc_init_user_roi_background',calc_init_user_roi_background);
    setappdata(0,'calc_init_user_roi_x',calc_init_user_roi_x);
    setappdata(0,'calc_init_user_roi_y',calc_init_user_roi_y);
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'));
end
end

function init_push_delete(hObject, eventdata, h_init)
try
    %load what shared para we need
    calc_init_user_Nfiles=getappdata(0,'calc_init_user_Nfiles');
    calc_init_user_cellname=getappdata(0,'calc_init_user_cellname');
    calc_init_user_Nframes=getappdata(0,'calc_init_user_Nframes');
    calc_init_user_filenamestack=getappdata(0,'calc_init_user_filenamestack');
    calc_init_user_pathnamestack=getappdata(0,'calc_init_user_pathnamestack');
    calc_init_user_preview_C1=getappdata(0,'calc_init_user_preview_C1');
    calc_init_user_preview_C2=getappdata(0,'calc_init_user_preview_C2');
    calc_init_user_roi_x=getappdata(0,'calc_init_user_roi_x');
    calc_init_user_roi_y=getappdata(0,'calc_init_user_roi_y');
    calc_init_user_roi_region=getappdata(0,'calc_init_user_roi_region');

    %get selected item in listbox
    index=get(h_init(1).listbox_display,'Value');
    
    %to which video does it jump next?
    if index==calc_init_user_Nfiles
        index_next=index-1;
    else
        index_next=index;
    end
       
    %delete from saved stuff
    calc_init_user_Nfiles=calc_init_user_Nfiles-1;
    calc_init_user_cellname(index)=[];
    calc_init_user_Nframes(index)=[];
    calc_init_user_filenamestack(index)=[];
    calc_init_user_pathnamestack(index)=[];
    calc_init_user_preview_C1(index)=[];
    calc_init_user_preview_C2(index)=[];
    calc_init_user_roi_x(index)=[];
    calc_init_user_roi_y(index)=[];
    calc_init_user_roi_region(index) = [];
    
    set(h_init(1).listbox_display,'String',calc_init_user_filenamestack);
    
    if ~isempty(calc_init_user_filenamestack)
        %look at vid counter
        calc_init_user_counter=index_next;

        flag = calc_init_user_roi_region{calc_init_user_counter};
        if strcmp(flag, 'left')
            set(h_init(1).button_left,'ForegroundColor',[0 .5 0]);
            set(h_init(1).button_right,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_custom,'ForegroundColor',[0 0 0]);
        elseif strcmp(flag, 'right')
            set(h_init(1).button_left,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_right,'ForegroundColor',[0 .5 0]);
            set(h_init(1).button_custom,'ForegroundColor',[0 0 0]);
        elseif strcmp(flag, 'custom')
            set(h_init(1).button_left,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_right,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_custom,'ForegroundColor',[0 .5 0]);
        end        
        %select item in listbox
        set(h_init(1).listbox_display,'Value',calc_init_user_counter);
        
        %display 1st frame of new video
        axes(h_init(1).axes_C1);
        imshow(calc_init_user_preview_C1{calc_init_user_counter}); hold on;
        plot(calc_init_user_roi_x{calc_init_user_counter},calc_init_user_roi_y{calc_init_user_counter},'r','LineWidth',1);
        hold off;
        
        %display 2nd frame of new video
        axes(h_init(1).axes_C2);
        imshow(calc_init_user_preview_C2{calc_init_user_counter});hold on;
        plot(calc_init_user_roi_x{calc_init_user_counter},calc_init_user_roi_y{calc_init_user_counter},'r','LineWidth',1);
        hold off;
    
        %display new settings
        set(h_init(1).edit_nframes,'String',num2str(calc_init_user_Nframes{calc_init_user_counter}));
        set(h_init(1).edit_nframes,'Enable','off');
        set(h_init(1).edit_cellname,'String',calc_init_user_cellname{calc_init_user_counter});
        set(h_init(1).text_whichvidname,'String',[calc_init_user_filenamestack{1,calc_init_user_counter},' (showing 1st frame)']);
        
        set(h_init(1).text_whichvid,'String',[num2str(calc_init_user_counter),'/',num2str(calc_init_user_Nfiles)]);

        if calc_init_user_counter==1
            set(h_init(1).button_backwards,'Enable','off');
        else
            set(h_init(1).button_backwards,'Enable','on');
        end
        if calc_init_user_counter==calc_init_user_Nfiles
            set(h_init(1).button_forwards,'Enable','off');
        else
            set(h_init(1).button_forwards,'Enable','on');
        end
        
        %grey out listbox
        set(h_init(1).listbox_display,'Enable','off');
        
        
    else %hide panels etc
        set(h_init(1).panel_vid,'Visible','off');       %hide video panel
        set(h_init(1).panel_list,'Visible','off');      %hide list panel
        set(h_init(1).button_ok,'Visible','off');       %hide ok button
        calc_init_user_counter=1;
    end 
    
    %store everything for shared use
    setappdata(0,'calc_init_user_Nfiles',calc_init_user_Nfiles);
    setappdata(0,'calc_init_user_cellname',calc_init_user_cellname);
    setappdata(0,'calc_init_user_Nframes',calc_init_user_Nframes);
    setappdata(0,'calc_init_user_filenamestack',calc_init_user_filenamestack);
    setappdata(0,'calc_init_user_pathnamestack',calc_init_user_pathnamestack);
    setappdata(0,'calc_init_user_preview_C1',calc_init_user_preview_C1);
    setappdata(0,'calc_init_user_preview_C2',calc_init_user_preview_C2);
    setappdata(0,'calc_init_user_roi_x',calc_init_user_roi_x);
    setappdata(0,'calc_init_user_roi_y',calc_init_user_roi_y);
    setappdata(0,'calc_init_user_counter',calc_init_user_counter);
    setappdata(0,'calc_init_user_roi_region',calc_init_user_roi_region);
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'));
end
end

function init_push_forwards_backwards(hObject, eventdata, h_init, flag)
%disable figure during calculation
enableDisableFig(h_init(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_init(1).fig,1));


try
    %load what shared para we need
    calc_init_user_counter=getappdata(0,'calc_init_user_counter');
    calc_init_user_Nfiles=getappdata(0,'calc_init_user_Nfiles');
    calc_init_user_Nframes=getappdata(0,'calc_init_user_Nframes');
    calc_init_user_cellname=getappdata(0,'calc_init_user_cellname');
    calc_init_user_filenamestack=getappdata(0,'calc_init_user_filenamestack');
    calc_init_user_pathnamestack=getappdata(0,'calc_init_user_pathnamestack');
    calc_init_user_preview_C1=getappdata(0,'calc_init_user_preview_C1');
    calc_init_user_preview_C2=getappdata(0,'calc_init_user_preview_C2');
    calc_init_user_roi_x=getappdata(0,'calc_init_user_roi_x');
    calc_init_user_roi_y=getappdata(0,'calc_init_user_roi_y');
    calc_init_user_roi_region=getappdata(0,'calc_init_user_roi_region');
    
    %look at vid counter
    if (strcmp(flag,'forwards') && calc_init_user_counter<calc_init_user_Nfiles) || (strcmp(flag, 'backwards') && calc_init_user_counter>1)
        %save settings
        calc_init_user_cellname{calc_init_user_counter}=get(h_init(1).edit_cellname,'String');
       
        if strcmp(flag,'forwards')
            %go to video after
            calc_init_user_counter=calc_init_user_counter+1;
        else
            %go to video before
            calc_init_user_counter=calc_init_user_counter-1;
        end
        
        flag = calc_init_user_roi_region{calc_init_user_counter};
        if strcmp(flag, 'left')
            set(h_init(1).button_left,'ForegroundColor',[0 .5 0]);
            set(h_init(1).button_right,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_custom,'ForegroundColor',[0 0 0]);
        elseif strcmp(flag, 'right')
            set(h_init(1).button_left,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_right,'ForegroundColor',[0 .5 0]);
            set(h_init(1).button_custom,'ForegroundColor',[0 0 0]);
        elseif strcmp(flag, 'custom')
            set(h_init(1).button_left,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_right,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_custom,'ForegroundColor',[0 .5 0]);
        end    
        
        %select item in listbox
        set(h_init(1).listbox_display,'Value',calc_init_user_counter);
        
        %display 1st frame of new video
        axes(h_init(1).axes_C1);
        imshow(calc_init_user_preview_C1{calc_init_user_counter}); hold on;
        plot(calc_init_user_roi_x{calc_init_user_counter},calc_init_user_roi_y{calc_init_user_counter},'r','LineWidth',1);
        hold off;
        
        %display 2nd frame of new video
        axes(h_init(1).axes_C2);
        imshow(calc_init_user_preview_C2{calc_init_user_counter});hold on;
        plot(calc_init_user_roi_x{calc_init_user_counter},calc_init_user_roi_y{calc_init_user_counter},'r','LineWidth',1);
        hold off;
    
        %display new settings
        set(h_init(1).edit_nframes,'String',num2str(calc_init_user_Nframes{calc_init_user_counter}));
        set(h_init(1).edit_nframes,'Enable','off');
        set(h_init(1).edit_cellname,'String',calc_init_user_cellname{calc_init_user_counter});
        set(h_init(1).text_whichvidname,'String',[calc_init_user_filenamestack{1,calc_init_user_counter},' (showing 1st frame)']);
        
        if strcmp(calc_init_user_roi_region{calc_init_user_counter}, 'left')
            set(h_init(1).button_left,'ForegroundColor',[0 .5 0]);
            set(h_init(1).button_right,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_custom,'ForegroundColor',[0 0 0]);
        elseif strcmp(calc_init_user_roi_region{calc_init_user_counter}, 'right')
            set(h_init(1).button_left,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_right,'ForegroundColor',[0 .5 0]);
            set(h_init(1).button_custom,'ForegroundColor',[0 0 0]);
        elseif strcmp(calc_init_user_roi_region{calc_init_user_counter}, 'custom')
            set(h_init(1).button_left,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_right,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_custom,'ForegroundColor',[0 .5 0]);
        else
            set(h_init(1).button_left,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_right,'ForegroundColor',[0 0 0]);
            set(h_init(1).button_custom,'ForegroundColor',[0 0 0]);
        end
    
    end
    
    set(h_init(1).text_whichvid,'String',[num2str(calc_init_user_counter),'/',num2str(calc_init_user_Nfiles)]);
    if (strcmp(flag,'forwards') && calc_init_user_counter==calc_init_user_Nfiles)
        %grey out forwards button
        set(h_init(1).button_forwards,'Enable','off');
        set(h_init(1).button_backwards,'Enable','on');
    elseif (strcmp(flag,'backwards') && calc_init_user_counter==0)
        %grey out backwards button
        set(h_init(1).button_forwards,'Enable','on');
        set(h_init(1).button_backwards,'Enable','off');
    else
        set(h_init(1).button_forwards,'Enable','on');
        set(h_init(1).button_backwards,'Enable','on');
    end
    
    %grey out listbox
    set(h_init(1).listbox_display,'Enable','off');
    
    %check if all vids done
    if sum(cellfun(@isempty,calc_init_user_roi_region)) == 0
        set(h_init(1).button_ok,'Enable','on');
    end
    
    %store everything for shared use
    setappdata(0,'calc_init_user_filenamestack',calc_init_user_filenamestack)
    setappdata(0,'calc_init_user_pathnamestack',calc_init_user_pathnamestack)
    setappdata(0,'calc_init_user_counter',calc_init_user_counter)
    setappdata(0,'calc_init_user_cellname',calc_init_user_cellname)
    setappdata(0,'calc_init_user_Nframes',calc_init_user_Nframes)
    
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'));
end
end
    
function init_push_ok(hObject, eventdata, h_init, Calc_main)

%disable figure during calculation
enableDisableFig(h_init(1).fig,0);

%turn back on in the end
clean1=onCleanup(@()enableDisableFig(h_init(1).fig,1));

try
    %load what shared para we need
    calc_init_user_Nfiles=getappdata(0,'calc_init_user_Nfiles');
    calc_init_user_cellname=getappdata(0,'calc_init_user_cellname');
    calc_init_user_Nframes=getappdata(0,'calc_init_user_Nframes');
    calc_init_user_filenamestack=getappdata(0,'calc_init_user_filenamestack');
    calc_init_user_pathnamestack=getappdata(0,'calc_init_user_pathnamestack');
    calc_init_user_preview_C1=getappdata(0,'calc_init_user_preview_C1');
    calc_init_user_preview_C2=getappdata(0,'calc_init_user_preview_C2');
    calc_init_user_roi_x=getappdata(0,'calc_init_user_roi_x');
    calc_init_user_roi_y=getappdata(0,'calc_init_user_roi_y');
    calc_init_user_roi_region=getappdata(0,'calc_init_user_roi_region');   
    calc_init_user_roi_background=getappdata(0,'calc_init_user_roi_background');   
    
    
    %find min number of frames
    min_Nframes = Inf;
    for j=1:calc_init_user_Nfiles
        min_Nframes = min(min_Nframes, calc_init_user_Nframes{j});
    end
    %loop over vids, and extract data
    calc_init_user_framerate=zeros(calc_init_user_Nfiles,1);
    calc_init_user_adj_profile = cell(calc_init_user_Nfiles,1);
    for j=1:calc_init_user_Nfiles
        %update statusbar
        if calc_init_user_Nfiles==1
            sb=statusbar(h_init(1).fig,'Importing... ');
            sb.getComponent(0).setForeground(java.awt.Color.red);
        else
            sb=statusbar(h_init(1).fig,['Importing... ',num2str(floor(100*(j-1)/calc_init_user_Nfiles)), '%% done']);
            sb.getComponent(0).setForeground(java.awt.Color.red);
        end
        %use bioformats for import
        ext = '.czi';
        [~,data]=evalc('bfopen([calc_init_user_pathnamestack{1,j},calc_init_user_filenamestack{1,j},ext]);');
        metadata = data{1, 2};
        tincrement=str2double(metadata.get('Global Information|Image|T|Interval|Increment #1'));
        calc_init_user_framerate(j)=1/tincrement;
        Nchannels = 2;
        images=data{1,1}; %images
        m = size(images{1,1},1);
        n = size(images{1,1},2);

        % initialize image stack
        image_stack_C1 = zeros(m,n,min_Nframes,'uint8');
        image_stack_C2 = zeros(m,n,min_Nframes,'uint8');
        %save images in variable
        background_C1 = 0;
        background_C2 = 0;
        for i = 1:min_Nframes
            imagei_C1=images{Nchannels*i - 1,1};
            imagei_C2=images{Nchannels*i,1};
            %convert to grey
            if ndims(imagei_C1) == 3
                imagei_C1=rgb2gray(imagei_C1);
            end
            image_stack_C1(:,:,i) = imagei_C1;
            backgroundi_C1_im = imagei_C1;
            backgroundi_C1_im(calc_init_user_roi_background{j} == 0) = 0;
            background_C1 = background_C1 + sum(sum(backgroundi_C1_im))/sum(sum(backgroundi_C1_im > 0));
            
            if ndims(imagei_C2) == 3
                imagei_C2=rgb2gray(imagei_C2);
            end
            image_stack_C2(:,:,i) = imagei_C2;
            backgroundi_C2_im = imagei_C2;
            backgroundi_C2_im(calc_init_user_roi_background{j} == 0) = 0;
            background_C2 = background_C2 + sum(sum(backgroundi_C2_im))/sum(sum(backgroundi_C2_im > 0));
        end
        background_C1 = background_C1 / min_Nframes;
        background_C2 = background_C2 / min_Nframes;
        
        % Apply background subtraction
        for i = 1:min_Nframes
            image_stack_C1(:,:,i) = image_stack_C1(:,:,i) - background_C1;
            image_stack_C2(:,:,i) = image_stack_C2(:,:,i) - background_C2;
        end
        
        % Calculate Z-axis profile
        image_stack_C1_center = image_stack_C1(:,9*n/20:11*n/20,:); 
        profile_C1 = squeeze(mean(image_stack_C1_center, [1 2]));
        image_stack_C2_center = image_stack_C2(:,9*n/20:11*n/20,:);
        profile_C2 = squeeze(mean(image_stack_C2_center, [1 2]));
        
        f = filesep; 
        sheet = calc_init_user_filenamestack{j};
        [~, curDir, ~] = fileparts(strip(calc_init_user_pathnamestack{j},'\'));
        newfile=[calc_init_user_pathnamestack{j},f,curDir,'_CalciumProfile.xlsx'];
        xlRange = 'A1';
        xlwrite(newfile,{'[sec]'},sheet,xlRange);
        xlRange = 'A2';
        times = (1:min_Nframes)/calc_init_user_framerate(j);
        xlwrite(newfile,times',sheet,xlRange);
        xlRange = 'B1';
        xlwrite(newfile,{'C1'},sheet,xlRange);
        xlRange = 'B2';
        xlwrite(newfile,profile_C1,sheet,xlRange);   
        xlRange = 'C1';
        xlwrite(newfile,{'C2'},sheet,xlRange);
        xlRange = 'C2';
        xlwrite(newfile,profile_C2,sheet,xlRange); 
        xlRange = 'D1';
        xlwrite(newfile,{'C1/C2'},sheet,xlRange);
        xlRange = 'D2';
        ratio = profile_C1./profile_C2;
        xlwrite(newfile,ratio,sheet,xlRange);   
        xlRange = 'E1';
        xlwrite(newfile,{'deltaF/F0'},sheet,xlRange);
        adjusted = (ratio - min(ratio)) / min(ratio);
        % fix outliers
        [~, outliers] = rmoutliers(adjusted,'movmean',31);
       
        
        for ipt = 1:size(outliers,1)
            if outliers(ipt)
                if ipt > 1 && ipt < size(outliers,1)
                    adjusted(ipt) = (adjusted(ipt - 1) + adjusted(ipt + 1)) / 2;
                elseif ipt == 1
                    adjusted(ipt) = adjusted(ipt + 1);
                else
                    adjusted(ipt) = adjusted(ipt - 1);
                end
            end
        end
        
        
        
        calc_init_user_adj_profile{j} = adjusted;
    end
    
    % allow user to prune for outliers
    for j = 1:calc_init_user_Nfiles
        f = filesep; 
        sheet = calc_init_user_filenamestack{j};
        newfile=[calc_init_user_pathnamestack{j},f,curDir,'_CalciumProfile.xlsx'];
        
%         figsize=[900,1600];
%         %get screen size
%         screensize = get(0,'ScreenSize');
%         %position fig on center of screen
%         xpos = ceil((screensize(3)-figsize(2))/2);
%         ypos = ceil((screensize(4)-figsize(1))/2);
%         hf=figure('position',[xpos, ypos, figsize(2), figsize(1)],...
%             'units','pixels',...
%             'renderer','OpenGL');
%         y_scale = max(calc_init_user_adj_profile{j}) / length(calc_init_user_adj_profile{j});
%         plot((1:length(calc_init_user_adj_profile{j})),calc_init_user_adj_profile{j} / y_scale)
%         hold on;
%         title(['Select outliers for image ', num2str(j), '. Press Enter to stop.']);
%         [x,y] = getpts;
%         close(hf)
%         
%         %find closest points
%         for i = 1:size(x,1)
%             d = zeros(size(calc_init_user_adj_profile{j},1),1);
%             for h = 1:size(calc_init_user_adj_profile{j},1)
% 
%                 % calculate dx, dy
%                 dx = x(i) - calc_init_user_adj_profile{j}(h);
%                 dy = (y(i) - calc_init_user_adj_profile{j}(h)) / y_scale;
% 
%                 % calculate distance
%                 d(h) = sqrt(dx^2+dy^2);
%             end
%             % find index of min(d)
%             [~,ipt] = min(d);
%             
%             % fix outlier
%             if ipt > 1 && ipt < size(outliers,1)
%                 calc_init_user_adj_profile{j}(ipt) = (calc_init_user_adj_profile{j}(ipt - 1) + calc_init_user_adj_profile{j}(ipt + 1)) / 2;
%             elseif ipt == 1
%                 calc_init_user_adj_profile{j}(ipt) = calc_init_user_adj_profile{j}(ipt + 1);
%             else
%                 calc_init_user_adj_profile{j}(ipt) = calc_init_user_adj_profile{j}(ipt - 1);
%             end
%         end
        
        %apply savistky-golay filter
        calc_init_user_adj_profile{j} = sgolayfilt(calc_init_user_adj_profile{j}, 2, 25);
        dataToWrite = calc_init_user_adj_profile{j};
        
        xlRange = ['E2:E',num2str(length(dataToWrite) + 1)];
        xlwrite(newfile,dataToWrite,sheet,xlRange); 
    end
    
    setappdata(0,'calc_init_user_adj_profile',calc_init_user_adj_profile);
    setappdata(0,'min_Nframes',min_Nframes);
    setappdata(0,'calc_init_user_framerate',calc_init_user_framerate);
catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'));
end

    %close window
    close(h_init(1).fig);
    
    set(Calc_main(1).button_results,'Enable','on');
end
