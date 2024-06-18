function varargout = CInversa(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name', mfilename, ...
                   'gui_Singleton', gui_Singleton, ...
                   'gui_OpeningFcn', @CInversa_OpeningFcn, ...
                   'gui_OutputFcn', @CInversa_OutputFcn, ...
                   'gui_LayoutFcn', [], ...
                   'gui_Callback', []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function CInversa_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = CInversa_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function editXI_Callback(hObject, eventdata, handles)
handles.x = str2double(get(hObject, 'String'));
guidata(hObject, handles);

function editXI_CreateFcn(hObject, eventdata, handles)
handles.y = str2double(get(hObject, 'String'));
guidata(hObject, handles);

function editYI_Callback(hObject, eventdata, handles)
handles.y = str2double(get(hObject, 'String'));
guidata(hObject, handles);

function editYI_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editZI_Callback(hObject, eventdata, handles)
handles.z = str2double(get(hObject, 'String'));
guidata(hObject, handles);

function editZI_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function textQ1_Callback(hObject, eventdata, handles)
handles.q1 = str2double(get(hObject, 'String'));
guidata(hObject, handles);

function textQ1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function textQ2_Callback(hObject, eventdata, handles)
handles.q2 = str2double(get(hObject, 'String'));
guidata(hObject, handles);

function textQ2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function textQ3_Callback(hObject, eventdata, handles)
handles.q3 = str2double(get(hObject, 'String'));
guidata(hObject, handles);

function textQ3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function sliderQ1_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderQ1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderQ2_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderQ2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderQ3_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQ3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderQ3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQ3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function editQ1_Callback(hObject, eventdata, handles)
% hObject    handle to editQ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editQ1 as text
%        str2double(get(hObject,'String')) returns contents of editQ1 as a double


% --- Executes during object creation, after setting all properties.
function editQ1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editQ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editQ2_Callback(hObject, eventdata, handles)
% hObject    handle to editQ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editQ2 as text
%        str2double(get(hObject,'String')) returns contents of editQ2 as a double


% --- Executes during object creation, after setting all properties.
function editQ2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editQ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editQ3_Callback(hObject, eventdata, handles)
% hObject    handle to editQ3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editQ3 as text
%        str2double(get(hObject,'String')) returns contents of editQ3 as a double


% --- Executes during object creation, after setting all properties.
function editQ3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editQ3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTheta1_Callback(hObject, eventdata, handles)
% hObject    handle to editTheta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTheta1 as text
%        str2double(get(hObject,'String')) returns contents of editTheta1 as a double


% --- Executes during object creation, after setting all properties.
function editTheta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTheta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editD1_Callback(hObject, eventdata, handles)
% hObject    handle to editD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editD1 as text
%        str2double(get(hObject,'String')) returns contents of editD1 as a double


% --- Executes during object creation, after setting all properties.
function editD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editA1_Callback(hObject, eventdata, handles)
% hObject    handle to editA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editA1 as text
%        str2double(get(hObject,'String')) returns contents of editA1 as a double


% --- Executes during object creation, after setting all properties.
function editA1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAlpha1_Callback(hObject, eventdata, handles)
% hObject    handle to editAlpha1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAlpha1 as text
%        str2double(get(hObject,'String')) returns contents of editAlpha1 as a double


% --- Executes during object creation, after setting all properties.
function editAlpha1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAlpha1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTheta2_Callback(hObject, eventdata, handles)
% hObject    handle to editTheta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTheta2 as text
%        str2double(get(hObject,'String')) returns contents of editTheta2 as a double


% --- Executes during object creation, after setting all properties.
function editTheta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTheta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editD2_Callback(hObject, eventdata, handles)
% hObject    handle to editD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editD2 as text
%        str2double(get(hObject,'String')) returns contents of editD2 as a double


% --- Executes during object creation, after setting all properties.
function editD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editA2_Callback(hObject, eventdata, handles)
% hObject    handle to editA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editA2 as text
%        str2double(get(hObject,'String')) returns contents of editA2 as a double


% --- Executes during object creation, after setting all properties.
function editA2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAlpha2_Callback(hObject, eventdata, handles)
% hObject    handle to editAlpha2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAlpha2 as text
%        str2double(get(hObject,'String')) returns contents of editAlpha2 as a double


% --- Executes during object creation, after setting all properties.
function editAlpha2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAlpha2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTheta3_Callback(hObject, eventdata, handles)
% hObject    handle to editTheta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTheta3 as text
%        str2double(get(hObject,'String')) returns contents of editTheta3 as a double


% --- Executes during object creation, after setting all properties.
function editTheta3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTheta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editD3_Callback(hObject, eventdata, handles)
% hObject    handle to editD3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editD3 as text
%        str2double(get(hObject,'String')) returns contents of editD3 as a double


% --- Executes during object creation, after setting all properties.
function editD3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editD3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editA3_Callback(hObject, eventdata, handles)
% hObject    handle to editA3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editA3 as text
%        str2double(get(hObject,'String')) returns contents of editA3 as a double


% --- Executes during object creation, after setting all properties.
function editA3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editA3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAlpha3_Callback(hObject, eventdata, handles)
% hObject    handle to editAlpha3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAlpha3 as text
%        str2double(get(hObject,'String')) returns contents of editAlpha3 as a double


% --- Executes during object creation, after setting all properties.
function editAlpha3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAlpha3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in btnCalcular.
function btnCalcular_Callback(hObject, eventdata, handles)
% hObject    handle to btnCalcular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnHome.
function btnHome_Callback(hObject, eventdata, handles)
% hObject    handle to btnHome (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function btnSimular_Callback(hObject, eventdata, handles)
clc
L(1) = Link([0 20 0 0 0 0]);
L(2) = Link([90 40 0 pi/2 0 0]);
L(3) = Link([0 40 0 0 0 0]);
L(4) = Link([0 10 0 0 0 0]);
RB = SerialLink(L);

% Variables iniciales
qo = [0 0 0 0];

% Variables finales
qf = [pi/2 0 0 0];

% Variable tiempo
tiempo = 0:0.5:30;

% Creacion de trayectoria
[q, dq, ddq] = jtraj(qo, qf, tiempo);

% Set current axes to axes1
axes(handles.axes1);

% Plot del robot
RB.plot(q, 'workspace', [-100 100 -100 100 0 200]);


% Definir las longitudes
L1 = 129;
L2 = 14;
L3 = 120;
L4 = 122;
l = [L1; L2; L3; L4];

% Crear enlaces con parámetros DH
L(1) = Link([0 L1 L2 pi/2 0]);
L(2) = Link([0 0 L3 0 0]);
L(3) = Link([0 0 L4 0 0]);
RB = SerialLink(L, 'name', 'MiRobot');

% Definir el espacio de trabajo
workspace = [-500 500 -500 500 0 1000];
