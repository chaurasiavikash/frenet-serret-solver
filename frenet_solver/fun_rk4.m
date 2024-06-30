function fval = fun_rk4(s, var_in)
    global kappa tau N

    % Determine the index of the nodal point
    ind = round(s * N) + 1;

    % Get curvature and torsion at the current point
    kappa_i = kappa(ind, 1);
    tau_i = tau(ind, 1);

    % Extract current values of position, tangent, normal, and binormal vectors
    t1x = var_in(4);
    t1y = var_in(5);
    t1z = var_in(6);
    n1x = var_in(7);
    n1y = var_in(8);
    n1z = var_in(9);
    b1x = var_in(10);
    b1y = var_in(11);
    b1z = var_in(12);

    % Define the system of ODEs
    f_r1x = t1x;
    f_r1y = t1y;
    f_r1z = t1z;
    
    f_t1x = kappa_i * n1x;
    f_t1y = kappa_i * n1y;
    f_t1z = kappa_i * n1z;
    
    f_n1x = -kappa_i * t1x + tau_i * b1x;
    f_n1y = -kappa_i * t1y + tau_i * b1y;
    f_n1z = -kappa_i * t1z + tau_i * b1z;
    
    f_b1x = -tau_i * n1x;
    f_b1y = -tau_i * n1y;
    f_b1z = -tau_i * n1z;

    % Return the derivatives
    fval = [f_r1x, f_r1y, f_r1z, f_t1x, f_t1y, f_t1z, f_n1x, f_n1y, f_n1z, f_b1x, f_b1y, f_b1z]';
end
