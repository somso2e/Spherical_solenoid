n = 14;
step = 0.35;
M = 2 * n ./ step + 1;
m = n ./ step + 1;

BZ2 = zeros(M, M);

parfor column = 1:m
    y = -n + (column - 1) .* step;
    Bzrow = zeros(M, 1);
    for row = 1:m
        x = -n + (row - 1) .* step;
        Bz = calMagneticField(x, y, 0, 1, 'z', "cartesian");
        Bzrow(row) = Bz;
    end
    BZ2(:, column) = Bzrow;
end
% % % % % % %
for i = 1:m
    BZ2(:, M + 1 - i) = BZ2(:, i);
end

for i = 1:m
    BZ2(M + 1 - i, :) = BZ2(i, :);
end
% % % % % % % %
save BZ2.mat
% % % % % % % %
figure(1)
xp = -n:step:n;
yp = -n:step:n;
limz1 = min(min(BZ2));
limz2 = max(max(BZ2));
T2 = linspace(limz1, limz2, 100);

contour(xp, yp, BZ2, T2);
axis([-n n -n n]);
pbaspect([1 1 1]);

drawSolenoidShapeXY();

xlabel('X-axis', 'fontsize', 14);
ylabel('Y-axis', 'fontsize', 14);
title('BZ component on Z=0 plane', 'fontsize', 14);
colorbar('location', 'eastoutside', 'fontsize', 14);
