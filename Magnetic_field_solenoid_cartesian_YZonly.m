function [By, Bz] = Magnetic_field_solenoid_cartesian_YZonly(x, y, z, I)

    phi = atan2(y, x);
    theta = atan2(sqrt(x.^2 + y.^2), z);
    r = sqrt(x.^2 + y.^2 + z.^2);
    [By, Bz] = Magnetic_field_solenoid_spherical_YZonly(r, theta, phi, I);

end
