clc
clear

format long g

%Input points
phi_WGS = 50;
la_WGS = 15;

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

%Compute N
%W_B = sqrt(1-e2_B*(sin(phir_B))^2);
%N_B = a_B/W_B;


