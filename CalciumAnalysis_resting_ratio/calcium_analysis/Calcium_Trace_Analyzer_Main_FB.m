function Calcium_Trace_Analyzer_Main_FB

% This function is designed to analyse Calcium signal
% This function consists of two main parts:
% 1) read in the raw signals and calculate the correct calcium ratio
% 2) based on the corrected ratio, extract the following key properties:
%     - baseline ratio
%     - amplitude
%     - peak-to-peak interval
%     - time to peak
%     - half decay time
%     - tau
% Author: Vicky Wang
%     - Modification on 06/02/2021: adapted calcium code to analyze furo
%     red signals. 

clc;
clear all;

%%%%%%%%%%%%%%% Set up input and output folders %%%%%%%%%%%%%%%%

% Define the folder name
Input_folder_name='Input_data';
% List all files in the input data folder
all_files=dir(Input_folder_name);
all_files(1:2)=[];
number_files=size(all_files,1);

% Create an output folder
Output_folder_name='Output';
if exist(Output_folder_name)==0
    mkdir(Output_folder_name);
end

% Create an output folder for debugging purpose
Output_folder_name_debug='Output_debug';
if exist(Output_folder_name_debug)==0
    mkdir(Output_folder_name_debug);
end

% Debug toggle
debug_mode=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ask the user which step they want to excute
%steps_to_excute=input('Enter 1 if you want to excute both steps, or 2 if you want to extract properties only\n');

%%%%%%%%%%%%%%%%%% 2) Extract key properties  %%%%%%%%%%%%%%%%
fprintf('===================================================================\n');
fprintf('    Execute Step 2 to extract properties for Calcium trace         \n');
fprintf('===================================================================\n');
Calculate_Calcium_Trace_Properties_FB(Input_folder_name,Output_folder_name,number_files);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


return