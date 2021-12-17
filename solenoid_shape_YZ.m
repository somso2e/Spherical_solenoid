function solenoid_shape_YZ()
    theta = 0:0.1:2 * pi;
    r = 5;
    x1 = r .* cos(theta);
    y1 = r .* sin(theta);
    plot(x1, y1, 'k');
    hold on

    for z0 = -5:0.5:5
        b = sqrt(25 - z0.^2);
        x2 = -b:0.1:b;
        k = size(x2, 2);
        y2 = ones(1, k) .* z0;
        plot(x2, y2, 'k', 'LineWidth', 2);
    end

end
