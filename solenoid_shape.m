t = 0:pi / 100:2 * pi;
b = 5;
hold on
lim = 12;
xlim([-lim, lim]);
ylim([-lim, lim]);
zlim([-lim, lim]);
view(3);
pbaspect([1, 1, 1]);

for z0 = -b:0.5:b
    r = sqrt(b.^2 - z0.^2);
    x = r .* sin(t);
    y = r .* cos(t);
    z = 0 * t;
    solenoid = plot3(x, y, z + z0, 'k');
end
