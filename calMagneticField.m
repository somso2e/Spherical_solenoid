function varargout = calMagneticField(arg1, arg2, arg3, I, varargin)
    switch nargin
        case 4
            coords = "polar";
            requiredDims = [1 1 1];

        case 5
            if (strcmpi(varargin{1}, "cartesian") || strcmpi(varargin{1}, "polar"))
                coords = varargin{1};
                requiredDims = [1 1 1];
            elseif ismember('xyz', varargin{1})
                requiredDims = ismember('xyz', varargin{1});
            else
                error("Invalid input");
            end

        case 6
            requiredDims = ismember('xyz', varargin{1});
            coords = varargin{2};

        otherwise
            error("too many  input arguments");
    end

    if (sum(requiredDims) ~= nargout)
        error("Not Enough output arguments defined.");
    end
    if strcmpi(coords, "cartesian")
        phi0 = atan2(arg2, arg1);
        theta0 = atan2(sqrt(arg1.^2 + arg2.^2), arg3);
        r0 = sqrt(arg1.^2 + arg2.^2 + arg3.^2);
    else
        r0=arg1;
        theta0=arg2;
        phi0=arg3;
        % phi0 = arg1;
        % theta0 = arg2;
        % r0 = arg3;
    end
    mu0 = 4 * pi;

    %radius of the spherical coil
    B = 5;
    %number of loops in the solenoid
    n = 50;
    dB1t = 0;
    dB2t = 0;
    dB3t = 0;
    syms phi z0
    %The radius of the loop at the height of z0
    b = sqrt(B.^2 - z0.^2);

    % dl in the spherical coordinates is " b*d(phi)*a(phi) "
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

        db1 = mu0 .* I .* Cross_result2(1, 1) / (4 .* pi .* R_distance2.^3);
        db2 = mu0 .* I .* Cross_result2(1, 2) / (4 .* pi .* R_distance2.^3);
        db3 = mu0 .* I .* Cross_result2(1, 3) / (4 .* pi .* R_distance2.^3);

        dB1t = dB1t + db1;
        dB2t = dB2t + db2;
        dB3t = dB3t + db3;
    end
    arg = 1;
    if requiredDims(1)
        if dB1t ~= 0 && ~isnan(dB1t)
            B1t = matlabFunction(dB1t);
            B1 = integral(B1t, 0, 2 * pi);
        else
            B1 = 0;
        end
        varargout{arg} = B1;
        arg = arg + 1;
    end

    if requiredDims(2)
        if dB2t ~= 0 && ~isnan(dB2t)
            B2t = matlabFunction(dB2t);
            B2 = integral(B2t, 0, 2 * pi);
        else
            B2 = 0;
        end
        varargout{arg} = B2;
        arg = arg + 1;
    end
    if requiredDims(3)
        if dB3t ~= 0 && ~isnan(dB3t)
            B3t = matlabFunction(dB3t);
            B3 = integral(B3t, 0, 2 * pi);
        else
            B3 = 0;
        end
        varargout{arg} = B3;
    end

end
