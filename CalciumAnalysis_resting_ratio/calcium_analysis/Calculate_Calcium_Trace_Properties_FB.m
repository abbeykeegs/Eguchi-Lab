function Calculate_Calcium_Trace_Properties_FB(Input_folder_name,Output_folder_name,number_files)

% This function is written to caluclate properties of the calcium traces

% Define the folder name
Input_folder_name='Input_data';
% List all files in the input data folder
all_files=dir(Input_folder_name);
all_files(1:2)=[];
number_files=size(all_files,1);
input_file=all_files(end).name;
input_file(end-3:end)=[];

% Define the output folder
Output_folder_name='Output';

%{
% Load the csv file that contains the cell numbers to be excluded from the
% analysis
filenamer=[Output_folder_name,'/',all_files(1).name(1:end-5),'_cells_to_exclude.csv'];
[input_file_name_all]=importdata(filenamer,',');
cells_to_exclude_all=input_file_name_all.data;
%}
cells_to_exclude_all=[];

for i=1:number_files
    % Step 1: Create an output folder for the current recording
    % Remove the extension in input_file
    input_file=all_files(i).name;
    input_file(end-3:end)=[];
    if contains(input_file, '.')
        continue;
    end
    sub_output_folder=[Output_folder_name,'/Signal_properties_',input_file];
    if ~exist(sub_output_folder)
        mkdir(sub_output_folder);
    end  

%%% Foster Birnbaum's edits to make compatible with new files
%     % Step 2: Read the data from csv file
%     furo_data=readtable([Input_folder_name,'/',input_file,'.csv']);
%     time_input=furo_data.Frame*dt;
%     Ca_input=furo_data(:,end-1);
    
     % Step 2: Read the data from txt file
     furo_data=readtable([Input_folder_name,'/',input_file,'.txt']);
     time_input = furo_data.x_sec_;
     Ca_input = furo_data(:,2);
%%% End Foster Birnbaum's edits
    
    %{
    % Extract cells to exclude for the current input file
    cells_to_exclude=cells_to_exclude_all(i,:);
    cells_to_exclude_index=find(isnan(cells_to_exclude_all(i,:)));
    cells_to_exclude(cells_to_exclude_index)=[];
    %}
    cells_to_exclude=[];
    % Step 2: Extract key properties of the trace
    fprintf(' ********************************************************\n');
    fprintf('        Extract Ca properties for study %s               \n',input_file);
    fprintf(' ********************************************************\n');
    Extract_trace_properties(time_input,Ca_input,input_file,sub_output_folder,cells_to_exclude);
    close all;
end