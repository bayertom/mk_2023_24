clc
clear

% Global parameters
Du = 10*pi/180;
Dv = Du;
du = pi/180;
dv = du;
R = 1;
proj = @gnom;
u0 = 0;
us = (35.2644 * pi / 180);
uj = -us;

%Face 1 parameters
umin = 30*pi/180;
umax = pi/2;
vmin = 0;
vmax = 2*pi;
uk = pi/2;
vk = 0;
ub = [us, us, us, us, us];
vb = [0, pi / 2, pi, 3 * pi / 2, 0];
globeFace(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, u0, proj, ub, vb);

