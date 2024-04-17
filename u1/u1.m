clc
clear

format long g

%Input points
phi1_WGS = 50; la1_WGS = 15;
phi2_WGS = 50.5; la2_WGS = 15.5;

[x1, y1, mr1, conv1] = WGSToJTSK(phi1_WGS, la1_WGS)
[x2, y2, mr2, conv2] = WGSToJTSK(phi2_WGS, la2_WGS)

[x3, y3, mr3, conv3] = BessToJTSK(phi1_WGS, la1_WGS)
[x4, y4, mr4, conv4] = BessToJTSK(phi2_WGS, la2_WGS)

[x5, y5, mr5, conv5] = SphereToJTSK(phi1_WGS, la1_WGS)
[x6, y6, mr6, conv6] = SphereToJTSK(phi2_WGS, la2_WGS)

%Differences in coordinates
dx1 = x3 - x1;
dy1 = y3 - y1;
dx2 = x4 - x2;
dy2 = y4 - y2;
dx3 = x6 - x4;
dy3 = y6 - y4;

%Differences in distances
d1 = sqrt(dx1^2 + dy1^2);
d2 = sqrt(dx2^2 + dy2^2);
d3 = sqrt(dx3^2 + dy3^2);

dd1 = d2 - d1
dd2 = d3 - d1

function [x, y, mr1, conv1] = WGSToJTSK(phi_WGS, la_WGS)

%Radians
phir_WGS = phi_WGS*pi/180;
lar_WGS = la_WGS*pi/180;

%WGS 84, parameters
a_WGS = 6378137.0000; 
b_WGS = 6356752.3142;
e2_WGS = (a_WGS*a_WGS - b_WGS*b_WGS)/(a_WGS*a_WGS);
W_WGS = sqrt(1-e2_WGS*(sin(phir_WGS))^2);
N_WGS = a_WGS/W_WGS;

%Geocentric coordinates, WGS84
X_WGS =  N_WGS*cos(phir_WGS)*cos(lar_WGS);
Y_WGS =  N_WGS*cos(phir_WGS)*sin(lar_WGS);
Z_WGS =  N_WGS*(1-e2_WGS)*sin(phir_WGS);

%Helmert transformation, 7 parameters
om_x = 4.9984/3600*pi/180;
om_y = 1.5867/3600*pi/180;
om_z = 5.2611/3600*pi/180;
m = 1-3.5623e-6;
dx = -570.8285;
dy = -85.6769;
dz = -462.8420;

%Perform Helmert transformation
R = [1,om_z,-om_y;-om_z,1,om_x;om_y,-om_x,1];
delta = [dx;dy;dz];
xyz_wgs = [X_WGS;Y_WGS;Z_WGS];
xyz_bess =m*R*xyz_wgs+delta;

%Geocentric coordinates, Bessel
X_B = xyz_bess(1);
Y_B = xyz_bess(2);
Z_B = xyz_bess(3);

%Bessel elipsoid, parameters
a_B = 6377397.1550;
b_B = 6356078.9633;
e2_B = (a_B*a_B - b_B*b_B)/(a_B*a_B);

%Transformation (X, Y, Z)B -> (phi, la)
lar_B = atan2(Y_B, X_B);
phir_B = atan2 (Z_B, (1-e2_B)*sqrt(X_B^2+Y_B^2));

%Reduction to Ferro
larf_B = lar_B + (17+2/3)*pi/180;

%Gaussian conformal projection, parameters
phir_0 = 49.5 * pi/180;
alpha = sqrt(1+(e2_B*(cos(phir_0))^4)/(1-e2_B));
u0_r = asin(sin(phir_0)/alpha);
kn = (tan(phir_0/2 + pi/4))^alpha*((1-sqrt(e2_B)*sin(phir_0))/(1+sqrt(e2_B)*sin(phir_0)))^(alpha*sqrt(e2_B)/2);
kd = tan(u0_r/2+pi/4);
k = kn/kd;
R = (a_B* sqrt(1-e2_B))/(1-e2_B*(sin(phir_0))^2);

%Gaussian conformal projection,
arg = 1/k*(tan(phir_B/2+pi/4)*((1-sqrt(e2_B)*sin(phir_B))...
      /(1+sqrt(e2_B)*sin(phir_B)))^(sqrt(e2_B)/2))^alpha;
u = 2*(atan(arg)-pi/4);
v = alpha * larf_B;

%Transformation to oblique aspect
uk = (59 + 42 / 60 + 42.6969 / 3600) * pi/180;
vk = (42 + 31 / 60 + 31.41725 / 3600) * pi/180;
[s, d] = uv_to_sd(u, v, uk, vk);

