function Export_Ratio

% This function is designed to export the calculated ratio to text file for
% plotting in grahpad
% Author: Vicky Wang

% Ask the user to select the .mat file to export
[FileName_time,PathName] = uigetfile('*.mat','Select the time file in .mat format');
[FileName_Ca,PathName] = uigetfile('*.mat','Select the ratio file in .mat format');

% Read in the mat file
file_to_read_time=[PathName,FileName_time];
file_to_read_Ca=[PathName,FileName_Ca];
load(file_to_read_time);
load(file_to_read_Ca);

% Write the time and ratio to text file
filenamew=[PathName,'\Signal_Ca_ratio.txt'];
dlmwrite(filenamew,[time_points,Signal_Ca_ratio_processed]);

return