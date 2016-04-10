function varargout = electionYear(varargin)
% ELECTIONYEAR MATLAB code for electionYear.fig
%      ELECTIONYEAR, by itself, creates a new ELECTIONYEAR or raises the existing
%      singleton*.
%
%      H = ELECTIONYEAR returns the handle to a new ELECTIONYEAR or the handle to
%      the existing singleton*.
%
%      ELECTIONYEAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELECTIONYEAR.M with the given input arguments.
%
%      ELECTIONYEAR('Property','Value',...) creates a new ELECTIONYEAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before electionYear_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to electionYear_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help electionYear

% Last Modified by GUIDE v2.5 10-Apr-2016 15:51:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @electionYear_OpeningFcn, ...
                   'gui_OutputFcn',  @electionYear_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end
% --- Executes just before electionYear is made visible.
function electionYear_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to electionYear (see VARARGIN)

% Choose default command line output for electionYear
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes electionYear wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end
% --- Outputs from this function are returned to the command line.
function varargout = electionYear_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

function r = getGlobalRegion
global region;
r = region;
end

function regionColor = regionColorMap(regionLevel, year, type)

    regionColor = struct;
    regionNumber = 1;

    for i=1:length(regionLevel)
        level = char(regionLevel{i});
        fileName = ['data/' level year '.txt'];
        fid = fopen(fileName,'rt');
        
        fgetl(fid); %discard the blank line

        while ~feof(fid)
            election = fgetl(fid); %the line that says USA or State Name        
            data = textscan(election, '%s %f %f %f ', 'delimiter', ',') 
            name = char(data{1,1});
            my_data = cell2mat(data(2:4));
            regionColor(regionNumber).regionName=[level '_' lower(name)];   
            x = my_data(1);
            y = my_data(2);
            z = my_data(3);
            if type == 0 
                [r, g, b] = getPurpleColor(x, y, z);
            else
                [r, g, b] = getPrimaryColor(x, y, z);
            end
                
            regionColor(regionNumber).color = [r, g, b];
            regionNumber = regionNumber + 1
        end
        fclose(fid);
    end
end

function showElectionMap(year)
region = getGlobalRegion();
[mapBoundaries regionLevel] = getBoundaryDataFromFile(['data/' region '.txt']);
regionColor = regionColorMap(regionLevel, year, 0);
figure;
plotMap(regionColor, mapBoundaries, 'USA');

regionColor = regionColorMap(regionLevel, year, 1);
figure;
plotMap(regionColor, mapBoundaries, 'USA');
end

% --- Executes on button press in year_1960.
function year_1960_Callback(hObject, eventdata, handles)
showElectionMap('1960');
end

function year_1964_Callback(hObject, eventdata, handles)
showElectionMap('1964');
end

function year_1968_Callback(hObject, eventdata, handles)
showElectionMap('1968');
end

function year_1972_Callback(hObject, eventdata, handles)
showElectionMap('1972');
end

function year_1976_Callback(hObject, eventdata, handles)
showElectionMap('1976');
end

function year_1980_Callback(hObject, eventdata, handles)
showElectionMap('1980');
end

function year_1984_Callback(hObject, eventdata, handles)
showElectionMap('1984');
end

function year_1988_Callback(hObject, eventdata, handles)
showElectionMap('1988');
end

function year_1992_Callback(hObject, eventdata, handles)
showElectionMap('1992');
end

function year_1996_Callback(hObject, eventdata, handles)
showElectionMap('1996');
end

function year_2000_Callback(hObject, eventdata, handles)
showElectionMap('2000');
end

function year_2004_Callback(hObject, eventdata, handles)
showElectionMap('2004');
end

function year_2008_Callback(hObject, eventdata, handles)
showElectionMap('2008');
end

function year_2012_Callback(hObject, eventdata, handles)
showElectionMap('2012');
end
