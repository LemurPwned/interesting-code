function varargout = TaylorGui(varargin)
% TAYLORGUI MATLAB code for TaylorGui.fig
%      TAYLORGUI, by itself, creates a new TAYLORGUI or raises the existing
%      singleton*.
%
%      H = TAYLORGUI returns the handle to a new TAYLORGUI or the handle to
%      the existing singleton*.
%
%      TAYLORGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TAYLORGUI.M with the given input arguments.
%
%      TAYLORGUI('Property','Value',...) creates a new TAYLORGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TaylorGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TaylorGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TaylorGui

% Last Modified by GUIDE v2.5 10-Nov-2016 20:17:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TaylorGui_OpeningFcn, ...
                   'gui_OutputFcn',  @TaylorGui_OutputFcn, ...
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


% --- Executes just before TaylorGui is made visible.
function TaylorGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TaylorGui (see VARARGIN)

% Choose default command line output for TaylorGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TaylorGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TaylorGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function funct_Callback(hObject, eventdata, handles)
% hObject    handle to funct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of funct as text
%        str2double(get(hObject,'String')) returns contents of funct as a double


% --- Executes during object creation, after setting all properties.
function funct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to funct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min_Callback(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min as text
%        str2double(get(hObject,'String')) returns contents of min as a double


% --- Executes during object creation, after setting all properties.
function min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_Callback(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max as text
%        str2double(get(hObject,'String')) returns contents of max as a double


% --- Executes during object creation, after setting all properties.
function max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    cla
    func = get(handles.funct, 'String');
    func = vectorize(func);
    func = inline(func, 'x');
    
    x0 = str2double(get(handles.aprox_point, 'String'));
    n_it = str2double(get(handles.no_ap, 'String'));
    max_x = str2double(get(handles.max, 'String'));
    min_x = str2double(get(handles.min, 'String'));
    
    xp = min_x:0.2:max_x;
    
    %fetch set of aproximations
    aprox = Taylor(func, x0, n_it);
   
    axis tight
    hold on
    colors = ['g', 'y', 'm', 'b', 'k'];
    plot(x0, func(x0), 'r*')
    plot(xp, func(xp), 'r')
    syms f(x)
    for i=1:n_it
        f(x) = aprox(i);
        yp = f(xp);
        w = waitforbuttonpress;
        if w == 0
            plot(xp, yp, colors(mod(i,5)+1));
        else
            disp('no click')
        end
    end
    hold off



function aprox_point_Callback(hObject, eventdata, handles)
% hObject    handle to aprox_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aprox_point as text
%        str2double(get(hObject,'String')) returns contents of aprox_point as a double


% --- Executes during object creation, after setting all properties.
function aprox_point_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aprox_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function no_ap_Callback(hObject, eventdata, handles)
% hObject    handle to no_ap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of no_ap as text
%        str2double(get(hObject,'String')) returns contents of no_ap as a double


% --- Executes during object creation, after setting all properties.
function no_ap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to no_ap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
