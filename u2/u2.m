clc
clear

%Input parameters
umin = 30*pi/180;
umax = pi/2;
vmin = 0;
vmax = 2*pi;
Du = 10*pi/180;
Dv = Du;
du = pi/180;
dv = du;
R = 1;
uk = pi/2;
vk = 0;
proj = @gnom;
u0 = 0;

%Compute graticule
[XM, YM, XP, YP] = graticule(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, u0, proj);

%Plot graticule
hold on
plot(XM', YM', 'k');
plot(XP', YP', 'k');

%Compute continents
C = load('continents_points\eur.txt');
C = C * pi / 180;

%Plot continents
[XC, YC] = continents(C, R, uk, vk,u0, proj);
plot(XC', YC', 'b');

%Compute face boundary
us = (35.2644 * pi / 180);
ub = [us, us, us, us, us];
vb = [0, pi / 2, pi, 3 * pi / 2, 0];       % face polygon coordinates
[XB, YB] = boundary(ub, vb, R, uk, vk,u0, proj);

%Plot face boundary
plot(XB', YB', 'r');

axis equal;





