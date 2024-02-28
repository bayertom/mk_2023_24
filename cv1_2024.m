clc
clear

format long g

%Vstupni body
phi_WGS = 50;
la_WGS = 15;

%Konverze, radiany
phir_WGS = phi_WGS*pi/180;
lar_WGS = la_WGS*pi/180;

%WGS 84, parametry
a_WGS = 6378137.0000; 
b_WGS = 6356752.3142;
e2_WGS = (a_WGS*a_WGS - b_WGS*b_WGS)/(a_WGS*a_WGS);
W_WGS = sqrt(1-e2_WGS*(sin(phir_WGS))^2);
N_WGS = a_WGS/W_WGS;

%Prostorove geocentricke souradnice
X_WGS =  N_WGS*cos(phir_WGS)*cos(lar_WGS);
Y_WGS =  N_WGS*cos(phir_WGS)*sin(lar_WGS);
Z_WGS =  N_WGS*(1-e2_WGS)*sin(phir_WGS);

%Helmertova transformace, 7 parametrů
om_x = 4.9984/3600*pi/180;
om_y = 1.5867/3600*pi/180;
om_z = 5.2611/3600*pi/180;
m = 1-3.5623e-6;
dx = -570.8285;
dy = -85.6769;
dz = -462.8420;

%Helmertova transformace
R = [1,om_z,-om_y;-om_z,1,om_x;om_y,-om_x,1];
delta = [dx;dy;dz];
xyz_wgs = [X_WGS;Y_WGS;Z_WGS];
xyz_bess =m*R*xyz_wgs+delta;








