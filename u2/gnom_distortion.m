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

%Area scale
mp = simplify(sqrt(mp2));
mr = simplify(sqrt(mr2));
P1 = simplify(mp * mr, 'Steps', 20);
P2 = simplify((gu * fv - gv * fu)/(R*R*cos(u)));

%Max angular distortion
d_omega = simplify(2*asin(abs(mp-mr)/(mp+mr)));

%Convergence
c = simplify(atan(gu/ fu));







