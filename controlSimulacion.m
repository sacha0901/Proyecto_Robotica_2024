%control de simulacion.m
clc; clear;
t0 = 0;  
tf = 3;
h = 0.01;

% Condiciones iniciales
q0 = [0, .1, 0 ];

% Resolvemos la ecuación diferencial
[t, q] = ode45(@fcn_control_cinematico, [t0:h:tf], q0);
SALIDA = q * 180 / pi;
TIEMPO = t;

% Separar los elementos de la matriz "q" obtenida
q1 = q(:, 1) * 180 / pi;
q2 = q(:, 2) * 180 / pi;
q3 = q(:, 3) * 180 / pi;


hold on
axis([-100 250 -100 250 0 400])
xlabel('x')
ylabel('Y')
zlabel('z')

% Graficar la trayectoria obtenida (efector final)
% Medidas de Shoubi_V3 en mm
L1 = 129; % mm
L2 = 14;  % mm
L3 = 120; % mm
L4 = 122; % mm

% Cinemática directa de todos los eslabones del robot
x3 =  cos(q(:, 1)) .* ( L2 + L4*cos(q(:, 2) + q(:, 3)) + L3 * cos(q(:, 2)));
y3 =  sin(q(:, 1)) .* ( L2 + L4*cos(q(:, 2) + q(:, 3)) + L3 * cos(q(:, 2)));
z3 = L1 + L4 * cos(q(:, 3)) .* sin(q(:, 2)) + L3 * sin(q(:, 2)) + L4 * cos(q(:, 2)) .* sin(q(:, 3));
%plot3(x3, y3, z3)

x2 = cos(q(:, 1)) .* ( L2 + L3 * cos(q(:, 2)));
y2 = sin(q(:, 1)) .* ( L2 + L3 * cos(q(:, 2))); 
z2 = L1 + L3 * sin(q(:, 2));
%plot3(x2, y2, z2)

x1 = 0; %* cos(q(:, 1));
y1 = 0; %* sin(q(:, 1));
z1 = L1;
%plot3(x1, y1, z1)

x0 = 0;
y0 = 0;
z0 = 0;

% Gráfico del robot
i = 0;
for tiempo = t0:h:tf
    i = i + 1;
    plot3([x0; 0], [y0; 0], [z0; z1], 'g') % Del origen al eslabón 1
    plot3([x1; x2(i)], [y1; y2(i)], [z1; z2(i)], 'r') % Eslabón 2
    plot3([x2(i); x3(i)], [y2(i); y3(i)], [z2(i); z3(i)], 'b') % Eslabón 3
    pause(0.4)
end

q = q * 180 / pi;