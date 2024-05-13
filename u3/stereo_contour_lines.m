clc
clear
hold on

%Load data
N = load('nepal.txt') * pi/180;

%Pole + sphere radius
R = 6380000;
uk = 28.1358692*pi/180;
vk = 84.2819261*pi/180;

%Conversion to oblique aspect
un = N(:, 1);
vn = N(:, 2);
[sn, dn] = uv_to_sd(un, vn, uk, vk);

%Project
[xn, yn] = stereo_proj(R, sn, dn);

%Plot
plot(xn, yn,'b');
axis equal;

%Graticule
umin = 25*pi/180;
umax = 32*pi/180;
vmin = 78*pi/180;
vmax = 90*pi/180;
Du = 1*pi/180;
Dv = Du;
du = Du/10;
dv = du;
proj = @stereo_proj;
u0 = 0;

%Compute graticule
[XM, YM, XP, YP, T1, T2] = graticule(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, u0, proj);

%Plot graticule
plot(XM', YM', 'k');
plot(XP', YP', 'k');

%Points
[XM1, YM1, XP1, YP1, S1, D1] = graticule(umin, umax, vmin, vmax, Du/10, Dv/10, Du/10, Dv/10, R, uk, vk, u0, proj);

%Distortion
psi0 = 0.0457874886968716;
psi = pi/2 - S1;
m = (cos(psi0/2)./cos(psi/2)).^2;
ny = (m - 1)*1000;

%Contour lines
dm = 0.1;
[C,h] = contour(XM1, YM1, ny, [-2: dm: 10], 'LineColor', 'r');
[C2,h2] = contour(XM1, YM1, ny, [-2: 5*dm: 10], 'LineColor', 'r', 'LineWidth', 2);
clabel(C2, h2, 'Color', 'r');



