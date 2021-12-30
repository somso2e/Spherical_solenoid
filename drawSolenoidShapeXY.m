function drawSolenoidShapeXY()
    theta = linspace(0, 2 * pi, 50);
    R = linspace(0, 5, 10);
    hold on
    for r = R
        x2 = r .* cos(theta);
        y2 = r .* sin(theta);
        plot(x2, y2, 'k', 'LineWidth', 2);
    end
end
