clc
clear
hold on
axis equal

%Set Python interpreter
pyenv(Version="C:\Program Files\Python311\python.exe");

%Projection properties
proj_name = 'sinu'
R = 6380000;

%Test: project + extract arrays from tuple and convert to matrix
vals = py.mk.project(proj_name, R, u, v)
x = double(vals{1});
y = double(vals{2});
a = double(vals{3});
b = double(vals{4});

%Input parameters
R = 6380;
u0 = 0;
u_min = -80;
u_max = 80;
v_min = -180;
v_max = 180;
uk = 90;
vk = 0;
D_u = 10;
D_v = 10;
d_u = 1;
d_v = 1;

%Create meshgrid
[ug, vg] = meshgrid(u_min : d_u : u_max, v_min : d_v : v_max);
grid_py = py.mk.project(proj_name, R, py.numpy.array(ug), py.numpy.array(vg));
xg = double(grid_py{1});
yg = double(grid_py{2});
ag = double(grid_py{3});
bg = double(grid_py{4});

%Airy + complex criteria
h2a = ((ag-1).^2 + (bg-1).^2)/2;
h2c = (abs(ag-1)+abs(bg-1))/2 + ag./bg -1;

%Global criteria (non-weighted)
H2a = mean(h2a(:));
H2c = mean(h2c(:));

%Create graticule
[XM,YM,XP,YP] = graticule_proj(u_min, u_max,v_min, v_max, D_u, D_v, d_u, d_v, R, uk, vk, u0, proj_name);
plot (XM', YM', 'k');
plot (XP', YP', 'k');

%Load continents
uvc = load('amer.txt');
[XC, YC] = sinu(R, uvc(:, 1), uvc(:, 2));
cont = py.mk.project(proj_name, R, uvc(:, 1), uvc(:, 2));

%Extract arrays from tuple and convert to matrix
XC = double(cont{1});
YC = double(cont{2});
plot (XC, YC, 'b', 'LineWidth', 2);

%Variable map scale
M = 100000000;
Muv = M./ag;

%Draw contour lines
[C, h] = contour(xg, yg, Muv, [20000000:10000000:100000000], 'LineColor', 'r', 'LineWidth', 2);
%[C2, h2] = contour(xg, yg, dist, [-1:0.5:10], 'LineColor', 'r', 'LineWidth', 2);
clabel(C, h, 'Color', 'r', 'labelspacing', 1000);
