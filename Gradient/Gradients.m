function varargout = Gradients(varargin)
% GRADIENTS MATLAB code for Gradients.fig
%      GRADIENTS, by itself, creates a new GRADIENTS or raises the existing
%      singleton*.
%
%      H = GRADIENTS returns the handle to a new GRADIENTS or the handle to
%      the existing singleton*.
%
%      GRADIENTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRADIENTS.M with the given input arguments.
%
%      GRADIENTS('Property','Value',...) creates a new GRADIENTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gradients_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gradients_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gradients

% Last Modified by GUIDE v2.5 05-Nov-2016 22:11:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gradients_OpeningFcn, ...
                   'gui_OutputFcn',  @Gradients_OutputFcn, ...
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


% --- Executes just before Gradients is made visible.
function Gradients_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gradients (see VARARGIN)

% Choose default command line output for Gradients
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gradients wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gradients_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu.
function popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu


% --- Executes during object creation, after setting all properties.
function popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start_button.
function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%clear all

index_selected = get(handles.popupmenu,'String');
pick = index_selected{get(handles.popupmenu, 'Value')};
axes(handles.axes1)
if ~strcmp(pick, 'Conjugate gradient')
    cla
    func = get(handles.function_in, 'String');
    display(func)
    
    [xm, ym] = meshgrid(-5:0.2:5);

    func = vectorize(func);
    func = inline(func, 'x', 'y');

    zm = func(xm, ym);
    contourf(xm, ym, zm);
    hold on
    [x_in, y_in] = ginput(1);

    display(x_in)
    display(index_selected)
end

pick = index_selected{get(handles.popupmenu, 'Value')};
switch pick
    case 'Basic gradient'
       
       display('entered')
       [x_trace, y_trace] = Basic_grad(func, x_in, y_in); 
       %plot trace
       for i = 1:size(x_trace,2)
            plot(x_trace(i), y_trace(i), 'r.')
            pause(0.05);
       end
    case 'Basic gradient 2.0'
        [x_trace, y_trace] = conjugate_grad(func, x_in, y_in); 
        %plot trace
        for i = 1:size(x_trace,2)
            plot(x_trace(i), y_trace(i), 'r.')
            pause(0.05);
        end
    case 'Conjugate gradient'
        
        cla
        a1 = str2double(get(handles.m1, 'String'));
        a2 = str2double(get(handles.m2, 'String'));
        a3 = str2double(get(handles.m3, 'String'));
        a4 = str2double(get(handles.m4, 'String'));
        b1 = str2double(get(handles.b1, 'String'));
        b2 = str2double(get(handles.b2, 'String'));
        A = [a1, a2 ; a3, a4];
        b = [b1 ; b2];
        %plot
        
        x1 = linspace(-4,6,100);
        x2 = linspace(-6,4,100);
        [x1m, x2m] = meshgrid(x1, x2);
        zm = zeros(100);
        for i = 1:100
            for j = 1:100
                x = [x1m(i,j); x2m(i,j)];
                f = x'*A*x - b'*x;
                zm(i,j) = f;
            end
        end
        contourf(x1m, x2m, zm)
        [x_in, y_in] = ginput(1);
        
        %endofplot
        hold on
        [x_old] = Quadratic_surf(A, b, x_in, y_in); 
        %plot trace
        for i = 1:size(x_old,2)
            plot(x_old(1,i), x_old(2,i), 'r.-')
            pause(0.05);
        end
hold off       
end



function function_in_Callback(hObject, eventdata, handles)
% hObject    handle to function_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of function_in as text
%        str2double(get(hObject,'String')) returns contents of function_in as a double


% --- Executes during object creation, after setting all properties.
function function_in_CreateFcn(hObject, eventdata, handles)
% hObject    handle to function_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pick.
function pick_Callback(hObject, eventdata, handles)
% hObject    handle to pick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function m1_Callback(hObject, eventdata, handles)
% hObject    handle to m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m1 as text
%        str2double(get(hObject,'String')) returns contents of m1 as a double


% --- Executes during object creation, after setting all properties.
function m1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m2_Callback(hObject, eventdata, handles)
% hObject    handle to m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m2 as text
%        str2double(get(hObject,'String')) returns contents of m2 as a double


% --- Executes during object creation, after setting all properties.
function m2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m3_Callback(hObject, eventdata, handles)
% hObject    handle to m3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m3 as text
%        str2double(get(hObject,'String')) returns contents of m3 as a double


% --- Executes during object creation, after setting all properties.
function m3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m4_Callback(hObject, eventdata, handles)
% hObject    handle to m4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m4 as text
%        str2double(get(hObject,'String')) returns contents of m4 as a double


% --- Executes during object creation, after setting all properties.
function m4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b1_Callback(hObject, eventdata, handles)
% hObject    handle to b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b1 as text
%        str2double(get(hObject,'String')) returns contents of b1 as a double


% --- Executes during object creation, after setting all properties.
function b1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b2_Callback(hObject, eventdata, handles)
% hObject    handle to b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b2 as text
%        str2double(get(hObject,'String')) returns contents of b2 as a double


% --- Executes during object creation, after setting all properties.
function b2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
