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

% --- Outputs from this function are returned to the command line.
function varargout = electionYear_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function r = getGlobalRegion
global region;
r = region;

function showElectionMap(year)
region = getGlobalRegion();
mapBoundaries = getBoundaryDataFromFile(['data/' region '.txt']);
regionColor = regionPureColor(['data/' region year '.txt'], region);
figure;
plotMap(regionColor, mapBoundaries, 'USA');

% --- Executes on button press in year_1960.
function year_1960_Callback(hObject, eventdata, handles);
showElectionMap('1960')


function year_1964_Callback(hObject, eventdata, handles);
showElectionMap('1964')

function year_1968_Callback(hObject, eventdata, handles);
showElectionMap('1968')


function year_1972_Callback(hObject, eventdata, handles);
showElectionMap('1972')

function year_1976_Callback(hObject, eventdata, handles);
showElectionMap('1976')

function year_1980_Callback(hObject, eventdata, handles);
showElectionMap('1980')

function year_1984_Callback(hObject, eventdata, handles);
showElectionMap('1984')

function year_1988_Callback(hObject, eventdata, handles);
showElectionMap('1988')

function year_1992_Callback(hObject, eventdata, handles);
showElectionMap('1992')

function year_1996_Callback(hObject, eventdata, handles);
showElectionMap('1996')

function year_2000_Callback(hObject, eventdata, handles);
showElectionMap('2000')

function year_2004_Callback(hObject, eventdata, handles);
showElectionMap('2004')

function year_2008_Callback(hObject, eventdata, handles);
showElectionMap('2008')

function year_2012_Callback(hObject, eventdata, handles);
showElectionMap('2012')
