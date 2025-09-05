function CalciumAnalysisMain
%main function for the main window of calcium analysis analysis
%userTiming.mainTiming{1} = tic;
%setappdata(0,'userTiming',userTiming)

%clear all
%clc
clear all;
close all;

%supress all warning messages 
warning('off','all');
addpath('External');
addpath('External/bfmatlab');
addpath('External/20130227_xlwrite');
addpath('External/statusbar');

javaaddpath('External/20130227_xlwrite/poi_library/poi-3.8-20120326.jar');
javaaddpath('External/20130227_xlwrite/poi_library/poi-ooxml-3.8-20120326.jar');
javaaddpath('External/20130227_xlwrite/poi_library/poi-ooxml-schemas-3.8-20120326.jar');
javaaddpath('External/20130227_xlwrite/poi_library/xmlbeans-2.3.0.jar');
javaaddpath('External/20130227_xlwrite/poi_library/dom4j-1.6.1.jar');
javaaddpath('External/20130227_xlwrite/poi_library/stax-api-1.0.1.jar');

%figure size
figuresize=[120,225];
%get screen size
screensize = get(0,'ScreenSize');
%position figure on center of screen
xpos = ceil((screensize(3)-figuresize(2))/2);
ypos = ceil((screensize(4)-figuresize(1))/2);

%create figure
Calc_main(1).fig=figure(...
    'position',[xpos, ypos, figuresize(2), figuresize(1)],...
    'units','pixels',...
    'renderer','OpenGL',...
    'MenuBar','none',...
    'PaperPositionMode','auto',...
    'Name','Calc Main',...
    'NumberTitle','off',...
    'Resize','off',...
    'Color',[.2,.2,.2]);

%create buttons:
%button size
buttonsize=[30,200];
%vertical space between buttons: 2 buttons along figuresize -> 3 spaces
verticalspace=(figuresize(1)-2*buttonsize(1))/3;
%button 1 - Load
Calc_main(1).button_load = uicontrol('Parent',Calc_main(1).fig,'style','pushbutton','position',[figuresize(2)/2-buttonsize(2)/2,2*verticalspace+1*buttonsize(1),buttonsize(2),buttonsize(1)],'string','Load Videos');
%button 2 - Results
Calc_main(1).button_results = uicontrol('Parent',Calc_main(1).fig,'style','pushbutton','position',[figuresize(2)/2-buttonsize(2)/2,1*verticalspace+0*buttonsize(1),buttonsize(2),buttonsize(1)],'string','Results');

%assign callbacks to buttons
%button 1
set(Calc_main(1).button_load,'callback',{@main_push_load,Calc_main})
%button 2
set(Calc_main(1).button_results,'callback',{@main_push_results,Calc_main})


function main_push_load(hObject, eventdata, Calc_main)
%launch the initialization window
movegui(Calc_main(1).fig,'east');
set(Calc_main(1).button_results,'Enable','off');
CalciumAnalysisLoad(Calc_main);
movegui(Calc_main(1).fig,'center')
set(Calc_main(1).button_load,'ForegroundColor',[0 .5 0]);

function main_push_results(hObject, eventdata, Calc_main)
%launch the results window
movegui(Calc_main(1).fig,'east');
CalciumAnalysisResults(Calc_main);
movegui(Calc_main(1).fig,'center')
set(Calc_main(1).button_results,'ForegroundColor',[0 .5 0]);

