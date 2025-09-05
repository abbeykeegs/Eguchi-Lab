function Calcium_Trace_ratio(all_files,number_files,Input_folder_name,Output_folder_name,Output_folder_name_debug,debug_mode)

% This function is designed to calculate correct ratio for calcium

% Initialise the following variable to store the names of the input files
input_filename_array=[];

% Check how many studies have already been analysed (24/07/2017)
% 1) list all folders under Output folder
input_filename_all=char(all_files.name);
input_filename_analysed=[];
output_folders=dir(Output_folder_name);
output_folders(1:2)=[];
for r=1:size(output_folders)
    output_folders_name=output_folders(r).name;
    % 2) list all files currently stored in this folder
    sub_output_folders=[Output_folder_name,'/',output_folders_name];
    % detect whether the sub output folder contains matlab variables
    if ~isempty(dir([sub_output_folders '/*.mat']));
        % construct the name of the input file to be searcged
        sub_input_file=[output_folders_name(19:end),'.xlsx'];
        sub_input_file_match=strfind(cellstr(input_filename_all),sub_input_file);
        % if the current file exists, then it will return 1 at the
        % corresponding index 
        sub_input_file_index=find(~cellfun(@isempty,sub_input_file_match));
        % remove the file from input
        input_filename_all(sub_input_file_index,:)=[];
    end
end
% Re-evaluate the number of input files to be analysed
number_files_to_be_analysed=size(input_filename_all,1);
input_file_to_be_analysed=input_filename_all;
    

for i=1:number_files_to_be_analysed
    % Step 1: Create an output folder for the current recording
    % Remove the extension in input_file
    input_file=strtrim(input_file_to_be_analysed(i,:));
    input_file(end-4:end)=[];
   % Define the name of output folder
    sub_output_folder=[Output_folder_name,'/Signal_properties_',input_file];

    % Create a folder to store debug figures
    if debug_mode==1
        sub_output_folder_debug=[Output_folder_name_debug,'/Signal_properties_',input_file];
        if exist(sub_output_folder_debug)==0
            mkdir(sub_output_folder_debug);
        end
    else
        if exist(sub_output_folder)==0
            mkdir(sub_output_folder);
        end
    end

    % Step 2: Calculate the corrected ratio
    fprintf(' ********************************************************\n');
    fprintf('        Extract ratio for study %s                               \n',input_file);
    fprintf(' ********************************************************\n');
    if debug_mode==1
        [time_points,Signal_Ca_ratio_processed]=Convert_raw_data_to_ratio_sub(Input_folder_name,input_file,sub_output_folder_debug);
    else
         [time_points,Signal_Ca_ratio_processed]=Convert_raw_data_to_ratio(Input_folder_name,input_file,sub_output_folder);
    end
    % save variables
    time_output=[sub_output_folder,'/',input_file,'_time.mat'];
    Ca_output=[sub_output_folder,'/',input_file,'_Signal_Ca_ratio_processed.mat'];
    save(time_output,'time_points');
    save(Ca_output,'Signal_Ca_ratio_processed');
    clearvars time_points Signal_Ca_ratio_processed;
    close all;
    %}
    %% Stack up an array for storing input filenames
    %input_filename_array=[input_filename_array;cellstr(input_file)];
    %save([Output_folder_name,'/Input_data_filenames.mat'],'input_filename_array');
end

%
% Write the input filenames out to csv file, use the first file name
input_filename_array=cellstr(char(all_files.name));
filenamew=[Output_folder_name,'/',all_files(1).name(1:end-5),'_cells_to_exclude.csv'];
T=cell2table(input_filename_array);
writetable(T,filenamew);

% Reminder user to enter the cell number to be excluded
msg=['Enter the cell number you would like to eliminate from the analysis to file ',filenamew, ...
            '. If all cells need to be included, then fill the second column with 0. Once finished, click ok to continue the analysis'];
uiwait(msgbox(msg,'Attention','modal'));

return