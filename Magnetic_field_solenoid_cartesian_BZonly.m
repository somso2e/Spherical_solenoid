function Bz = Magnetic_field_solenoid_cartesian_BZonly(x,y,z,I)

phi = atan2(y,x);
theta= atan2(sqrt(x.^2 + y.^2),z);
r = sqrt(x.^2 + y.^2 + z.^2);
Bz = Magnetic_field_spherical_solenoid_BZonly(r,theta,phi,I);

end