%LCC
s0r = 78.5 * pi / 180;   
c = sin(s0r);
rho0 = 0.9999 * R * cot(s0r);

rho = rho0*((tan(s0r/2 +pi/4))/(tan(s/2 +pi/4)))^c;
eps = c * d;

%Conversion to Cartesian coordinates
x = rho*cos(eps);
y = rho*sin(eps);

%Local linear scale
mr1 = (c * rho) / (R * cos(s));

delta_rho = (rho - rho0) / 100000
mr2 = 0.9999+0.00012282*delta_rho^2 - 0.00000315*delta_rho^3+0.00000018*delta_rho^4

%Convergence
ksi = asin(cos(uk) * sin(pi -d)/cos(u))
conv1 = (eps - ksi)*180/pi;
conv2 = 0.008257*y/1000 + 2.373*y/x;

end

function [x, y, mr1, conv1] = BessToJTSK(phi_B, la_B)

%Radians
phir_B = phi_B*pi/180;
lar_B = la_B*pi/180;

%Bessel elipsoid, parameters
a_B = 6377397.1550;
b_B = 6356078.9633;
e2_B = (a_B*a_B - b_B*b_B)/(a_B*a_B);

%Reduction to Ferro
larf_B = lar_B + (17+2/3)*pi/180;

%Gaussian conformal projection, parameters
phir_0 = 49.5 * pi/180;
alpha = sqrt(1+(e2_B*(cos(phir_0))^4)/(1-e2_B));
u0_r = asin(sin(phir_0)/alpha);
kn = (tan(phir_0/2 + pi/4))^alpha*((1-sqrt(e2_B)*sin(phir_0))/(1+sqrt(e2_B)*sin(phir_0)))^(alpha*sqrt(e2_B)/2);
kd = tan(u0_r/2+pi/4);
k = kn/kd;
R = (a_B* sqrt(1-e2_B))/(1-e2_B*(sin(phir_0))^2);

%Gaussian conformal projection,
arg = 1/k*(tan(phir_B/2+pi/4)*((1-sqrt(e2_B)*sin(phir_B))...
      /(1+sqrt(e2_B)*sin(phir_B)))^(sqrt(e2_B)/2))^alpha;
u = 2*(atan(arg)-pi/4);
v = alpha * larf_B;

%Transformation to oblique aspect
uk = (59 + 42 / 60 + 42.6969 / 3600) * pi/180;
vk = (42 + 31 / 60 + 31.41725 / 3600) * pi/180;
[s, d] = uv_to_sd(u, v, uk, vk);

%LCC
s0r = 78.5 * pi / 180;   
c = sin(s0r);
rho0 = 0.9999 * R * cot(s0r);

rho = rho0*((tan(s0r/2 +pi/4))/(tan(s/2 +pi/4)))^c;
eps = c * d;

%Conversion to Cartesian coordinates
x = rho*cos(eps);
y = rho*sin(eps);

%Local linear scale
mr1 = (c * rho) / (R * cos(s));

delta_rho = (rho - rho0) / 100000
mr2 = 0.9999+0.00012282*delta_rho^2 - 0.00000315*delta_rho^3+0.00000018*delta_rho^4

%Convergence
ksi = asin(cos(uk) * sin(pi -d)/cos(u))
conv1 = (eps - ksi)*180/pi;
conv2 = 0.008257*y/1000 + 2.373*y/x;

end


function [x, y, mr1, conv1] = SphereToJTSK(u, v)

%Radians
u = u*pi/180;
v = v*pi/180;

%Reduction to Ferro
vf = v + (17+2/3)*pi/180;

%Transformation to oblique aspect
uk = (59 + 42 / 60 + 42.6969 / 3600) * pi/180;
vk = (42 + 31 / 60 + 31.41725 / 3600) * pi/180;
[s, d] = uv_to_sd(u, vf, uk, vk);

%LCC
R = 6380703.6104635;
s0r = 78.5 * pi / 180;   
c = sin(s0r);
rho0 = 0.9999 * R * cot(s0r);

rho = rho0*((tan(s0r/2 +pi/4))/(tan(s/2 +pi/4)))^c;
eps = c * d;

%Conversion to Cartesian coordinates
x = rho*cos(eps);
y = rho*sin(eps);

%Local linear scale
mr1 = (c * rho) / (R * cos(s));

delta_rho = (rho - rho0) / 100000
mr2 = 0.9999+0.00012282*delta_rho^2 - 0.00000315*delta_rho^3+0.00000018*delta_rho^4

%Convergence
ksi = asin(cos(uk) * sin(pi -d)/cos(u))
conv1 = (eps - ksi)*180/pi;
conv2 = 0.008257*y/1000 + 2.373*y/x;

end




