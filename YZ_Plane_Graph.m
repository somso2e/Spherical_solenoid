% For drawing the contour plot and quiver plot of By and Bz component on
% the X=0 plane
n = 14;
step = 0.35;
M = 2 * n ./ step + 1;
m = n ./ step + 1;

BY = zeros(M, M);
BZ = zeros(M, M);
BX = zeros(M, M);

parfor column = 1:m
    y = -n + (column - 1) .* step;

    Bxrow = zeros(M, 1);
    Byrow = zeros(M, 1);
    Bzrow = zeros(M, 1);

    for row = 1:m

        z = -n + (row - 1) .* step;

        [By, Bz] = Magnetic_field_solenoid_cartesian_YZonly(0, y, z, 1);
        Byrow(row) = By;
        Bzrow(row) = Bz;
    end

    BY(:, column) = Byrow;
    BZ(:, column) = Bzrow;

end

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

for i = 1:m
    BY(:, M + 1 - i) = BY(:, i);
end

for i = 1:m
    BY(M + 1 - i, :) = -BY(i, :);
end

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
for i = 1:2 * n + 1
    BZ(:, M + 1 - i) = BZ(:, i);
end

for i = 1:2 * n + 1
    BZ(M + 1 - i, :) = BZ(i, :);
end

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

figure(1)

zp = -n:step:n;
yp = -n:step:n;
limy1 = min(min(BY));
limy2 = max(max(BY));
T1 = linspace(limy1, limy2, 100);

contour(zp, yp, BY, T1);
axis([-n n -n n]);
hold on
solenoid_shape_YZ();
pbaspect([1, 1, 1]);

xlabel('Y-axis', 'fontsize', 14);
ylabel('Z-axis', 'fontsize', 14);
title('BY component on X=0 plane', 'fontsize', 14);
colorbar('location', 'eastoutside', 'fontsize', 14);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

figure(2)

zp = -n:step:n;
yp = -n:step:n;
limz1 = min(min(BZ));
limz2 = max(max(BZ));
T2 = linspace(limz1, limz2, 100);

contour(zp, yp, BZ, T2);
axis([-n n -n n]);
hold on
solenoid_shape_YZ();
pbaspect([1, 1, 1]);
xlabel('Y-axis', 'fontsize', 14);
ylabel('Z-axis', 'fontsize', 14);
title('BZ component on X=0 plane', 'fontsize', 14);
colorbar('location', 'eastoutside', 'fontsize', 14);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

figure(3)
quiver(zp, yp, BY, BZ, 4);

title('quiver plot of the field on the X=0 plane');
pbaspect([1, 1, 1]);
axis([-8 8 -8 8]);