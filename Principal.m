clear;
clc;

% Definir las longitudes


% Crear enlaces con parámetros DH
L(1) = Link([0 L1 L2 pi/2 0]);
L(2) = Link([0 0 L3 0 0]);
L(3) = Link([0 0 L4 0 0]);
RB = SerialLink(L, 'name', 'MiRobot');

% Definir el espacio de trabajo
workspace = [-500 500 -500 500 0 1000];

while (true)
    clc;
    disp('Seleccionar modo de simulación:');
    disp('1. Cinemática Directa');
    disp('2. Cinemática Inversa');
    disp('0. Salir');
    mode = input('Ingrese la opción: ');

    if mode == 0
        break;
    elseif mode == 1
        L1 = 129;
        L2 = 14;
        L3 = 120;
        L4 = 122;
        l = [L1; L2; L3; L4];

        % Obtener entradas para cinemática directa
        q1 = input('Ingrese el valor de q1 (en grados): ');
        q2 = input('Ingrese el valor de q2 (en grados): ');
        q3 = input('Ingrese el valor de q3 (en grados): ');
        % Definir el espacio de trabajo
        workspace = [-500 500 -500 500 0 1000];
        % Convertir a radianes
        q1 = deg2rad(q1);
        q2 = deg2rad(q2);
        q3 = deg2rad(q3);

        % Configuración de las articulaciones
        q = [q1 q2 q3];

        % Graficar el robot
        RB.plot(q, 'workspace', workspace);

        % Cinemática Directa
        syms theta d a alpha real
        A = [cos(theta), -sin(theta)*cos(alpha), sin(theta)*sin(alpha), a*cos(theta);
             sin(theta), cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta);
             0, sin(alpha), cos(alpha), d;
             0, 0, 0, 1];

        % Definir los parámetros DH para cada articulación
        A01 = subs(A, {theta, d, a, alpha}, {q1, L1, L2, pi/2});
        A12 = subs(A, {theta, d, a, alpha}, {q2, 0, L3, 0});
        A23 = subs(A, {theta, d, a, alpha}, {q3, 0, L4, 0});

        % Matriz de transformación total
        T = simplify(A01 * A12 * A23);

        % Extraer las posiciones
        Kpx = double(T(1, 4));
        Kpy = double(T(2, 4));
        Kpz = double(T(3, 4));
        P = [Kpx; Kpy; Kpz];

        disp('Posición calculada (Cinemática Directa):');
        disp(['x: ', num2str(Kpx)]);
        disp(['y: ', num2str(Kpy)]);
        disp(['z: ', num2str(Kpz)]);
    elseif mode == 2
        % Obtener entradas para cinemática inversa
        x = input('Ingrese la posición x: ');
        y = input('Ingrese la posición y: ');
        z = input('Ingrese la posición z: ');
        p = [x; y; z];

        % Cinemática Inversa (asegúrate de tener definida la función Inversa_q1_q2_q3)
        [q1, q2, q3] = Inversa_q1_q2_q3(p, l);

        % Mostrar los ángulos calculados
        disp('Ángulos calculados (Cinemática Inversa):');
        disp(['q1: ', num2str(rad2deg(q1)), ' grados']);
        disp(['q2: ', num2str(rad2deg(q2)), ' grados']);
        disp(['q3: ', num2str(rad2deg(q3)), ' grados']);

        % Configuración de las articulaciones
        q = [q1 q2 q3];

        % Graficar el robot
        RB.plot(q, 'workspace', workspace);
    else
        disp('Opción no válida. Por favor intente nuevamente.');
    end

    % Pausar para permitir la visualización
    pause;
end

disp('Simulación finalizada.');