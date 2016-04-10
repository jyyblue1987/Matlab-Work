function varargout = electionMapper(varargin)
% ELECTIONMAPPER MATLAB code for electionMapper.fig
%      ELECTIONMAPPER, by itself, creates a new ELECTIONMAPPER or raises the existing
%      singleton*.
%
%      H = ELECTIONMAPPER returns the handle to a new ELECTIONMAPPER or the handle to
%      the existing singleton*.
%
%      ELECTIONMAPPER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELECTIONMAPPER.M with the given input arguments.
%
%      ELECTIONMAPPER('Property','Value',...) creates a new ELECTIONMAPPER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before electionMapper_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to electionMapper_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help electionMapper

% Last Modified by GUIDE v2.5 10-Apr-2016 12:53:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @electionMapper_OpeningFcn, ...
                   'gui_OutputFcn',  @electionMapper_OutputFcn, ...
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


% --- Executes just before electionMapper is made visible.
function electionMapper_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to electionMapper (see VARARGIN)

% Choose default command line output for electionMapper
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes electionMapper wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = electionMapper_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_usa.
function btn_usa_Callback(hObject, eventdata, handles)

mapBoundaries = getBoundaryDataFromFile('data/USA.txt')

regionColor = regionPureColor('data/USA2012.txt', 'USA')

figure;
plotMap(regionColor, mapBoundaries, 'USA')

% hObject    handle to btn_usa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_state.
function btn_state_Callback(hObject, eventdata, handles)
% hObject    handle to btn_state (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bnt_usacounty.
function bnt_usacounty_Callback(hObject, eventdata, handles)
% hObject    handle to bnt_usacounty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
