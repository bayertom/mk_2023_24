clc
clear

%Symbolic variables
syms R u v

%Gnomonic projection
x = R*tan(pi/2-u)*cos(v);
y = R*tan(pi/2-u)*sin(v);

%Partial derivatives
fu = diff(x, u);
fu = simplify(fu, 'Steps', 20)
fv = diff(x,v);
fv = simplify(fv, 'Steps', 20)
gu = diff(y, u);
gu = simplify(gu, 'Steps', 20)
gv = diff(y, v);
gv = simplify(gv, 'Steps', 20)

%Local linear scales
mp2 = simplify((fu*fu + gu*gu)/(R*R))
mr2 = simplify((fv*fv + gv*gv)/(R*cos(u))^2)
p = simplify(2*(fu*fv +gu*gv))
mp = simplify(sqrt(mp2));
mr = simplify(sqrt(mr2));

%Areal scale
P1 = simplify(mp * mr, 'Steps', 20);
P2 = simplify((gu * fv - gv * fu)/(R*R*cos(u)));

%Max angular distortion
d_omega = simplify(2*asin(abs(mp-mr)/(mp+mr)));

%Convergence
sigmap = atan2(gu, fu);
c = simplify(pi/2-sigmap);

%Numerical parameters
Rn = 1;
un = 35.2644 * pi/180;
vn = 3*pi/4;
format long g

%Analyzed point
xn = double(subs(x, {R, u, v}, {Rn, un, vn}));
yn = double(subs(y, {R, u, v}, {Rn, un, vn}));

%Partiqal derivatives
fun = double(subs(fu, {R, u, v}, {Rn, un, vn}));
fvn = double(subs(fv, {R, u, v}, {Rn, un, vn}));
gun = double(subs(gu, {R, u, v}, {Rn, un, vn}));
gvn = double(subs(gv, {R, u, v}, {Rn, un, vn}));

%Local Linear Scales
mpn = double(subs(mp, {R, u, v}, {Rn, un, vn}));
mrn = sqrt((fvn*fvn + gvn*gvn)/(Rn*cos(un))^2);
pn = double(subs(p, {R, u, v}, {Rn, un, vn}));

%Area scale
P1n = double(subs(P1, {R, u, v}, {Rn, un, vn}));
P2n = double(subs(P2, {R, u, v}, {Rn, un, vn}));

%Maximum angular distortion
d_omegan = double(subs(d_omega, {R, u, v}, {Rn, un, vn}));

%Convergence
sigmapn = double(subs(sigmap, {R, u, v}, {Rn, un, vn}));
cn = double(subs(c, {R, u, v}, {Rn, un, vn}));

%Azimuths
A1 = (atan2(pn,(mpn^2-mrn^2)))/2;

%Tissot's indicatrix
t = 0:pi/12:2*pi;
xe = mpn * cos(t) * 0.1;
ye = mrn * sin(t) * 0.1;

%Plot of the Tissot's indicatri
hold on
%plot(xe, ye, 'r');

%Rotate ellipse
xer = xe * cos(sigmapn) - ye * sin(sigmapn);
yer = xe * sin(sigmapn) + ye * cos(sigmapn);

%plot(xer, yer);

%Shift elipse
xers = xer + xn;
yers = yer + yn;

plot(xers, yers, 'r', 'LineWidth', 2);
axis equal

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















