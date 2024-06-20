
function [q1, q2, q3] = Inversa_q1_q2_q3(position, lengths)
    % Extraer las longitudes del robot
    L1 = lengths(1);
    L2 = lengths(2);
    L3 = lengths(3);
    L4 = lengths(4);

    % Extraer las posiciones deseadas
    px = position(1);
    py = position(2);
    pz = position(3);

    % Calcular q1
    q1 = atan2(py, px);

    % Calcular los parámetros intermedios
    RT = sqrt(px^2 + py^2) - L2; % Ajuste en L2
    h = pz - L1;
    HT = sqrt(RT^2 + h^2);

    % Calcular q3 utilizando la ley del coseno
    C = (HT^2 - L3^2 - L4^2) / (2 * L3 * L4);
    if abs(C) > 1
        error('La posición deseada está fuera del alcance del robot');
    end
    q33 = (-pi/2)+atan2(sqrt(1 - C^2), C);
    q3=pi/2+q33;
    % Calcular q2
    q2 = (pi/2)+atan2(h, RT) - atan2(L4 * sqrt(1 - C^2), L3 + L4 * C);
end