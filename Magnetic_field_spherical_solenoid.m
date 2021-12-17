function [Bx, By, Bz] = Magnetic_field_spherical_solenoid(r0, theta0, phi0, I)

    mu0 = 4 * pi;

    %radius of the spherical coil
    B = 5;
    %number of loops in the solenoid
    n = 50;
    dBxt = 0;
    dByt = 0;
    dBzt = 0;
    syms phi z0
    %The radius of the loop at the height of z0
    b = sqrt(B.^2 - z0.^2);

    % dl in the spherical coordinates is " b*d(phi)*a(phi) ".
    dl = [-b .* sin(phi), b .* cos(phi), 0];

    r = [r0 .* sin(theta0) .* cos(phi0), r0 .* sin(theta0) .* sin(phi0), r0 .* cos(theta0)];
    r_prime = [+b .* cos(phi), +b .* sin(phi), z0];

    
    R = r - r_prime;
    R_distance = (R(1, 1)^2 + R(1, 2)^2 + R(1, 3)^2)^(1/2);
    R_distance1 = matlabFunction(R_distance);

    Cross_result = cross(dl, R);
    Cross_result1 = matlabFunction(Cross_result);

    for z01 = -B:(B / n):B

        R_distance2 = R_distance1(phi, z01);
        Cross_result2 = Cross_result1(phi, z01);

        %     u0 *  I    / dl x R \
        % db= ________ * | ______  | *  d(phi)
        %                |      3  |
        %      4pi       \   |R|   /

        dbx = mu0 .* I .* Cross_result2(1, 1) / (4 .* pi .* R_distance2.^3);
        dby = mu0 .* I .* Cross_result2(1, 2) / (4 .* pi .* R_distance2.^3);
        dbz = mu0 .* I .* Cross_result2(1, 3) / (4 .* pi .* R_distance2.^3);

        dBxt = dBxt + dbx;
        dByt = dByt + dby;
        dBzt = dBzt + dbz;
    end

    if dBxt ~= 0 && isnan(dBxt) == 0
        Bxt = matlabFunction(dBxt);
        Bx = integral(Bxt, 0, 2 * pi);
    else
        Bx = 0;
    end

    if dByt ~= 0 && isnan(dByt) == 0
        Byt = matlabFunction(dByt);
        By = integral(Byt, 0, 2 * pi);
    else
        By = 0;
    end

    if dBzt ~= 0 && isnan(dBzt) == 0
        Bzt = matlabFunction(dBzt);
        Bz = integral(Bzt, 0, 2 * pi);
    else
        Bz = 0;
    end

end
