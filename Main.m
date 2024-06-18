function varargout = Main(varargin)
% MAIN MATLAB code for Main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main

% Last Modified by GUIDE v2.5 18-Jun-2024 08:13:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
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


% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main (see VARARGIN)

% Choose default command line output for Main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnKT.
function btnKT_Callback(hObject, eventdata, handles)
% hObject    handle to btnKT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Obtener datos de los edits y convertir a radianes
% Obtener datos de los edits y convertir a radianes
q1 = str2double(get(handles.edtQ1, 'String'));
q2 = str2double(get(handles.edtQ2, 'String'));
q3 = str2double(get(handles.edtQ3, 'String'));

q1 = deg2rad(q1);
q2 = deg2rad(q2);
q3 = deg2rad(q3);

% Longitudes de los eslabones
L1 = 129;
L2 = 14;
L3 = 120;
L4 = 122;

% Configuración de las articulaciones
q = [q1 q2 q3];

% Crear enlaces con parámetros DH
L(1) = Link([0 L1 L2 pi/2 0]);
L(2) = Link([0 0 L3 0 0]);
L(3) = Link([0 0 L4 0 0]);
RB = SerialLink(L, 'name', 'MiRobot');

% Definir el espacio de trabajo
workspace = [-500 500 -500 500 0 1000];

% Obtener el handle del axes1 y configurarlo para la gráfica
axes(handles.axes1);
cla; % Limpiar el axes antes de graficar
RB.plot(q, 'workspace', workspace, 'delay', 0);

% Cinemática Directa
syms theta d a alpha_ real
A = [cos(theta), -sin(theta)*cos(alpha_), sin(theta)*sin(alpha_), a*cos(theta);
     sin(theta), cos(theta)*cos(alpha_), -cos(theta)*sin(alpha_), a*sin(theta);
     0, sin(alpha_), cos(alpha_), d;
     0, 0, 0, 1];

% Definir los parámetros DH para cada articulación
A01 = subs(A, {theta, d, a, alpha_}, {q1, L1, L2, pi/2});
A12 = subs(A, {theta, d, a, alpha_}, {q2, 0, L3, 0});
A23 = subs(A, {theta, d, a, alpha_}, {q3, 0, L4, 0});

% Matriz de transformación total
T = simplify(A01 * A12 * A23);

% Extraer las posiciones
Kpx = double(T(1, 4));
Kpy = double(T(2, 4));
Kpz = double(T(3, 4));
P = [Kpx; Kpy; Kpz];

% Mostrar los resultados en la consola
disp('Posición calculada (Cinemática Directa):');
disp(['x: ', num2str(Kpx)]);
disp(['y: ', num2str(Kpy)]);
disp(['z: ', num2str(Kpz)]);

% Mostrar la matriz T en la uitableMatrizTH
T_data = double(T); % Convertir T a una matriz numérica
set(handles.uitableMatrizTH, 'Data', T_data); % Actualizar los datos en la uitable

% --- Executes on button press in btnHome.
function btnHome_Callback(hObject, eventdata, handles)
% hObject    handle to btnHome (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edtX_Callback(hObject, eventdata, handles)
% hObject    handle to edtX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtX as text
%        str2double(get(hObject,'String')) returns contents of edtX as a double


% --- Executes during object creation, after setting all properties.
function edtX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtY_Callback(hObject, eventdata, handles)
% hObject    handle to edtY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtY as text
%        str2double(get(hObject,'String')) returns contents of edtY as a double


% --- Executes during object creation, after setting all properties.
function edtY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtZ_Callback(hObject, eventdata, handles)
% hObject    handle to edtZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtZ as text
%        str2double(get(hObject,'String')) returns contents of edtZ as a double


% --- Executes during object creation, after setting all properties.
function edtZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtZ (see GCBO)
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


% --- Executes on slider movement.
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



function edtQ1_Callback(hObject, eventdata, handles)
% hObject    handle to edtQ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtQ1 as text
%        str2double(get(hObject,'String')) returns contents of edtQ1 as a double


% --- Executes during object creation, after setting all properties.
function edtQ1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtQ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtQ2_Callback(hObject, eventdata, handles)
% hObject    handle to edtQ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtQ2 as text
%        str2double(get(hObject,'String')) returns contents of edtQ2 as a double


% --- Executes during object creation, after setting all properties.
function edtQ2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtQ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtQ3_Callback(hObject, eventdata, handles)
% hObject    handle to edtQ3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtQ3 as text
%        str2double(get(hObject,'String')) returns contents of edtQ3 as a double


% --- Executes during object creation, after setting all properties.
function edtQ3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtQ3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

