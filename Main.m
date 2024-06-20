function varargout = Main(varargin)

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
    % ...
    % Variables globales
    handles.serialPort = [];
    % ...
% ...
    % Estado inicial del botón de conexión y texto del puerto
    set(handles.btnConexion, 'BackgroundColor', get(0, 'defaultUicontrolBackgroundColor'));
    set(handles.txtPuerto, 'String', 'Desconectado');
% ...

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


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

% --- Executes on button press in btnKT.
function btnKT_Callback(hObject, eventdata, handles)

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

function edtX_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edtY_Callback(hObject, eventdata, handles)

function edtY_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edtZ_Callback(hObject, eventdata, handles)

function edtZ_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnCalcular.
function btnCalcular_Callback(hObject, eventdata, handles)

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

function sliderQ1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderQ2_Callback(hObject, eventdata, handles)

function sliderQ2_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function sliderQ3_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function sliderQ3_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function edtQ1_Callback(hObject, eventdata, handles)

function edtQ1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edtQ2_Callback(hObject, eventdata, handles)

function edtQ2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edtQ3_Callback(hObject, eventdata, handles)

function edtQ3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnConexion.
function btnConexion_Callback(hObject, eventdata, handles)

   if get(hObject, 'Value') == 1
        % Intentar conectar al puerto serial
        portName = 'COM1'; % Ajustar según sea necesario
        baudRate = 9600; % Ajustar según sea necesario
        try
            handles.serialPort = serial(portName, 'BaudRate', baudRate);
            fopen(handles.serialPort);
            set(handles.txtPuerto, 'String', ['Conectado a ' portName]);
            set(hObject, 'BackgroundColor', 'green');
            guidata(hObject, handles);
        catch
            set(handles.txtPuerto, 'String', 'Error al conectar');
            set(hObject, 'Value', 0); % Resetear el estado del botón
        end
    else
        % Desconectar el puerto serial
        if ~isempty(handles.serialPort) && strcmp(handles.serialPort.Status, 'open')
            fclose(handles.serialPort);
            delete(handles.serialPort);
            handles.serialPort = [];
            set(handles.txtPuerto, 'String', 'Desconectado');
            set(hObject, 'BackgroundColor', get(0, 'defaultUicontrolBackgroundColor'));
            guidata(hObject, handles);
        end
    end
% Hint: get(hObject,'Value') returns toggle state of btnConexion
