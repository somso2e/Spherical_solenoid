r = 5;
a = 5;
t = 0:pi / 100:2 * pi;

for j = 1:4
    r = r * j;
    x = (r .* cos(t) + r);
    y = (r .* cos(t) + r);
    z = a .* r .* sin(t);

    hold on
    view(3);

    for i = 1:6
        phi = i * pi / 3;
        X = x .* cos(phi) - y .* sin(phi);
        Y = x .* sin(phi) + y .* cos(phi);
        Z = z;
        plot3(X, Y, Z, 'r')
    end

end
