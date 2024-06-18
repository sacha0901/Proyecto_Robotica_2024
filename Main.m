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
% Definir las longitudes de los eslabones
    handles.L1 = 129;
    handles.L2 = 14;
    handles.L3 = 120;
    handles.L4 = 122;
    handles.l = [handles.L1; handles.L2; handles.L3; handles.L4];

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

% Obtener datos de los edits y convertir a radianes
q1 = str2double(get(handles.edtQ1, 'String'));
q2 = str2double(get(handles.edtQ2, 'String'));
q3 = str2double(get(handles.edtQ3, 'String'));

q1 = deg2rad(q1);
q2 = deg2rad(q2);
q3 = deg2rad(q3);

% Configuración de las articulaciones
q = [q1 q2 q3];

% Crear enlaces con parámetros DH
L(1) = Link([0 handles.L1 handles.L2 pi/2 0]);
L(2) = Link([0 0 handles.L3 0 0]);
L(3) = Link([0 0 handles.L4 0 0]);
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
theta1 = q1; d1 = handles.L1; a1 = handles.L2; alpha1 = pi/2;
theta2 = q2; d2 = 0; a2 = handles.L3; alpha2 = 0;
theta3 = q3; d3 = 0; a3 = handles.L4; alpha3 = 0;

% Matrices de transformación homogénea
A01 = subs(A, {theta, d, a, alpha_}, {theta1, d1, a1, alpha1});
A12 = subs(A, {theta, d, a, alpha_}, {theta2, d2, a2, alpha2});
A23 = subs(A, {theta, d, a, alpha_}, {theta3, d3, a3, alpha3});

% Matriz de transformación homogénea completa
T = double(A01 * A12 * A23);

% Convertir la matriz T a una matriz de celdas para usar HTML
T_data = cell(size(T));
for i = 1:size(T,1)
    for j = 1:size(T,2)
        if (i == 1 && j == 4) || (i == 2 && j == 4) || (i == 3 && j == 4)
            T_data{i, j} = ['<html><font color="blue">' num2str(T(i, j)) '</font></html>'];
        elseif (i >= 1 && i <= 3) && (j >= 1 && j <= 3)
            T_data{i, j} = ['<html><font color="orange">' num2str(T(i, j)) '</font></html>'];
        else
            T_data{i, j} = num2str(T(i, j));
        end
    end
end

% Mostrar la matriz T en la uitableMatrizTH
set(handles.uitableMatrizTH, 'Data', T_data);

% Convertir theta1, theta2, theta3 a grados para la tabla
theta1_deg = rad2deg(theta1);
theta2_deg = rad2deg(theta2);
theta3_deg = rad2deg(theta3);

% Mostrar los parámetros DH en la uitableParametrosDH
parametros_DH_data = {
    theta1_deg, d1, a1, alpha1;
    theta2_deg, d2, a2, alpha2;
    theta3_deg, d3, a3, alpha3
};
set(handles.uitableParametrosDH, 'Data', parametros_DH_data);

% Mostrar los resultados en la consola
disp('Posición calculada (Cinemática Directa):');
disp(['x: ', num2str(T(1,4))]);
disp(['y: ', num2str(T(2,4))]);
disp(['z: ', num2str(T(3,4))]);

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

% Obtener los valores de posición desde los edits
    x = str2double(get(handles.edtX, 'String'));
    y = str2double(get(handles.edtY, 'String'));
    z = str2double(get(handles.edtZ, 'String'));
    p = [x; y; z];

    % Cinemática Inversa
    [q1, q2, q3] = Inversa_q1_q2_q3(p, handles.l);

    % Configuración de las articulaciones
    q = [q1 q2 q3];

    % Crear enlaces con parámetros DH
    L(1) = Link([0 handles.L1 handles.L2 pi/2 0]);
    L(2) = Link([0 0 handles.L3 0 0]);
    L(3) = Link([0 0 handles.L4 0 0]);
    RB = SerialLink(L, 'name', 'MiRobot');

    % Definir el espacio de trabajo
    workspace = [-500 500 -500 500 0 1000];

    % Obtener el handle del axes1 y configurarlo para la gráfica
    axes(handles.axes1);
    cla; % Limpiar el axes antes de graficar
    RB.plot(q, 'workspace', workspace, 'delay', 0);

    % Mostrar los ángulos calculados en la consola
    disp('Ángulos calculados (Cinemática Inversa):');
    disp(['q1: ', num2str(rad2deg(q1)), ' grados']);
    disp(['q2: ', num2str(rad2deg(q2)), ' grados']);
    disp(['q3: ', num2str(rad2deg(q3)), ' grados']);

    % Mostrar los ángulos en la uitableParametrosDH
    parametros_DH_data = {
        rad2deg(q1), handles.L1, handles.L2, pi/2;
        rad2deg(q2), 0, handles.L3, 0;
        rad2deg(q3), 0, handles.L4, 0
    };
    set(handles.uitableParametrosDH, 'Data', parametros_DH_data);

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
