function dq = fcn_control_cinematico(t, u)
    % Declarar las dimensiones del Robot
    L1 = 129; % mm
    L2 = 14;  % mm
    L3 = 120; % mm
    L4 = 122; % mm

    % Entradas de la función
    q1 = u(1);  
    q2 = u(2);
    q3 = u(3);

    % Evaluar cinemática directa
    x = cos(q1) * (L2 + L4 * cos(q2 + q3) + L3 * cos(q2));
    y = sin(q1) * (L2 + L4 * cos(q2 + q3) + L3 * cos(q2));
    z = L1 + L4 * sin(q2 + q3) + L3 * sin(q2);
    X = [x; y; z];

    % Declarar el Jacobiano calculado
    J = [
         -sin(q1) * (L2 + L4 * cos(q2 + q3) + L3 * cos(q2)), -cos(q1) * (L4 * sin(q2 + q3) + L3 * sin(q2)), -L4 * sin(q2 + q3) * cos(q1);
          cos(q1) * (L2 + L4 * cos(q2 + q3) + L3 * cos(q2)), -sin(q1) * (L4 * sin(q2 + q3) + L3 * sin(q2)), -L4 * sin(q2 + q3) * sin(q1);
                                                    0,            L4 * cos(q2 + q3) + L3 * cos(q2),          L4 * cos(q2 + q3)
    ];

    % Calcular la pseudoInversa del jacobiano usando pinv
    JT = pinv(J);

    % Definición de la trayectoria en el espacio cartesiano
    % Para este caso una linea recta en el plano z=10;
    xd = 100;
    yd = 100;
    zd = 200;
    Xd = [xd; yd; zd]; % posición deseada

    xd_d = 0;
    yd_d = 0;
    zd_d = 0;
    Xd_d = [xd_d; yd_d; zd_d]; % velocidad deseada

    % Definición de la matriz de ganancia del controlador
    K =  [6, 0, 0; 
          0, 6, 0; 
          0, 0, 6];
    % Cálculo de la función dq y declaración de salida
    error = Xd - X;
    dq = JT * (Xd_d + K * error);

    % Asegurarse de que la salida sea un vector columna
    dq = dq(:);
end
